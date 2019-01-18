+++
title = "Modos"
date = 2015-12-22
+++

Esta é a parte onde eu explico porque você não conseguia sair do VIM na
primeira vez que tentou usá-lo.

<!-- more -->

Uma das primeiras coisas que é preciso entender sobre VIM é que ele é um editor
modal. Enquanto outros editores abrem os arquivos diretamente em "modo de
edição" (para começar a usar a nomenclatura que o VIM adota) -- permitindo que
você possa, imediatamente, editar o texto --, o VIM entra em "modo normal" (que
não é o modo "normal" dos outros editores).

![Mas o que isso quer dizer?](whatdoesitmean1.jpg)

O VIM tem 5 modos:

## Modo Normal

O modo Normal é o modo que o VIM entra normalmente. Neste modo, as teclas são
traduzidas para comandos de alteração do texto. Na configuração padrão, os
comandos sequer são apresentados.

## Modo de Inserção

O modo de Inserção é o modo que a maior parte dos outros editores funciona.
Qualquer coisa editada irá aparecer/alterar o texto atual.

## Modo Visual

O modo Visual é semelhante ao selecionar texto com "shift" em outros
editores[^1].

## Modo de Comando

O modo de comando serve para ações que começam com ":" (comandos Ex), "/" e "?"
(procura) e "|" (filtro).

## Modo Ex

Semelhante ao modo de comando depois de usar ":", mas permanece no modo Ex.

Praticamente todos os modos são utilizados, de alguma forma ou de outra, com
exceção do modo Ex.

A pergunta que você deve estar se fazendo agora é: E daí?

![Você, agora.](so-what.jpg)

Existem algumas coisas interessantes que podem ser feitas com VIM que não podem
ser facilmente replicadas em outros editores justamente pela existência destes
modos de operação. Sim, inicialmente, o fato de não poder entrar no editor e
sair adicionando código pode parecer frustante, mas a medida que você for
aprendendo como utilizar cada modo, você verá que eles fazem sentido e que não
é nenhum mistério ficar pulando de modo para modo.

A verdadeira lição começa agora.

{% note () %}
Todas as imagens são copyright (C) seus respectivos donos.
{% end %}

[^1] Apenas a título de informação, praticamente tudo que pode ser feito em
     modo visual pode ser feito em modo normal.

{{ chapters(prev_chapter_link="./00-intro", prev_chapter_title="Introdução", next_chapter_link="./01-01-modo-normal", next_chapter_title="Modo Normal") }}
