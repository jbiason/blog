+++
title = "Meu .gvimrc"
date = 2015-12-22
+++

Essa é a parte em que veremos mais do mesmo.

<!-- more -->

Na parte de configurações, eu falei de dois arquivos, "vimrc" e "gvimrc". Vocês já
viram o que eu fiz com meu vimrc, então acho justo que vejam também o que eu
fiz com o meu gvimrc.

Para que fique claro, vimrc sempre é lido, não importa qual executável do VIM
você está usando. gvimrc é lido depois do vimrc somente quando você iniciar um
VIM gráfico.

Como o arquivo é bem menor (já que o grosso da configuração fica no vimrc),
este é o arquivo inteiro que eu estou usando:

```viml
set guioptions=aegit    " basically, all options, except the scrollbar, menu and toolbar
set columns=116         " number of columns (uses most of my screen, in this case)
set cursorline          " highlight the line with the cursor
set colorcolumn=+2      " put a marker at textwidth + 2
set linespace=1         " spread the lines a bit, adding a 1px line above all

if has('mac')
    set gfn=monofur:h15     " My screen size sucks, mkay?
    set lines=63            " number of lines, based on my screen size and font
else
    set gfn=monofur\ for\ Powerline\ 12
    set lines=54
endif
```

E explicando:

* `set guioptions=aegit`: Define a aparência do editor em modo gráfico. Eu
  prefiro um editor limpo, sem menus, toolbars ou (e isso talvez soe estranho
  para alguns), sem barra de rolagem. Em ordem, as opções ativas são:

  `a`: Quando estiver fazendo a seleção com o modo visual, já copia o selecionado
  para a área de transferência. No caso de sistemas Unix, isso significa que
  selecionar algo com o modo visual é o mesmo que selecionar com o botão da
  esquerda (e que pode ser colado diretamente usando o botão do meio).

  `e`: Mostra abas (se estiver configurado para mostrar abas com “showtabline” --
  que eu configurei para mostrar sempre no meu vimrc).

  `g`: Mostra opções do menu desabilitadas. O normal é que opções desabilitadas
  sequer apareçam. Esta opção só faz sentido se o menu estiver presente (com a
  opção m no "guioptions") que, como você pode perceber, eu não estou usando.
  Em alguns sistemas (por exemplo, OS X) o controle do menu não faz sentido
  porque o sistema operacional sempre tem um menu ativo. Assim, quando não há
  necessidade de menu, esta opção é desnecessária; quando não há escapatória do
  menu, pelo menos todas as opções serão visíveis.

  `i`: VIM tem um ícone (sim você pode configurar para o que o VIM não mostre um
  ícone em lugar algum). De novo, dependendo do sistema operacional, esta opção
  não tem efeito algum porque o próprio sistema adiciona o ícone do launcher.

  `t`: Menus podem ser arrancados (quando possível). Esta é uma funcionalidade
  que o GTK+ até a versão 2 tinha, que permitia que os menus fosse
  "desconectados" da área de menu, o que facilita bastante na hora de
  selecionar colorschemes (e como você pode adicionar um menu a qualquer hora
  com `:set guioptions+=m`, o que eu normalmente faço -- ou melhor, fazia -- era
  adicionar um grupo de novos colorschemes, ativar o menu, "arrancar" o menu de
  colorschemes e sair selecionando opções até achar um colorscheme
  interessante).

* `set columns=116`: Número de colunas da janela do editor. Se a sua tela não
  tiver como apresentar 116 colunas (pelo tamanho da fonte e da tela, ou por
  alguma restrição do gerenciador de janelas), o VIM irá reduzir a quantidade
  de colunas até que a janela caiba completamente.

* `set cursorline`: A linha onde o cursor se encontra tem highlight. E, caso
  você esteja se perguntando, existe um `set cursorcolumn` que mostra a coluna do
  cursor. Tanto "cursorline" quanto "cursorcolumn" funcionam em console, mas a
  forma como a linha é apresentada no meu colorscheme é... estranha.[^1]

* `set colorcolumn=+2`: Define uma coluna para ser marcada com uma cor
  diferente. Se for usado uma opção relacional (não um valor absoluto, mas algo
  começando com "+" ou "-"), então cursorline vai usar o "textwidth" atual.

* `set linespace=1`: Define um espaçamento entre linhas, em pixeis. No caso,
  "1" significa que as linhas terão a altura requisitada pela fonte mais um
  pixel.

* `set lines=???:` Define a quantidade de linhas do editor. Segue todas as
  considerações feitas em “columns”. Ainda, aqui eu estou usando de novo a
  checagem de funcionalidade (`has()`) para ter configurações diferenciadas no OS
  X e em outros sistemas operacionais.

* `set gfn=???`: Define a fonte a ser usada ("gfn" é a forma curta de "guifont").
  Note que fontes que tem espaço no meio tem que ter os espaços "escapados"
  (com `\` antes do espaço) ou como strings. Se você quiser selecionar alguma
  fonte mas não faz idéia do nome da fonte, use `:set gfn=*` para que o VIM
  mostre o seletor de fontes do sistema; depois que escolher uma fonte, se
  quiser que o VIM descreva como usar, use `:set gfn` e cole o resultado no seu
  arquivo de configuração.

[^1] E, lembrando mais uma vez: Para desligar opções deste tipo, coloque "no" na
	 frente. Para desligar o highlight da linha atual do cursor, use `:set
	 nocursorline`; para desligar o highlight da coluna atual do cursor, use
	 `:set nocursorcolumn`.

{{ chapters(prev_chapter_link="./11-01-vimrc", prev_chapter_title="Meu .vimrc", next_chapter_link="./12-modelines", next_chapter_title="Modelines") }}
