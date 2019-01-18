+++
title = "Mudando de Modos – Modo Visual"
date = 2015-12-22
+++

Esta é a parte em que VIM deixa de ser um editor tão alienígena.

<!-- more -->

Na nota de rodapé do primeiro capítulo eu comentei que a maior parte dos
comandos do modo visual podem ser feitos no modo de comando. Como já vimos o
modo de comando, fica mais fácil entender o modo visual.

Em suma, o modo visual é a versão do VIM para o "Shift+Direcionais" dos demais
editores: Vai selecionando texto, deixando visível o que está sendo
selecionado. A diferença é que não é preciso ficar segurando o Shift o tempo
todo. E todos os demais comandos de movimentação ainda são válidos.

Para entrar no modo visual, você usa, em modo normal, `v` -- e, de novo, você não
precisa pressionar ou ficar segurando nenhuma tecla: o modo ficará ativo até
que você cancele o modo visual (voltando para o modo normal com `[Esc]`) ou seja
utilizado algum comando de alteração de texto (como `s`).

Uma vez que a região fique selecionada, você pode usar qualquer comando de
alteração de textos para executar somente naquela região. Assim, ao invés de
ficar contando quantos pontos a linha tem para chegar no número certo de saltos
para o commando `f`, você pode facilmente ativar o modo visual, navegar a bel
prazer, usado qualquer combinação de comandos de movimentação (incluindo
repetir `f` a vontade) até chegar no ponto que quiser e executar o comando
somente naquela região.

Além de `v`, existem outros dois outros comandos para entrar em modo visual:
`[Shift]+v` e `[Ctrl]+v`.

`[Shift]+v` é chamado de "modo visual de linha" porque, bem, são selecionadas
linhas inteiras neste modo, incluíndo o caracter de nova linha de cada uma das
linhas selecionadas. Neste modo, não é possível selecionar apenas parte de uma
linha, somente linhas inteiras -- que é útil quando se quer remover aquela
função inteira[^1].

`[Ctrl]+v` é chamado de "modo visual de bloco" e faz algo que poucos outros
editores conseguem: seleção de regiões retangulares. A pergunta que você deve
estar se fazendo agora é: e como é que o VIM junta as linhas se eu apagar um
bloco inteiro? Resposta indireta: O modo visual de bloco funciona como se
várias seleções fossem feitas ao mesmo tempo, o que significa que cada linha é
uma seleção diferente e que cada comando de alteração de texto é executado
individualmente em cada linha. Assim, se você iniciar o modo visual de bloco,
selecionar várias linhas mas apenas uma coluna, e executar o comando `c,[Esc]`, o
que vai acontecer é que o VIM irá substituir o caracter na coluna indicada por
vírgula em cada uma das linhas. Ou seja, respondendo a pergunta feita logo no
começo deste parágrafo: o VIM irá juntar as linhas como se você tivesse ido na
primeira linha, executado o comando, retornado a coluna inicial, ido para a
linha seguinte, repetido o comando e passado para a próxima linha.

[^1] Ou copiar para outro arquivo, que nós vamos ver mais pra frente.

{{ chapters(prev_chapter_link="./01-03-modo-de-insercao", prev_chapter_title="Modo de Inserção", next_chapter_link="./02-outros-comandos", next_chapter_title="Outros Comandos") }}
