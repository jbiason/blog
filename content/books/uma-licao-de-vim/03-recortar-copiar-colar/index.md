+++
title = "Recortar, Copiar e Colar"
date = 2015-12-22
+++

Essa é a parte que você não deve fazer muitas vezes quando estiver
programando.

<!-- more -->

Assim como outros editores, o VIM tem um sistema de copiar e colar. E, como
vimos vendo desde o começo, o VIM tem seu modo peculiar de lidar com isso.

Toda a parte de copiar-e-colar do VIM é feita em modo normal. E sem que você
soubesse, você já stava vendo a parte de recordar textos desde a parte de
comandos do modo normal: Qualquer comando que exclua texto imediatamente
transfere a parte excluído para a área de transferência do VIM. A única parte
que ficou faltando foi como você “cola” estes textos de volta.

E, para colar, você usa `p` (de "paste", veja só!).

E, obviamente, existe o `[Shift]+p` também. E a diferença é facilmente explicada
se voltarmos para o capítulo #2.2.

Quando falamos do cursor, eu disse que o cursor encontra-se na parte inferior
esquerda do bloco do cursor. O colar do VIM é feito depois do cursor. Assim, ao
pressionar `p`, o texto irá aparecer depois do caractere sob o cursor; se for
pressionado `[Shift]+p`, o texto será colado antes do caractere atual, empurrando
o mesmo pra frente.

O funcionamento muda um pouco se você recortar o texto usando o modo visual de
linha (ou recortar usando algum movimento que desconsidere a coluna atual).
Nestes casos, o VIM entende que você quer colar uma linha inteira e, ao invés
de mover o conteúdo da linha atual, o texto é colado abaixo da linha atual,
desconsiderando a posição do cursor. `[Shift]+p` irá colar o texto antes da linha
atual.

(Embora pareça complicado, a medida que você for se aclimatando com o
copiar-e-colar do VIM, você verá que não é tão diferente dos demais editores --
com a exceção que os outros editores tentam adivinhar quando você quer fazer
copia de linhas inteiras ou apenas pedaços, enquanto que o VIM deixa você mesmo
decidir quando fazer isso.)

A única coisa que ficou faltando agora foi como copiar o texto sem remover o
mesmo antes -- porque, vamos admitir, recortar e colar de novo seria muita
burrice.

O comando para copiar é `y{movimentação}`. Normalmente, ele é chamado de "yank"
(arrancar) e por isso muitos chamam o sistema de "copy'n'paste" do VIM de
"yank'n'paste".

Para copiar a linha inteira, você pode usar `yy`. Isto copia toda a linha,
incluindo o marcador de nova linha, e o VIM vai entender que, na hora de colar,
você quer colar a linha inteira, seguindo as mesmas regras que eu expliquei
acima sobre o modo visual de linha.

Assim como outros editores, o VIM mantém a área de transferência entre arquivos
(com isso, você pode abrir um arquivo, copiar um texto, abrir outro arquivo e
colar a parte selecionada do primeiro) e, normalmente, o VIM ainda consegue
manter a área de transferência entre execuções. Entretanto, uma coisa que você
pode não gostar é que a área de transferência pertence e é gerenciada
exclusivamente pelo VIM -- ou seja, ele não usa a área de transferência do
sistema operacional[^1]. Assim, você não vai conseguir copiar do VIM e colar no
seu browser ou vice-versa.

.. a não ser que você use registradores, que nós vamos ver a seguir.

[^1] E não, o "botão do meio dentro do X" não é a mesma coisa a área de
     transferência.

{{ chapters(prev_chapter_link="./02-outros-comandos", prev_chapter_title="Outros Comandos", next_chapter_link="./04-registradores", next_chapter_title="Registradores") }}
