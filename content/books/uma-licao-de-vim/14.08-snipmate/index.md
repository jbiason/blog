+++
title = "Plugins - Snipmate"
date = 2015-12-22
+++

Essa é a parte que automatizamos a digitação de coisas repetidas.

<!-- more -->

Para o oitavo plugin, iremos falar sobre [SnipMate](https://github.com/msanders/snipmate.vim).

Como de costume, instalando pelo Vundle:

```viml
Plugin "msanders/snipmate.vim"
```

SnipMate adiciona a funcionalidade de snippets dentro do VIM. Para quem não
sabe, snippets são trechos de código que são adicionados automaticamente (ou
com a ação de alguma combinação de teclas) a partir de uma simples palavra.

Por exemplo, um dos snippets que já estão inclusos no pacote do SnipMate, você
pode, num arquivo JavaScript, simplesmente digitar:

```javascript
fun
```

... e, ao pressionar [Tab], o SnipMate irá adicionar, automaticamente

```javascript
function function_name (argument) {
  // body...
}
```

... posicionando o cursor diretamente sobre "function_name" para que você coloque
o nome da função; pressionando [Tab] irá posicionar o cursor sobre "argument" e
pressionando [Tab] de novo, o cursor ficará sobre "// body..." (depois disso,
[Tab] irá funcionar como tabulação, como normalmente é).

Para criar seus próprios snippets, você tem duas opções e ambas devem ficar no
diretório $HOME/.vim/snippets:

A primeira forma é através de um único arquivo, com o nome do tipo de arquivo
em que os snippets serão válidos (que você pode ver usando `:set ft`) com a
extensão snippets (por exemplo, para snippets para arquivos Python, você teria
um arquivo "$HOME/.vim/snippets/python.snippets"). Neste arquivo você deve
iniciar os snippets com a palavra snippet, seguida da palavra que será
utilizada para identificar o snippet, seguido pelo snippet em si, com uma
tabulação na frente (quando não houver tabulação, SnipMate considera que o
snippet terminou). Os pontos onde você quer que o cursor pare devem ser
identificados por "$\{\{número}:{texto\}\}" e, se ficou confuso, é porque eu estou
usando "coisas que você substituir" com {} e o próprio SnipMate usa {} para
blocos, mas deve ficar mais claro com este exemplo:

```viml
snippet for
    {% for ${1:record} in ${2:list} %}
        ${3:content}
    {% endfor %}
```

Este snippet, para Django e Jinja, faz um loop "for". Ao digitar "for" e
pressionar [Tab], o conteúdo será adicionado, o cursor será posicionando onde
`${1:record}` está permitindo a alteração do mesmo, pressionando [Tab] de novo
irá posicionar em `${2:list}` e assim por diante.

E, caso você esteja se perguntando "E o que acontece se eu colocar o mesmo
número em dois lugares diferentes?", a resposta é: lugares com o mesmo número
são alterados ao mesmo tempo. Por exemplo, o snippet:

```viml
snippet block
    {% block ${1:blockname} %}
        ${2:{% content %}}
    {% endblock $1 %}
```

... tem o número "1" duas vezes (uma depois de "block" e outra depois de
"endblock"). Quando você colocar o nome do bloco no primeiro (do lado de
"block"), o outro (depois de "endblock") será preenchido automaticamente.

A segunda forma de adicionar snippets é através de arquivos individuais. Ao
invés de ter um arquivo com o tipo de arquivo com todos os snippets dentro,
você irá criar um diretório com o tipo de arquivo e cada arquivo dentro deste
diretório deve ser "{palavra}.snippet". Assim, como no exemplo anterior tínhamos
um arquivo "$HOME/.vim/snippets/htmldjango.snippets", poderíamos ter, na verdade,
um diretório "$HOME/.vim/snippets/htmldjango/" e, dentro deste diretório, um
arquivo chamando "block.snippet" com o conteúdo do snippet, sem as tabulações (já
que agora o SnipMate sabe exatamente onde termina o snippet: no final do
arquivo).

E quando usar um ou outro? Você deve usar arquivos individuais se o SnipMate já
tiver um arquivo de snippets para o tipo de arquivo especificado. Assim, se
você quiser adicionar novos snippets para Python, que já tem uma série de
snippets prontos incluídos no pacote do próprio SnipMate, você deve usar a
segunda forma. Caso contrário, fica por preferência pessoal.

E, para concluir: Ao escrever este post, descobri que existe um fork da versão
apresentada aqui. A versão do "msanders" não é atualizada a 4 anos -- mas
funciona perfeitamente e tenho usado sem problemas a bastante tempo. Se você
quiser algo mais recente (por algum motivo), o fork está em
github.com/garbas/vim-snipmate (e requer mais dependências que a versão
original).

{{ chapters(prev_chapter_link="./14-07-syntastic", prev_chapter_title="Plugins - Syntastic", next_chapter_link="./14-09-ctrlp", next_chapter_title="Plugins - CtrlP e CtrlPFunky") }}
