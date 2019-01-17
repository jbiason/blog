+++
title = "Meu .vimrc"
date = 2015-12-22
+++

Essa é a parte em que você vai ver um arquivo de configuração meio
estranho.

<!-- more -->

Como falamos sobre arquivo de configuração, eu vou mostrar o que eu tenho hoje
configurado no meu VIM, explicando o que cada comando faz. Boa parte do que eu
tenho veio da configuração global do VIM, que eu copiei apenas para garantir
que não importando onde eu esteja ou qualquer alteração que seja feita neste
arquivo, as funcionalidades que eu estou acostumado continuarão funcionando
como esperado.

```viml
set encoding=utf-8
```

Garante que os arquivos salvos estarão em UTF-8, ao invés de tentar converter
para o encoding do sistema operacional.

```viml
set nocompatible
```

Desativa o modo de compatilidade com o VI original. Existem algumas diferenças
entre ambos (por exemplo, depois de um fazer um undo (`u`), no VI original fazer
undo de novo desfazia o undo anterior (efetivamente, fazendo um "redo") e para
continuar fazendo undo, o primeiro comando depois de undo deveria ser `.`; no
VIM, fazer um undo depois de um undo irá continuar desfazendo o que foi entrado
no texto, até retornar ao estado original) e a não ser que você seja fã do VI
original, eu não recomendaria usar o modo de compatilibidade.

```viml
set backspace=indent,eol,start
```

Apenas garante que o backspace consiga remover identações, apagar o fim da
linha e o começo de uma linha (neste último, forçando a linha atual e se juntar
com a anterior). Esse é o funcionamento normal de qualquer editor.

```viml
" Don’t use Ex mode, use Q for formatting
map Q gq

" Map Y to do the same (well, almost) as the D command
map Y y$
```

Estes dois mapeamentos eu peguei da configuração global, mas nunca efetivamente
usei. Mas, por via das dúvida...

Ainda, uma coisa que eu não havia comentado: Comentários. Você pode comentar
qualquer linha começando a mesma com aspas (") sem as aspas finais (senão o VIM
irá interpretar o conteúdo como string). Então: Uma aspa, comentário; duas
aspas, string; mais de duas, erro.

```viml
if &t_Co > 2 ||&
  syntax on
  set hlsearch
endif
```

Ah, nosso primeiro encontro com ifs. Se o terminal tiver mais de duas cores
(`&t_Co > 2`) ou estivermos rodando em GUI (`has("gui_running")`) então o
suporte à sintaxes deve ser ligado (`syntax on`) e pesquisas devem marcar todas
as ocorrências encontradas no último comando de pesquisa(`set hlsearch`)[^1].

```viml
" ------------------------
"  Those are my settings
" ------------------------

set tabstop=4           " tabs are displayed as 4 spaces
set shiftwidth=4        " by default, when auto-identing, add 4 spaces (or 1 tabstop)
set foldmethod=marker   " fold on markers
set scrolloff=1         " always show one line around the cursor
set laststatus=2        " always show the status bar (’cause I like to see the line and column, always)
set showtabline=2       " always show the tabline
set showmatch           " show matching bracket
set noerrorbells        " no error bells
set autowrite           " write the file when switching between files or something
set nowrap              " do not wrap long lines
set nobackup            " do not keep a backup file, use versions instead
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set formatoptions=tcq   " wrap with textwidth, wrap comments, insert commend leader (twice), format comments
set smartindent         " smart identation
set number              " show line numbers
set wim=longest,list    " file auto-completion
set background=dark     " to follow most of the colorschemes I use
set vb t_vb=            " convert bells to visual bells and do nothing as visual bell

set t_Co=256            " 256 color terminals

let mapleader=","     " use comma to start user-defined (in plugins) functions
```

Um grande bloco de configurações. Vamos ver um por um:

* `set tabstop=4`: Define o tamanho da tabulação. Se estiver usando o caractere
  "tab" ao invés de espaço, estes caracteres serão mostrados como 4 espaços
  (quando o padrão são 8).
* `set shiftwidth=4`: Quando o VIM for identar um pedaço de texto sozinho[^2]. Se
  "shiftwidth" for igual a "tabstop" e você não tiver configurado para usar
  espaços ao invés de tabulações (calma que eu já explico como se faz isso), o
  VIM irá adicionar uma tabulação inteira; se "shiftwidth" for menor que
  "tabstop", espaços serão usados; se "shiftwidth" for maior que "tabstop",
  será usada uma mistura de tabulações e espaços até que o tamanho especificado
  seja alcançado.
* `set foldmethod=marker`: "Folding" foi algo que eu não comentei até agora
  porque eu até agora não consegui me aclimatar com folding (até porque eu não
  consegui pensar num mnemônico para lembrar dos comandos). Mas, basicamente,
  "folding" permite que você "oculte" partes do código com alguma condição.
  Alguns arquivos de sintaxe definem início e fim de funções e isso pode ser
  usado para ocultar toda uma função (apenas para exibição, a função continua
  existindo lá). "marker" define que o método de folding são marcadores e os
  marcadores padrão são "\{\{\{" para o início e "\}\}\}" para o fim.
* `set scrolloff=1`: Número de linhas que devem sempre ficar visíveis ao redor do
  cursor. "1" significa que antes de chegar à primeira ou última linha da tela,
  o VIM irá rolar o texto e apresentar a linha anterior (ou próxima) -- enquanto
  possível.
* `set laststatus=2`: Quando estávamos vendo splits, você deve ter notado que o
  VIM adicionou uma barrinha indicando a posição do cursor (e talvez mais
  algumas outras informações). Esse é o padrão para "1" (mostrar a barra de
  status quando houver splits); "0" nunca mostra e "2" mostra sempre.
* `set showtabline=2`: Assim como "laststatus", se você estava vendo abas em modo
  de console, deve ter reparado que a linha com as abas aparecia apenas quando
  haviam duas ou mais abas. "2" define que essa linha de abas deve ser sempre
  mostrada, mesmo quando há apenas uma aba.
* `set showmatch`: Quando estiver sobre um caractere como parênteses, colechetes
  ou chave, faz o highlight do elemento que abre ou fecha o correspondente.
* `set noerrorbells`: Se ocorrer um erro, não utilize erros sons para
  notificações[^3].
* `set autowrite`: Quando o VIM passar o controle para outro aplicativo ("grep",
  "make" ou mesmo o "shell"), salva o arquivo atual antes de passar a execução.
* `set nowrap`: Quando uma linha for maior que a tela, desabilita a "quebra" da
  linha e, com isso, é necessário "rolar" o conteúdo horizontalmente para ver o
  resto. Um aviso: se você usar "wrap" (`set wrap`) o VIM vai continuar lidando a
  linha como uma coisa só, desconsiderando como a mesma está sendo apresentada;
  assim, se você estiver na primeira parte de uma linha que foi quebrada por
  wrap, usar qualquer comando que vá para a próxima linha irá ir para a próxima
  linha, não para a parte quebrada.
* `set nobackup`: Não grava arquivos de backup. Por padrão, antes de salvar um
  arquivo, o VIM guarda uma cópia do original com o mesmo nome seguido de "~".
* `set history=50`: Quando você usa um comando, o VIM pode guardar esse comando
  para execução futura, como o prompt do shell. Aqui é definido quantos destes
  comandos são guardados.
* `set ruler`: Sempre que possível, mostre a posição do cursor. Se "laststatus"
  for "0" (ou "1" e não houver nenhum split), a posição é exibida na última
  linha da tela, no canto direito; se "laststatus" for "2" (ou "1" e houver
  pelo menos um split), a posição é exibida dentro da barra de status[^4].
* `set showcmd`: Você deve ter notado que comandos que esperam mais informações
  (por exemplo, aqueles que requerem uma movimentação) não são mostrados em
  lugar algum. "showcmd" irá mostrar o comando até que ele seja concluído.
* `set incsearch`: Enquanto você estiver digitando uma pesquisa, já vai
  posicionando o cursor na primeira ocorrência encontrada. "noincsearch" irá
  manter o cursor na mesma posição até que o mesmo seja concluído.
* `set formatoptions=tcq`: Opções de formatação de textos. Cara um dos caracteres
  representa algo diferente: "t" indica que se "textwidth" estiver definido, o
  editor deve quebrar as linhas[^5]; "c" significa que se o texto for quebrado
  durante um comentário (definido pela sintaxe atual), um novo caractere de
  comentário deve ser adicionado; "q" indica que comentários podem ser
  quebrados por "textwidth".
* `set smartindent`: Utiliza identação inteligente, se a sintaxe não definir
  nenhuma. Existem quatro tipos de identação: Nenhuma ("nosmartindent")
  indicando que ao adicionar uma nova linha, nenhuma identação é adicionada;
  "autoindent" para que novas linhas tenham a mesma identação da linha
  anterior; "smartindent", que tenta usar o último caractere da linha para
  identificar se deve ser adicionada uma nova identação ou não (por exemplo,
  parênteses e chaves adicionam identação); e "cindent" que tenta seguir o
  padrão para C. Note que essa configuração só vale para arquivos que não
  definem uma identação no seu arquivo de sintaxe (que são bem poucos).
* `set number`: Adiciona uma área na esquerda da tela com o número da linha na
  própria linha.
* `set wim=longest,list`: Duas coisas aqui: 1) comandos de set tem um nome
  longo e um nome curto e "wim" é o nome curto para "wildmode"; 2) "wildmode"
  define como serão completados os nomes dos arquivos quando você usar um
  comando para abrir arquivos e usar [Tab] para tentar completar o nome do
  arquivo automaticamente. "longest,list" emula o padrão de shells como Bash.
* `set background=dark`: Alguns colorschemes (temas de cor) definem dois
  padrões de cores, um claro e um escuro. "background=dark" define que, na
  existência de dois padrões, o padrão escuro deve ser usado.
* `set vb t_vb=:` Mais uma coisa nova: Duas configurações em uma linha só. Na
  verdade, todas as configurações apresentadas aqui poderiam ficar em uma linha
  só, mas eu mantive estas duas juntas por um motivo: Como defini
  "noerrorbell", o VIM cai para "visualbell" (nome longo de "vb"), que causa um
  "flash" no conteúdo (as cores do tema rapidamente se invertem e voltam ao
  normal) quando ocorre um erro; no caso, eu defini que sim, eu quero que o
  tipo de erro visual ("`t_vb`") seja... nada. Assim, quando ocorre um erro, o VIM
  não bipa nem faz flash.
* `set t_Co=256`: Define que o terminal terá, por padrão, 256 cores. Algumas
  vezes o VIM não consegue descobrir se o terminal tem suporte a mais de 16
  cores ou não e esta configuração reafirma que sim, o terminal é capaz de usar
  256 e, portanto, colorschemes podem ter mais cores.
* `let mapleader=","`: Define a variável "mapleader". "mapleader" é o caractere
  que o VIM utiliza em alguns plugins[^5], quando estes define comandos em modo
  normal. O padrão é "/", eu mudei para vírgula.

```viml
if has("autocmd")
```

Eu falei sobre auto-commands, mas na verdade é uma feature que deve ser
adicionada na hora de compilar o VIM. Entretanto, até agora eu não vi um pacote
disponível que não tenha essa feature. Apenas para garantir, verificamos se a
funcionalidade foi adicionada mesmo ou não.

Boa parte do que tem daqui pra frente ou eu já falei ou veio do arquivo de
configuração global.

```viml
  filetype plugin indent on
```

Ativa as configurações vindas do arquivo de sintaxe. Quando eu disse que as
configurações de auto-identação vem do arquivo de sintaxe, é esta linha que
garante que isso vai acontecer.

```viml
  autocmd FileType text setlocal textwidth=78
```

Quando o tipo de arquivo for texto ("text") define localmente para aquele
buffer que o tamanho da linha é de 78 colunas. Como "formatoptions" tem um "t",
o VIM irá automaticamente quebrar a linha (adicionando um [Enter] antes da
palavra que passa do limite) na coluna 78.[^7]

```viml
  " When editing a file, always jump to the last known cursor position.
  " Don’t do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("’\"") > 0 && line("’\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
```

Este comando existe no arquivo de configuração global, mas é bem interessante.
Lendo exatamente o que ele faz: Depois de carregar qualquer arquivo, se a linha
que o marcador de saída do buffer existir e estiver entre o começo do arquivo e
antes do fim da linha, executa, em modo normal, `g\"`, que efetivamente "pula"
para o marcador de saída do buffer. A diferença entre `\`` e `g\``` é que `g`` não mexe
no jumplist quando pular (logo, ```` não vai funcionar). Como não mexer no
jumplist é algo que não se faz normalmente, nem comentei antes.

```viml
  autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e
```

Eu falei deste comando antes, mas vamos de novo: Quando o tipo de arquivo for
"python", adicione um auto-comando que antes de gravar o buffer, execute, no
buffer, a expressão regular `/\s\+$//e`, que basicamente, serve para remover
espaços em branco no final das linhas.

```viml
  " omni completion
  au FileType python setlocal ofu=pythoncomplete#Complete
  au FileType javascript setlocal ofu=javascriptcomplete#CompleteJS
  au FileType html setlocal ofu=htmlcomplete#CompleteTags
  au FileType css setlocal ofu=csscomplete#CompleteCSS
  au FileType xml setlocal ofu=xmlcomplete#CompleteTags
  au FileType php setlocal ofu=phpcomplete#CompletePHP

  set completeopt-=preview
```

Eu não falei do Omni-complete antes porque até o momento o auto-complete
(`[Ctrl]p` e `[Ctrl]n` em modo de inserção) tem resolvido todos meus problemas.
Mas, em teoria, o omni-complete consegue detectar quais elementos fazem sentido
no contexto atual, "encherga" coisas que estão no arquivo de tags e conhece
toda a sintaxe da linguagem que você está usando. Mas, realmente, o simples
auto-complete já resolve 99% dos problemas que tenho encontrado.

E desliga a apresentação dos resultados do omni-complete na janela de preview,
que é semelhante ao quickfix, mas na minha experiência, ela quebra muito o
fluxo de edição do código.

Se você quiser tentar, para usar o omni complete basta usar `[Ctrl]x` seguido de
`[Ctrl]o`.

```viml
  " ------------------------
  "  Auto-commands
  " ------------------------

  " default python style
  " (use spaces instead of tabs (expandtab), uses 4 spaces for tabs (tabstop),
  " when auto-indenting, also use 4 spaces (shiftwidth), when deleting text, 4
  " spaces are a tab (softtabstop) and break the line at column 78 (textwidth))
  au FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 textwidth=78

  " reStructured files follow python closely, but use 3 tab stops instead of 4
  au FileType rst setlocal expandtab tabstop=3 sw=3 sts=3 textwidth=78

  " templates (Jinja2 in this case) will use tabs instead (to reduce file size)
  au FileType htmldjango setlocal noet tabstop=4 shiftwidth=4 softtabstop=4 textwidth=0
  au FileType jinja setlocal noet tabstop=4 shiftwidth=4 softtabstop=4 textwidth=0

  " the smarty filetypes doesn’t have any sort of indentation, so we set it to
  " auto
  au FileType smarty setlocal ai

  " PHP break lines at column 79, like Python
  au FileType php setlocal textwidth=79

  " svn (when editing svn commit messages, break lines at
  " column 70)
  au FileType svn setlocal tw=70

  " email (mostly mutt stuff)
  au FileType mail setlocal spell spelllang=en

  " JavaScript (who though those were "good" defaults?)
  au FileType javascript setlocal expandtab tabstop=2 sw=2 sts=2 textwidth=0
```

Uma série de auto-comandos baseados no tipo de arquivo. Como eu falei antes
neste capítulo, você pode botar vários "set" um atrás do outro separados por
espaço e sets tem versões com nomes longos e nomes curtos ("sts" é um atalho
para "softtabstop", "sw" para "shiftwidth", "noet" para "noexpandtabs", "ai"
para "autoindent" e "tw" para "textwidth"). E sim, eu sei que não manti nenhum
padrão no meio, mas pelo menos agora você alguns nomes curtos para algumas
opções.

```viml
else
  set autoindent                " always set autoindenting on
endif " has("autocmd")
```

E, se autocmd não estiver disponível, simplesmente seta auto-indent.

```viml
" ------------------------
" mapings
" ------------------------

" Easy switching between tabs (just use Alt+<tab number>)
if has(‘mac’)
    map <D-1> :tabn 1<CR>
    map <D-2> :tabn 2<CR>
    map <D-3> :tabn 3<CR>
    map <D-4> :tabn 4<CR>
    map <D-5> :tabn 5<CR>
    map <D-6> :tabn 6<CR>
    map <D-7> :tabn 7<CR>
    map <D-8> :tabn 8<CR>
    map <D-9> :tabn 9<CR>
    map <D-0> :tabn 10<CR>

    imap <D-1> <ESC>:tabn 1<CR>a
    imap <D-2> <ESC>:tabn 2<CR>a
    imap <D-3> <ESC>:tabn 3<CR>a
    imap <D-4> <ESC>:tabn 4<CR>a
    imap <D-5> <ESC>:tabn 5<CR>a
    imap <D-6> <ESC>:tabn 6<CR>a
    imap <D-7> <ESC>:tabn 7<CR>a
    imap <D-8> <ESC>:tabn 8<CR>a
    imap <D-9> <ESC>:tabn 9<CR>a
    imap <D-0> <ESC>:tabn 10<CR>a
else
    map <M-1> :tabn 1<CR>
    map <M-2> :tabn 2<CR>
    map <M-3> :tabn 3<CR>
    map <M-4> :tabn 4<CR>
    map <M-5> :tabn 5<CR>
    map <M-6> :tabn 6<CR>
    map <M-7> :tabn 7<CR>
    map <M-8> :tabn 8<CR>
    map <M-9> :tabn 9<CR>
    map <M-0> :tabn 10<CR>

    imap <M-1> <ESC>:tabn 1<CR>a
    imap <M-2> <ESC>:tabn 2<CR>a
    imap <M-3> <ESC>:tabn 3<CR>a
    imap <M-4> <ESC>:tabn 4<CR>a
    imap <M-5> <ESC>:tabn 5<CR>a
    imap <M-6> <ESC>:tabn 6<CR>a
    imap <M-7> <ESC>:tabn 7<CR>a
    imap <M-8> <ESC>:tabn 8<CR>a
    imap <M-9> <ESC>:tabn 9<CR>a
    imap <M-0> <ESC>:tabn 10<CR>a
endif
```

Ok, este é um mapeamento que eu sempre achei interessante:

1. Existe uma diferença entre OS X e outros sistemas que a tecla "Command" é
   usada para praticamente tudo, inclusive trocar as abas nos browsers; já em
   outros sistemas, a tecla para isto é "Alt". Um VIM compilado para OS X tem,
   estranhamente, uma feature chamada "mac"; checando isso você consegue
   descobrir se está rodando num OS X ou não.

2. Mapeamentos diferentes para modo normal e de inserção: Se estiver no modo
   normal, basta usar `:tabn {número}` para pular diretamente para uma aba (`:tabn
   {número}` é a versão de modo de comando do `{número}gt` do modo normal[^8][^9]);
   quando estiver em modo de inserção, saida do modo de inserção (simulando
   pressionar [Esc] com <ESC>, execute o mesmo comando usado no modo normal
   para pular para uma aba específica e volte para o modo de inserção ("a").

BOOM! Você acabou de adicionar no VIM uma feature que existe nos browsers.

```viml
" custom PHP syntax file configuration
let php_smart_members=1
```

Essa é uma das coisas que eu falei antes: "let" permite definir variáveis,
incluindo algumas dentro do arquivo de sintaxe. No caso "php_smart_members"
altera a forma como funções membro de uma classe em PHP seja coloridas de forma
diferente.

O resto do meu arquivo de configuração é usado para manter plugins, que eu vou
explicar o que cada um faz mais pra frente. Se você quiser ver o arquivo
original, ele pode ser encontrado no meu repositório de configurações (que eu
uso para manter as configurações sincronizadas entre meu computador pessoal e o
computador do trabalho).

[^1] Apenas para fazer um gancho com o que foi falado anteriormente: No
	 capítulo #2.5, quando estava falando de comandos do modo de comando, eu
	 comentei sobre `:noh` para desmarcar as ocorrências encontradas no último
	 comando de pesquisa. Bom, `hlsearch` faz com que estas ocorrências sejam
	 marcadas e se você colocar set `nohlsearch`, nenhuma ocorrência será marcada
	 e você nunca irá precisar usar `:noh`.

[^2] ... ou quando você usar `>{movimentação}` ou `<{movimentação}` em modo normal,
	 que eu não havia mencionado antes porque estávamos falando de edição de
	 qualquer texto e não de código fonte. `>>` irá adicionar um "shiftwidth"
	 para a direita e `<<` irá remover um "shiftwidth" na esquerda.

[^3] Aqui acabamos de ver duas configurações de flags: Uma ativando uma
     configuração ("showmatch") e outra desligando ("noerrorbells").

[^4] Uma pequena nota sobre as posições apresentadas: algumas vezes, você verá
	 o VIM apresentar a coluna como "{número}-{número}". Isso acontece
	 principalmente quando se está usando tabulações ao invés de espaços e o
	 VIM está indicando a contagem de caracteres na esquerda e a coluna de
	 exibição na direita (ou seja, o valor da direita é {quantidade de
	 caracteres menos tabulações} + ({quantidade de tabulações} * {"tabstop"}).

[^5] E quando digo "quebrar" eu quero dizer "quebrar" mesmo: Enquanto que
	 "wrap" irá cuidar apenas da apresentação do texto, "textwidth" com
	 "formatoptions=t" irá inserir um caractere de nova linha quando a palavra
	 digitada ultrapassar o limite indicado.

[^6] Note que o VIM define uma variável para isso, mas nada garante que o autor
     do plugin utilizou essa tecla. Existe um padrão em usar "mapleader" como início
	 de comando normal de um plugin, mas nada obriga o autor do plugin à usar
	 esta tecla.

[^7] E, recapitulando, para reformatar o parágrafo caso você altere alguma
	 coisa no texto, use gq sobre a região do mesmo. O VIM irá considerar o
	 "textwidth" na hora de reformatar.

[^8] E não, não são todos os comandos que tem versões tanto em modo normal
     o quanto em modo de comando.

[^9] E porque eu usei `:tabn {número}` ao invés de `{número}gt`? Porque quando eu
     pesquisei como pular de abas, este foi o primeiro resultado que eu encontrei.

{{ chapters(prev_chapter_link="./11-config", prev_chapter_title="Arquivos de Configuração", next_chapter_link="./11-config", next_chapter_title="Arquivos de Configuração") }}
