+++
title = "06. Macros de Teclado"
date = 2015-12-22
weight = 1536
+++

Essa é a parte em que você repete várias coisas sem repetir várias coisas.

<!-- more -->

No capítulo #3, eu falei rapidamente do commando `.`, que repete o último comando
completo. Mas como repetir comandos que são, na verdade, uma composição de
vários outros comandos?

A resposta são macros de teclado.

Macros de teclado permitem que você grave uma execução qualquer e depois a
repita quantas vezes quiser.

Para fazer uma macro de teclado, você deve, em modo normal, executar
`q{registrador}`. Ao fazer isso, a última linha do VIM irá mostrar "recording",
indicando que o editor está agora gravandos todas as teclas pressionadas no
registrador. Para encerrar a gravação pressione `q` novamente (desta vez, sem o
registrador). Para "tocar" a macro, é necessário usar `@{registrador}`.

Quem prestou atenção no capítulo #5, deve ter notado que eu usei a palavra
"registrador" de novo. E a base da questão é que realmente os dois são a mesma
coisa: Se você copiar algo para o registrador `a` (`"ayy`, por exemplo) e depois
gravar a macro "a", o conteúdo copiado para a área de transferência será perdido.
Em compensação, se você criar a macro no registrador "a", você pode ver
exatamente a sequência de comandos usados usando `"ap`. Ou ainda, você pode
colocar a sequência de comandos desejada num arquivo (ou no próprio arquivo),
copiar para o registrador necessário e depois só "tocar" o registrador.

Como exemplo, imagine que você tem uma lista de constantes que você quer
transformar em uma lista de strings. No caso, você teria que adicionar uma aspa
no começo, uma aspa no final, uma vírgula e passar para a próxima linha. Se
forem apenas 4 constantes, é fácil repetir os comandos em cada linha; mas se
forem 100, a coisa fica diferente.

Neste caso, você faria o seguinte: Na primeira linha, executaria
`qaI"[Esc]A",[Esc]jq` -- ou seja, iniciaria a macro "a", entraria em modo de
inserção no primeiro caractere não branco da linha (`I`), colocaria uma aspa,
sairia do modo de inserção, entraria novamente no modo de inserção mas desta
vez movendo o cursor para o último caractere antes (`A`), adicionaria a aspa que
encerra a string e uma vírgula, moveria para a linha de baixo e encerraria a
macro de teclado. Até aqui espero que não tenha nada de surpresas. Agora você
pode repetir `@a` 99 vezes para as próximas linhas ou simplesmente executar `99@a`
e deixar o VIM repetir a macro 99 vezes. No final, bastaria simplesmente
remover a última vírgula.

Uma coisa a ter em mente -- além da questão do registrador -- é que o VIM
encerra tanto a macro quanto o número de repetições se houver qualquer
problema. Por exemplo, se no meio da sua macro você colocar um `f.` para mover
o cursor para o próximo ponto, mas no meio da execução não for encontrado
nenhum ponto, a macro será interrompida e qualquer execução posterior será
encerrada, não importando se for a 99<sup>a</sup> execução da macro ou a
1</sup>a</sup>. Se você perceber que a execução não terminou onde deveria,
basta executar `u` em modo de comando para desfazer a execução da macro.

{{ chapters(prev_chapter_link="./05-marcadores", prev_chapter_title="Marcadores", next_chapter_link="./07-procurar-varios-arquivos", next_chapter_title="Procurar em Vários Arquivos") }}
