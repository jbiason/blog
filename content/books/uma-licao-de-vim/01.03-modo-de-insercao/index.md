+++
title = "Mudando de Modos – Modo de Inserção"
date = 2015-12-22
+++

Esta é a parte em que você vai finalmente começar a editar o texto.

<!-- more -->

Agora que você sabe que existe mais de um modo de edição e como o cursor
funciona, podemos finalmente começar a ver como se passa de um modo para o
outro -- e, no processo, entender como editar um texto no VIM.

Primeiro, é preciso saber que o Modo Normal é o ponto central para todos os
outros modos -- o jeito mais fácil de passar de um modo para o outro é através
do Modo Normal. E, de qualquer modo[^1], para ir para o modo normal basta
pressionar `Esc`.

Lembre-se: `Esc` irá sempre voltar para o modo normal para que você possa passar
para os demais modos. `Esc` em modo normal irá continuar em modo normal[^2].

Para passar do modo normal para o modo de inserção, você deve usar o seguinte:

## i

Vai para o modo de inserção na posição do cursor (lembre-se do capítulo
anterior: o cursor está no canto inferior esquerdo do cursor, logo qualquer
coisa que você digitar vai aparecer antes da letra onde o cursor se encontrava
antes de pressionar `i`).

## I

Move o cursor para o primeiro caracter que não seja espaço ou tabulação na
linha e entra em modo de inserção (semelhante à `_i`).

## a

Move o cursor uma posição pra frente e entra em modo de inserção (ou o mesmo
que `li`).

## A

Move o cursor para o fim da linha e entra em modo de inserção (Seria quase um
`$i`, só que `$` pára no último não branco da linha -- se considerarmos o caracter
de quebra de linha um caracter "branco" -- e `i` ficará antes desse não-branco).

## o

Insere uma linha em branco depois do cursor e entra em modo de inserção.

## O

Insere uma linha em branco acima do cursor e entra em modo de inserção.

## R

Entra em modo de inserção, mas substitui as letras atuais ao invés de adicionar
mais. Sim, é um modo de substituição ("replace"), mas ainda é considerado um
modo de inserção. 

Ok, pequena pausa para acertar os ponteiros agora: Uma coisa que eu comentei
anteriormente foi que, no modo normal é possível definir o número de vezes que
um comando será repetido. Por mais estranho que isso possa parecer, todos os
comandos acima também aceitam um número de repetições. Por exemplo, `20A-[Esc]`
irá repetir o comando `A-` 20 vezes, efetivamente colocando 20 "-" na linha
atual; `20Oolá[Esc]` irá adicionar 20 linhas de `olá` no seu texto, a partir da
posição do cursor.

![Sua vida acabou de mudar.](iStock_000014784346Small.jpg)

Quem estava prestando atenção deve ter notado que eu pulei `r` como opção de
modo de inserção e todos os demais comandos tem uma versão em minúsculas e
maiúsculas. O motivo é que `r` tem um funcionamento, digamos, peculiar.

`r`, por si só, espera por uma tecla para substituir o caracter sob o cursor.
Seria o equivalente a fazer `R`, pressionar uma tecla e, na sequência,
pressionar `[Esc]` para sair do modo de inserção. O estranho, no entando, é
quando é definido um número de vezes que `r` deve ser executado: Neste caso, o
caracter sob o cursor é alterado para o caracter indicado, o cursor é movido
para o próximo caracter e o processo se repete até o número de vezes indicado
(ou seja alcançado o final da linha). `20r-[Esc]` irá, efetivametne, substituir
os 20 próximos caracteres por "-" -- que não seria o mesmo que digitar,
manualmente, `r-` 20 vezes.

Existem ainda outros dois comandos para entrar em modo de inserção: `c` e `s`.
Existem algumas diferenças configuráveis entre ambos, mas o funcionamento é o
mesmo: Removem os caracteres indicados pela movimentação e passam para o modo
de inserção.

![Como assim "movimentação"?!?](enhanced-buzz-5697-1327086181-19.jpg)

De novo, pausa para acertar os ponteiros: no capítulo #2.2, eu falei sobre
comandos do modo normal que movimentam o cursor. Aqui, `c` e `s` não vão entrar em
modo de inserção até que você adicione uma sequência de movimentação. Assim: `s$`
irá remover tudo da posição de cursor até o final da linha e entrará em modo de
inserção, `s%` irá remover tudo da posição do cursor até o próximo elemento que
"fecha" o elemento atual (aspas, parênteses, colchetes, etc) e entrará em modo
de inserção, `c2f.` irá remover tudo da posição do cursor até o segundo ponto na
linha e entrará em modo de inserção e assim por diante.

![A ficha finalmetne caiu](jaw-drop.jpg)

Embora `c` e `s` funcionem de forma semelhante, `C` e `S` não: `C` irá apagar
tudo da posição do cursor até o final da linha enquanto que `S` irá remover
todo o conteúdo da linha, não importando a posição do cursor. Logicamente,
depois de fazerem isso, ambos entram em modo de inserção. Com um número de
repetições, no entanto, ambos funcionam da mesma forma -- tanto `20S` quanto
`20C` irão remover a linha atual e mais 19 e entrar em modo de edição.

E, só pra lembrar: Pressionar `[Esc]` irá voltar para o modo normal.

{% note() %}
Todas as imagens são copyright (C) seus respectivos donos.
{% end %}

[^1] ... exceto o modo Ex, mas como eu falei antes, não é um modo muito útil
     hoje em dia e, portanto, eu estou ignorando ele daqui pra frente.

[^2] ... O que explica porque vários programadores experientes em VIM tem a
	 mania de, algumas vezes, ficar pressionando `[Esc]` rapidamente quando
	 algo sai errado.

{{ chapters(prev_chapter_link="./01-02-entendendo-o-cursor", prev_chapter_title="Entendendo o Cursor", next_chapter_link="./01-04-modo-visual", next_chapter_title="Modo Visual") }}
