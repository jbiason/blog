+++
title = "Mudando de Modos – Modo de Comando"
date = 2015-12-22
+++

Essa é a parte onde você vai aprender a fazer as coisas que precisavam de um
menu para serem feitas.

<!-- more -->

Existem três "iniciadores" de comandos no modo de... erm... comando:

* `:`: Inicia um comando de edição.
* `/`: Comando de pesquisa.
* `!`: Comando de filtro externo.

## Comandos de Edição

Assim como os comandos do modo normal, a quantidade de comandos de edição é
grande demais para cobrir de uma vez só. Então vamos dar uma olhada nos mais
utilizados:

## :q

Sai do VIM. Esse deve ser o comando mais infame da história do editor -- pelo
menos, para os não iniciados. E ele ainda aparece na tela inicial do VIM, se
você prestar atenção.

## :w

Salva o arquivo atual em disco. Você pode passar o nome do arquivo a ser salvo
neste ponto. `:w`, por exemplo, irá salvar o conteúdo com o nome atual; `:w
outro-nome` irá salvar o conteúdo no arquivo "outro-nome".

## :wall

Salva todos os arquivos arquivos. Mais adiante veremos como ter vários arquivos
abertos ao mesmo tempo.

## :wq

Salva o arquivo atual e o fecha.

## :help

Abre o help do VIM no tópico indicado. Por exemplo, `:help :w` irá apresentar as
opções existentes para o comando `:w`; `:help c` irá mostrar as opções do comando `c`
do modo normal e assim por diante.

## :set

Configura (ou apresenta) alguma configuração do VIM. Mais a frente veremos como
configurar o VIM e veremos as opções este comando.

## :r

(Ou :read) Não é muito comum, mas permite carregar o conteúdo de outro arquivo
para dentro do arquivo atual. sem precisar fazer todo o processo de
copiar-e-colar (que veremos mais adiante). Um fato interessante de `:r` é que se
o nome do arquivo a ser carregado começar com "!", o VIM irá tentar executar o
comando ao invés de carregar o conteúdo. Por exemplo, `:r date` irá carregar o
conteúdo do arquivo `date` para dentro do arquivo atual enquanto que `:r !date` irá
executar o comando `date` e "colar" o resultado para dentro do arquivo atual.

## :noh

(Ou :nohighlight) Desliga a marcação sobre elementos de pesquisa. A seguir nós
vamos ver sobre o comando de pesquisa; ao fazer uma, o VIM irá colocar um
"realce" (ou "highlight") sobre as palavras encontradas. Para desligar esses
realces no texto, você pode usar `:noh`. 

Aqui eu preciso abrir três parenteses:

* Quando o vim se recusar a executar um comando, você pode forçá-lo a executar
  o mesmo de qualquer forma adicionando uma exclamação `!` no final do comando.
  Por exemplo, se o VIM se recusar a sair porque você tem alterações em um
  arquivo não salvo, `:q!` irá forçar o editor fechar, perdendo as alterações
  feitas; se o arquivo não tiver permissão de escrita, `:w!` irá fazer com que o
  VIM altere as permissão do arquivo para poder escrever (e, no final, esta
  alteração das permissões é revertida)[^1].

* Uma coisa que você vai encontrar frequentemente são referências a "buffer" e
  "arquivo". Entenda assim: buffer é a representação do arquivo na memória
  enquanto que o arquivo é a representação do conteúdo no disco. Ao abrir um
  arquivo, o VIM cria um buffer com o conteúdo do arquivo e o mantém em
  memória; se o arquivo sumir, o buffer ainda existirá e poderá ser salvo
  ainda; vários comandos internos do VIM -- se você se aventurar a escrever um
  plugin, por exemplo -- fazem referência ao buffer e não ao arquivo, mas
  existem funções que retornam o buffer de um arquivo com o nome indicado. Em
  todo esse tempo usando VIM, a distinção entre ambos nunca me pareceu
  importante e considerar, simplesmente, que "buffer" é o arquivo em memória é
  o suficiente.

* Todos os comandos internos do VIM iniciam com uma letra minuscula e plugins,
  quando adicionam comandos a mais, adicionam com letras maiúsculas[^2]. Ainda,
  boa parte dos comandos não precisa ser digitada completa; quando não há mais
  redundâncias, o comando é aceito. Por exemplo, se houverem os comandos
  ":Gblame" e ":Gbork", ":Gb" não será aceito, mas ":Gba” será porque não há
  mais nenhum outro comando que comece com ":Gba" (por isso que ":noh" funciona
  como atalho para ":nohighlight": porque não há nenhum outro comando que
  inicie com "noh").

## Comando de Pesquisa

O comando de pesquisa é, simplesmente, `/`. Uma vez pressionado, você verá o
cursor indo para a última linha da tela esperando a pesquisa. Uma coisa a ter
em mente é que o VIM utiliza expressões regulares -- então algumas coisas que
você procurar não irão funcionar exatamente como você está esperando. ".", por
exemplo. Eu não vou entrar em detalhes sobre expressões regulares porque há
pilhas de informações sobre elas na internet -- e há praticamente mais sobre
elas do que essa série tem (e terá) sobre VIM.

Dois comandos do modo normal que eu não mencionei antes por estarem ligados ao
comando de pesquisa são `n` e `N`. `n` irá mover o cursor para a próxima
ocorrência da pesquisa, enquanto que `N` move o cursor para a anterior. Note
que eu falei "move o cursor"; isso quer dizer que `n` e `N` são comandos de
movimentação e, portanto, podem ser usados com outros comandos do modo normal
que utilizam movimentação. Por exemplo, procurar por "olá" e, em modo normal,
executar `cn` irá remover tudo da posição do cursor até a próxima ocorrência de
"olá" (e entrará em modo de edição).

## Comando de Filtro

O comando de filtro pega o conteúdo no editor e passa para outro programa. Por
exemplo, se você tiver o aplicativo "rot13", ao executar `!rot13`, todo o
conteúdo do arquivo será convertido para ROT13. Se você digitar `!!rot13`, no
entanto, o conteúdo ainda será passado para o filtro e o resultado irá
substituir o conteúdo do buffer atual.

Não parece ser interessante, mas um dos aplicativos que normalmente vem com o
VIM é "xxd", que converte o conteúdo para sua representação hexadecimal. Ao
executar "!xxd", você verá todo o conteúdo do seu arquivo com os valores
hexadecimais de cada caracter.

[^1] Não confunda "Não ter permissão de escrita" com "O arquivo pertence ao
	 root". No primeiro caso, o usuário tem permissão de ler o arquivo e trocar
	 as permissões enquanto que no segundo o editor teria que ter permissões
	 especiais de execução para poder trocar as permissões. O VIM só consegue
	 responder ao `:w!`  se ele próprio -- e, no caso, o próprio usuário -- tiver
	 permissões suficientes sem requisitar outro aplicativo.

[^2] Na verdade, o VIM vem sim com comandos que inicial com letra maíuscula: São
	 os comandos de exploração de diretório `:Explore`, `:Rexplore`, `:Vexplore` e o
	 famigerado `:Sexplore`, que o pessoal costuma encurtar para `:Sex`.

{{ chapters(prev_chapter_link="./01-04-modo-visual", prev_chapter_title="Modo Visual", next_chapter_link="./01-05-modo-de-comando", next_chapter_title="Modo de Comando") }}
