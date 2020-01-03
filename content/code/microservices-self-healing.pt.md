+++
title = "Microserviços com 'Auto Cura'"
date = 2020-01-03

[taxonomies]
tags = ["microserviços", "auto cura", "artefatos"]
+++

As [discussões](@/code/microservices-artifact-input-state.pt.md)
[anteriores](@/code/microservices-artifact-ejection.pt.md) que eu levantei
sobre microserviços foram um prelúdio para uma coisa que eu não consegui uma
solução perfeita: como é que microserviços se "curam" quando faltam dados?

<!-- more -->

Pequena recapitulação antes de falar sobre o problema: Microserviços produzem
artefatos; artefatos ou são enviados para frente por um message broker para
outros serviços ou mantidos no mesmo microserviço para requisições futuras;
microserviços podem escutar mais de uma fonte de dados para construir seus
artefatos.

Anteriormente eu mencionei um exemplo de um microserviço de placares que
produz um artefato com o placar de cada time e o nome dos jogadores que
fizeram os gols. Esse microserviço poderia ouvir:

1. A fila de times: pode ser necessária para que possamos mostrar o nome ou
   sigla do time na requisição de placar; uma vez que um time aparece num
   campeonato, o microserviço adiciona o mesmo no seu estado para referência
   futura[^1].
2. A file da jogadores: o mesmo que acima, para que o microserviço possa
   retornar o nome, apelido, número da camisa ou alguma coisa relacionada com
   o jogador; de novo, o serviço fica escutando a fila de jogadores e os
   guarda em seu estado.
3. A fila de partidas: se uma partida for acontecer, ela tem que ter um
   placar, provavelmente começando com 0 sem nenhum jogador na lista de gols;
   isso é feito apenas para evitar problemas com serviços pedindo placares de
   partidas que ainda não começaram ou que não tiveram gols ainda; de qualquer
   forma, o artefato necessário já vai estar pronto para ser entregue.
4. A fila de narrações: escutando a fila de narrações, o microserviço de
   placar irá detectar gols, atualizar seu estado e produzir o artefato
   atualizado.

A palavra chave da lista acima é "poderia": dependendo da forma como os
microserviços _e_ as mensagens são construídas, pode não ser necessário ter
acesso a tudo isso.

## Usando mensagens completas

Vamos começar com a forma mais simples de evitar escutar todas essas filas:
utilizando mensagens completas.

Numa mensagem completa, todos os campos relacionados são enviados junto com a
informação principal. Usando o exemplo acima, o serviço poderia ouvir apenas
as filas de partidas e narração, mas esperar que a mensagem de "NovaPartida"
teria os nomes dos tipos, suas siglas, escudos, provavelmente o ID e assim
pode diante; da mesma forma para a mensagem de "NovaNarração": ela contém o
nome do jogador, o apelido, número da camisa, ID e assim pode diante.

O problema com mensagens completas é que elas tentem a ficarem maiores com o
tempo: Com mais microserviços sendo adicionados ao sistema, mais campos vai
sendo necessários -- e ignorados por serviços que não os precisam.

O lado positivo de mensagens completas é que um microserviço sempre terá toda
a informação necessária, mantendo o número de filas a serem escutadas baixo.
Esse formato também facilita a adição de outros serviços no sistema: se o
mesmo começar com um estado em branco, ele poderá construir o mesmo a partir
do zero, porque toda a informação _já está lá_.

## Escutar as filas básicas, pedir o resto

Quase como a solução acima, o serviço escuta apenas as filas de narrações e
partidas, mas uma vez que detecta alguma informação faltante (por exemplo, o
evento de narração cita um jogador, mas esse jogador não existe no estado), o
serviço faria uma requisição por essa informação mais "fria" (jogadores, times
e produtos não são atualizados com muita frequência, por exemplo) para outro
serviço e preencheria essa informação no seu estado.

Isso significa que esse microserviço agora, ao invés de saber apenas como
escutar filas, também precisa ter informações de outros serviços (aqueles que
processam e armazenam os dados frios) e suas interfaces -- e, de forma geral,
também requisitaria um serviço de descoberta presente no sistema. Esses
microserviços seriam aqueles de "duas caras", que recebem informações,
armazenam o estado, produzem o artefato mas tem uma interface de requisições
ao invés de simplesmente receber, processar e passar pra frente. Fazer cache
aqui também seria recomendado, para que um serviço não faça um "flood" de
requisições da mesma informação -- e atualizações de tempo em tempo podem
fazer sentido em algumas situações.

As mensagens seria menores (porque é enviado apenas o ID do time/jogador) e a
recuperação de informações acontece apenas quando necessária, mas onde é
reduzido o número de escutas nas filas, é aumentado o número de requisições.
Assim como na utilização de mensagens completas, um novo serviço poderia
facilmente construir seu estado a partir do zero sem qualquer problema -- irá
fazer um monte de requisições, mas terá, eventualmente, todas as informações
necessárias.

## Escutas todas

Essa é exatamente a solução apresentada no exemplo acima: o microserviço fica
escutando todas os eventos das filas com eventos relacionados e constrói o
estado a partir deles.

Um problema dessa solução: uma vez que as filas são assíncronas, pode
acontecer um problema com a ordenação dos dados, com gols chegando antes dos
jogadores (por vários motivos). Nesse caso... o que o serviço faz? Rejeita o
gol na esperança que o jogador apareça, para evitar uma inconsistência dos
dados, e o que o message broker coloque o evento novamente no fim da fila?

Uma solução seriam serviços que, junto com este, escutem por um dado
específico: o microserviço de placares escuta as quatro filas citadas, mas há
um microserviço escutando apenas a fila de jogadores. Esse serviço iria
processar os dados mais rapidamente que o placar, e serviria como "fallback"
no caso de dados faltantes, como na solução acima. Isso reduziria o tráfego de
rede, mas iria gerar dados duplicados em serviços diferentes -- embora esse
último ponto não deveria ser um problema em primeiro lugar.

Novos serviços iriam encontrar problemas, porque apesar de receberem
novos dados, eles não estavam presentes quando os dados frios foram
processados; eles vão precisar se comunicar com outros serviços para recuperar
essa informação, ou alguém teria que manualmente copiar os dados.

## Fila única

As soluções acima trabalham com cada dado em sua própria fila, mas e se
pudéssemos colocar _todos_ os eventos na mesma fila? Dessa forma, a ordenação
é assegurada (jogadores são sempre enfileirados antes dos gols, e os serviços
irão processar os jogadores antes de sequer verem que há um gol).

Isso reduz o número de filas a serem ouvidas, mas requer um bom design de
mensagens, especialmente se for utilizada alguma linguagem de tipagem
estática, que normalmente requer uma estrutura bem definida para serialização
e desserialização.

Mas ao mesmo tempo, resolve praticamente todos os problems: não existe
problema com a ordem de processamento, o número de filas a serem ouvidas é
baixo e as mensagens pequenas. Mas também faz com que novos serviços sofram
com a falta de dados frios, forçando-os a comunicar com outros serviços ou
terem os dados copiados manualmente quando levantados.

# E qual o melhor?

Honestamente, não faço ideia. Eu tenho uma certa preferência pelas mensagens
completas simplesmente porque simplifica a estrutura dos serviços, mesmo
sabendo que rede não é de graça; se eu usasse uma linguagem dinâmica, eu
provavelmente utilizaria a fila única. Mas, de novo, não acho que haja um
"tamanho único para todos".

Provavelmente existem outras opções arquiteturais para resolver esses
problemas, mas essas são as que eu consigo lembrar das conversas que tivemos
no trabalho.

[^1]: Vale notar que o microserviço pode simplesmente ignorar parte da
  informação. Por exemplo, se o artefato produzido tem apenas a sigla do time,
  o serviço pode remover o nome completamente de seu estado.
