+++
title = "Procurar em Vários Arquivos"
date = 2015-12-22
+++

Essa é a parte em que mais uma vez você vai ter que pesquisar sobre
expressões regulares.

<!-- more -->

Já vimos o comando de pesquisa, que tem um modo inteiro só pra si[^1].

Mas como fazer para encontrar ocorrências de uma palavra em mais de um arquivo?
Para isto, existe o comando `:grep`.

O grep é uma ferramente comum em Unixes (e Linux) em geral, mas o VIM tem
scripts que fazem a mesma coisa em outros sistemas operacionais (por exemplo,
Windows). Assim, o mesmo comando vai funcionar da mesma forma não importando
qual sistema você esteja utilizando.

Como o `:grep` usa outras funcionalidades existentes no VIM, iremos ver um pouco
mais do que simplesmente "Procurar", mas isso é necessário.

Como o modo de pesquisa, `:grep` precisa de uma expressão regular. Ao contrário
do modo de pesquisa, o `:grep` também precisa de uma lista de arquivos a serem
pesquisados. Por baixo dos panos, o que o VIM faz é chamar o comando "grep" (do
Unix), verifica o resultado e permite pular facilmente entre os elementos
encontrados (então todas as opções disponíveis para o grep podem ser passadas
diretamente de dentro do VIM).

Por exemplo, para pesquisar por arquivos que contém a palavra "void", você só
precisa executar o comando `:grep void *` (onde `:grep` é o comando, `void` é a
expressão a ser pesquisada e `*` é a lista de arquivos a serem pesquisados). Como
o grep (o aplicativo do Unix) somente pesquisa arquivos no diretório
especificado (no nosso caso anterior, como não foi passado diretório algum,
será considerado o diretório atual), o `:grep` (o comando do VIM) também não vai
entrar em nenhum subdiretório (de novo, porque o VIM simplesmente chama o grep
[aplicativo do Unix] e facilita pular entre os elementos encontrados). Para
fazer uma procura que encontre a expressão além do diretório atual, basta
adicionar a opção "-r" para o grep (`:grep void -r *`).

Ok, agora que você sabe usar o `:grep`... Como é que você vê os resultados?

Primeira informação periférica: O VIM tem um tipo de "janela" especial, chamada
"Quickfix". Essa "janela" é, na verdade, um "split" da tela (e mais a frente
veremos como trabalhar com "splits" e abas). Para exibir o Quickfix, é usado o
comando `:copen`; para fechar o Quickfix, basta usar `:copen` de novo. Para
passar para o próximo elemento existente no Quickfix, use `:cnext` (ou
simplesmente `:cn`); para passar para o elemento anterior, use `:cprevious` (ou
simplesmente `:cp`); para mover o cursor para a posição do elemento atual do
Quickfix, use `:cc` (que é simplesmente `:cc` mesmo).

A segunda informação periférica: Como eu falei, usar `:grep {expressão} *` irá
procurar "{expressão}" a partir do diretório atual. Para descobrir qual é o
"diretório atual" para o VIM, use `:pwd` (de "print working directory", que
também é um comando Unix); para mudar para outro diretório, utilize o comando
`:cd {diretório}`, como você faria num shell normal.

(E antes que alguém pergunte: Sim, você pode fazer um grep fora do diretório
atual passando o diretório em questão no próprio comando do grep: `:grep void
/tmp -r` irá procurar por "void" em todos os arquivos existentes no diretório
/tmp.)

[^1] Apenas para lembrar, `/` entra no modo de pesquisa, onde só é preciso entrar
	 a expressão regular a ser encontrada; para passar para a próxima
	 ocorrência, use `n` em modo normal; para passar para a ocorrência anterior,
	 use `N` também em modo normal; para remover o realce das palavras
	 encontradas, use `:noh` em modo de comando.

{{ chapters(prev_chapter_link="./06-macros-de-teclado", prev_chapter_title="Macros de Teclado", next_chapter_link="./08-localizar-substituir", next_chapter_title="Localizar e Substituir") }}
