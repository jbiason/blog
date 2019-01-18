+++
title = "Localizar e Substituir"
date = 2015-12-22
+++

Essa é a parte em que você vai precisar aprender expressões regulares — mais
uma vez.

<!-- more -->

Uma coisa relativamente comum quando se está programando é substituir todas as
ocorrências de uma palavra por outra[^1].

Para fazer "localizar e substituir" ("search and replace") existe o comando
`:substitute` em modo de comando (ou simplesmente `:s`).

Até aí sem problemas, mas existe uma pequena pegadinha (na verdade, duas, mas
uma de cada vez): `:s` é, na verdade, `:{range}s`, onde "{range}" é a parte do
texto que o comando `:s` deve ser executado -- e sim, eu sei que não falei
sobre este tipo de comando antes, mas essa era a melhor oportunidade.

Então, {range}. {range} é opcional e, se não for passado, o comando será
executado da linha atual. Isto, obviamente, não é muito útil. {range} é formado
por um par[^2], separado por vírgulas, indicando o início e o fim da execução do
comando.

O uso básico de {range} é "linha inicial,linha final". Por exemplo, `:1,5s` irá
executar o comando `:s` entre as linhas 1 (a primeira, não existe linha 0 no
VIM) e 5.

E, mais uma vez, existem indicadores especiais, inclusive para {range}.

Um número indica o número da linha, como já comentei. "$" é a última linha do
arquivo (assim, `:1,$s` irá executar `:s` em todo o arquivo); "%" é um alias
para "1,$" (ou seja, todo o arquivo); `'{marcador}` irá, obviamente, utilizar
os marcadores (ou seja, `:'a,'bs` irá executar `:s` entre o marcador "a" e o
marcador "b" -- E marcadores entre arquivos [em maiúsculas] não são
permitidos).

(E existe outros dois marcadores especiais que eu não comentei antes por achar
que não há uso fora do `:s` que são `'<` e `'>` que indicam, respectivamente, o
início e o fim da região visual -- mas o VIM vai adicionar estes dois
marcadores automaticamente se você tiver uma região visual selecionada e
pressionar `:` e por isso ficaram pra trás. Então não se assuste se o VIM
começar a colocar coisas na linha de comando sem que você tenha digitado.)

Daqui pra frente, eu vou colocar o comando como `:%s`, já que esta é a execução
mais comum do comando. Mas lembre-se que `%` = `1,$` = do começo ao fim.

`:%s` funciona, assim como a pesquisa, com expressões regulares, só que ao invés
de termos uma expressão, teremos duas: a de pesquisa e a de substituição. Em
casos mais simples, onde você quer substituir "palavra 1" por "palavra 2", o
comando será `:%s/palavra 1/palavra 2`. Mais uma vez, conhecer expressões
regulares vai ajudar aqui -- e fica a dica para olhar sobre "grupos".

A segunda pegadinha é que `:%s` executa o comando em cada linha do range e, como
padrão, somente a primeira ocorrência é substituída. Assim, se "palavra 1"
existir mais de uma vez em uma linha, somente a primeira será alterada.

Para resolver isso, você deve usar o terceiro parâmetro de `:%s`, {flags}. As
flags mais comuns são:

<dl>
	<dt>g</dt>
	<dd>Substitui todas as ocorrências da expressão de procura na linha, não apenas
		a primeira.</dd>
	<dt>i</dt>
    <dd>Ignora maiúsculas e minúsculas ("ignore case")</dd>
	<dt>c</dt>
    <dd>Pede confirmação em cada alteração.</dd>
</dl>

Concluindo: para substituir "void" por "int\*" em todo o arquivo mas apenas no
começo da linha, ignorando se está em maiúsculas ou minúsculas (porque o
estagiário pensou que estava digitando uma monografia), mas confirmando cada
mudança, você faria `:%s/^void/int*/ic` (como é apenas no começo da linha e nós
forçamos isso na expressão regular -- o `^` ali -- não precisamos usar a flag "g",
já que não teria efeito nenhum).

[^1] E, mas pra frente, veremos que existem plugins que deixam esta parte mais
     fácil.

[^2] Na verdade, não e um par mas, de novo, fazer substituição em apenas uma
	 linha não é muito útil, principalmente considerando os comandos que o VIM
	 tem para movimentação do cursor.

{{ chapters(prev_chapter_link="./07-procurar-varios-arquivos", prev_chapter_title="Macros de Teclado", next_chapter_link="./09-splits", next_chapter_title="Splits") }}
