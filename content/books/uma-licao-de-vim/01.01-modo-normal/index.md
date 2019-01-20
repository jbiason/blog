+++
title = "01.01. Modo Normal"
date = 2015-12-22
weight = 257
+++

Esta é a parte em que você ainda vai precisar de um arquivo pronto para ver
as coisas funcionando.

<!-- more -->

A apresentação mais clássica do modo normal são todas as demais explicações que
você vai achar por aí que dizem que é preciso usar `h`, `j`, `k` e `l` para
mover o cursor na tela. Tirando o fato que isso é uma balela sem tamanho e que
o VIM suporta movimentação com as teclas direcionais e que você não precisa
ficar pensando em mnemônicos como "j tem uma perna pra baixo, k tem uma perna
pra cima" e outras absurdices, estes são comandos normais válidos: ao
pressionar `k`, o cursor irá mover para a linha de cima, `j` moverá o cursor
para a linha de baixo e assim por diante.

Nem todos os comandos são acionados com apenas uma tecla. Alguns iniciam um
comando, mas ficam esperando mais informações para saber o que fazer ou onde
fazer. Assim, temos comandos que são de movimentação e outros de ação.

## Comandos de Movimentação

Comandos de movimentação são comandos que movem o cursor no texto. Como já
vimos, `h`, `j`, `k` e `l` são comandos de movimentação. Além destes temos[^1]:

### f[letra]

Posiciona o cursor na próxima `[letra]` na linha. Se `[letra]` não existir, não
move o cursor. Por exemplo, `fa` irá mover o cursor para o próximo "a" na
linha.

### F[letra]

O mesmo que `f[letra]`, mas voltando na linha ao invés de ir pra frente.

### t[letra]

Posiciona o cursor uma posição antes de `[letra]` na linha. Praticamente o mesmo
que `f[letra]`, mas uma posição antes.

### T[letra]

Assim como "F" faz o mesmo que "t", mas voltando na linha.

### 0

Move o cursor para a coluna 0.

### _

Move o cursor para a primeira letra que não seja espaço ou tabulação na linha.

### $

Move o cursor para o final da linha.

### %

Move o cursor para o outro elemento do par (por exemplo, % quando cursor
estiver sobre um "(" irá mover o cursor para o ")" correspondente).

Até aqui eu acredito que você esteja pensando "nada que mude minha vida". Bom,
então aqui vem a primeira grande dica:

> Se você digitar um número antes de fazer um comando, VIM irá repetir o
> comando quantas vezes o número indicar.

![](Mind-Blown.jpg)

Ok, talvez não tenha sido a revelação do século, mas isso quer dizer que se
você digitar `3f.`, VIM irá mover o cursor para o terceiro ponto na linha atual.
E isso também pode não parecer importante, mas daqui pra frente isso vai fazer
sentido.

{% note() %}
Todas as imagens são copyright (C) seus respectivos donos.
{% end %}

[^1] De forma alguma, esta é uma lista completa de todos os comandos de
     movimentação existentes, apenas os mais interessantes.

{{ chapters(prev_chapter_link="./01-modos", prev_chapter_title="Modos", next_chapter_link="./01-02-entendendo-o-cursor", next_chapter_title="Entendendo o Cursor") }}
