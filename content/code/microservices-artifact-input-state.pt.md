+++
title = "Microserviços: Artefato = Entrada + Estado"
date = 2019-12-26

[taxonomies]
tags = ["microserviços", "artefatos", "estado"]
+++

Projetar microserviços é um pouco complicado porque temos que pensar sobre
as coisas que cada "domínio" vai ocupar. Uma discussão entre os
desenvolvedores aqui sobre nossos projetos de microserviços me levou a
repensar como pensar microserviços.

<!-- more -->

Isso pode soar um pouco estranho para aqueles que já estão trabalhando com
microserviços -- ou que conseguiram ter uma boa visão da construção de
microserviços -- mas quando foi citado "artefato" na discussão, "caiu a ficha"
com outras coisas que eu estava pensando sobre o tópico.

Um fato que continua me confundindo é que a literatura sobre microserviços
começa a falar sobre "separação de domínios" e como definir cada domínio.
Embora haja alguns truques -- como "se é um substantivo, é um domínio" -- nada
é realmente tão óbvio. Alguns domínios são, na verdade, sub domínios de um
domínio maior, e aí você fica se perguntando se deve separar esses domínios ou
mantê-los num único microserviço, já que separá-los iria, invariavelmente,
criar microserviços acoplados (algo que você quer evitar quando está usando
microserviços).

E é aí que "artefato" encaixou no resto das coisas. Por algum tempo, eu tive a
impressão que microserviços tem que ser construídos "de trás pra frente", no
sentido de que primeiro você precisa pensar nas coisas que você _precisa_ e
depois verificar o que você _tem_ -- em outras palavras, você pensa primeiro
nas saídas do microserviço e depois olha o que tem de entrada. E um "artefato"
é, no final, simplesmente a saída do microserviço.

No nosso caso, nós estamos lidado com jogos. Cada jogo tem uma narração, tem
um placar, tem estatística e tem uma escalação. Mesmo que essa explicação
caia na regra do "é um substantivo!", na verdade ela reflete a saída do nosso
sistema: nos temos uma requisição que retorna a narração atual do jogo (que
pode ser atualizada por polling ou -- como estamos trabalhando agora -- feito
"push" diretamente para os clientes); uma requisição para retornar o placar
(que, de novo, pode ser por "polling" ou "push"); uma requisição que retorna
as estatísticas, que não são atualizadas ou exibidas de forma tão frequente,
e por isso não precisam de atualizações visuais constantes; e assim por
diante. Cada um desses é um microserviço diferente, porque cada um desses é um
artefato diferente.

Bom, se esses são os artefatos, onde é que o "estado" entra nessa história? O
estado é o conjunto de informações que o microserviço precisa ter para
produzir o artefato. Por exemplo, na narração, cada vez que uma nova narração
entra, ela precisa entrar na lista de narrações do jogo para que seja
produzida a narração da partida inteira. O estado também pode ajudar o
microserviço a remover narrações duplicadas.

Um efeito "legal" do estado é que você pode, pelo menos na teoria, perceber
que mesmo com uma nova entrada, se não houve alteração do estado, então não
vai haver alteração do artefato e não é preciso ter nenhuma saída.

Outra coisa a se ter em mente sobre o estado é que ele não precisa ser mantido
em memória; você pode usar qualquer tipo de armazenamento: mantenha as
narrações num banco de dados, no disco, na memória em cache ou todos os
anteriores. Decida usar o que ficar mais _fácil_ de ser manipulado para
produzir o artefato. Uma coisa a se manter em mente sobre isso é "Se esse
microserviço morrer, ele vai conseguir voltar ao mesmo estado quando for
reiniciado?"

E, finalmente, as entradas. Essas podem parecer meio óbvias a princípio (o seu
microserviço está gerando dados do nada?), mas mantenha em mente que uma
entrada pode ser a origem de dados de mais de um microserviço. Por exemplo,
uma narração pode ser consumida pelo microserviço de narrações para produzir a
narração inteira da partida, mas também ser consumida pelo microserviço de
placar, que fica escutando narrações de gols para atualizar seu estado (se a
narração não for de gol, não há alteração de placar, não há alteração de
estado e não há geração do artefato).

Voltando aos artefatos, não se preocupe se mais de um microserviço faz
basicamente a mesma coisa que outra, mas gera um artefato completamente
diferente. Como exemplo, imagine que você quer que sejam feitas notificações
por push quando acontece um gol. Embora seja um serviço bem parecido com o
microserviço de placar, ele produz um artefato diferente (a notificação por
push vs a requisição de atualização de placar) e, por isso, deveria ser um
microserviço completamente diferente. Até pode soar meio desnecessário (ter
serviços fazendo a mesma coisa, duas vezes), mas isso desacopla as coisas se
você precisar mais informações no placar (por exemplo, adicionando o nome de
cada jogador que fizeram gols) ou mudar o consumidor do artefato (por exemplo,
mudando a implementação do push para, ao invés de fazer as chamadas
diretamente paras a APIs da Apple e Google, fazer chamadas para um serviço que
já faça tudo isso, como o da Azure).

Essa mudança na minha forma de pensar como construir microserviços me ajudou a
pensar nos nossos microserviços no trabalho, e também está me ajudando a
repensar algumas saídas em um projeto pessoal (que eu espero terminar e
mostrar no ano que vêm).
