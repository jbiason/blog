+++
title = "Plugins - Vim-Multiple-Cursors"
date = 2015-12-22
+++

Essa é a parte em que você pode repetir várias coisas, visualmente.

<!-- more -->

O último plugin da lista de plugins é o [Vim-Multiple-Cursors](https://github.com/terryma/vim-multiple-cursors).

Já que sempre falamos em usar Vundle...

```viml
Plugin "terryma/vim-multiple-cursors"
```

Assim como outros plugins já comentados, Vim-Multiple-Cursors não tem nenhuma
apresentação inicial. O que este plugin faz é permitir que você tenha várias
cursores no texto ao mesmo tempo, aplicando a mesma transformação em todos os
lugares.

A forma mais simples de usar Vim-Multiple-Cursors é ir até a palavra que você
quer alterar e pressionar `[Ctrl]n`. Você vai notar que o VIM irá mostrar como se
você tivesse entrado em modo visual e selecionado apenas aquela palavra, o que
não é nada impressionante. No entanto, se você pressionar `[Ctrl]n` de novo, você
verá que o cursor irá para a próxima ocorrência da palavra. Na verdade, o que
você tem agora são dois cursores e tudo que você fizer em um será repetido no
outro. Por exemplo, se você fizer ce sobre a palavra, você verá as duas
palavras mudando ao mesmo tempo.

De certa forma, o que você está fazendo é um "search and replace" só que está
vendo exatamente o que vai ser alterado.

Teoricamente, você poderia fazer `I"[Esc]ea"` para adicionar aspas ao redor da
palavra, mas há um pequeno inconveniente: `[Esc]`, que você precisa usar para
retornar para o modo normal depois de entrar em modo de inserção com `I` irá
também terminar o modo de múltiplos cursores.

A segunda forma de usar Vim-Multiple-Cursors é fazer uma seleção visual e usar
`[Ctrl]n`. Para cada linha da seleção, será adicionado um novo cursor. E,
novamente, o que você fizer em um deles será repetido em todos.

Simples assim.

A única coisa que eu posso deixar de aviso é que, por algum motivo, utilizando
uma seleção visual de várias linhas (`[Shift]v`), entrando em modo de múltiplos
cursores (`[Ctrl]n`) e usando aspas (com o Auto-Pairs), meu undo acabou sendo
perdido (`u` removia o texto inteiro, não a alteração feita com
Vim-Multiple-Cursors).

{{ chapters(prev_chapter_link="./14-09-ctrlp", prev_chapter_title="Plugins - CtrlP e CtrlPFunky", next_chapter_link="./15-conclusao", next_chapter_title="Conclusão") }}
