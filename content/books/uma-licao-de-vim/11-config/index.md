+++
title = "Arquivos de Configuração"
date = 2015-12-22
+++

Essa é a parte em que eu menti.

<!-- more -->

Lembram que bem no começo, quando estávamos falando dos modos de execução, eu
comentei que o modo Ex não era usado?

Bom, eu menti. MUAHAHAHAHA!

![](muahaha.jpg)

Na verdade, o Modo Ex não é chamado comumente, mas os arquivos de configuração
do VIM são um grande amontoado de comandos executando em modo Ex.

E o que é o modo Ex, afinal de contas? O modo Ex nada mais é que o modo de
comando sem a necessidade de usar `:` na frente de todos os comandos. Como
ficaria complicado para, por exemplo, entrar no modo Ex, executar e arquivo,
sair do modo ex e entrar em modo de inserção, até o momento temos usado o modo
de comando para isso, já que economiza um monte de tecladas. Como não iremos
ficar indo para o modo de inserção o tempo todo, e não faz sentido fazer um
arquivo gigantesco com várias linhas começando com `:`, também faz sentido que o
arquivo de configuração seja executado em modo Ex.

O VIM tem um arquivo de configuração global (conhecido com "vimrc") e um arquivo
para execução em modo gráfico ("gvimrc")[^1]. Ainda, existem duas versões de cada
um destes arquivos: uma versão global para todos os usuários e uma versão
definida para o usuário atual. Daqui pra frente, iremos ver as configurações do
usuário, já que estas sobrepõem as globais.

"vimrc" e "gvimrc" ficam no diretório dos dados do usuário; em qualquer um dos
sistemas operacionais hoje, você consegue descobrir o diretório destes arquivos
com `:echo $HOME` dentro do próprio VIM. Apenas note que embora eu venho chamando
os arquivos de vimrc e gvimrc, os nomes são, na verdade, ".vimrc" e ".gvimrc" (ou
"\_vimrc" e "\_gvimrc" no caso do Windows).

Como existem muitas opções, não vou aqui explicar cada uma delas -- mas, no
próximo capítulo eu vou mostrar o arquivo que eu estou usando para servir de
guia.

O que você vai ver quando abrir um arquivo de configuração:

## set

`set` é, efetivamente, a forma de "setar" alguma configuração no VIM.

Existem dois tipos de configurações: As com valores e flags.

Flags é mais fácil de ser explicado: você simplesmente seta a configuração. Por
exemplo, fazer com que o VIM mostre uma coluna com o número de cada linha,
você pode usar `:set number` (ou simplesmente `set number` dentro do arquivo de
configuração). Para desligar uma opção deste tipo, você só precisa adicionar
"no" na frente (para desligar number é usado `:set nonumber`).

"Valores" é exatamente o que significa: Ao invés de ser uma simples flag, a
opção recebe uma string ou número. Por exemplo, `:set tabstop=4` irá definir que
o tamanho da tabulação é de 4 espaços. `:set notabstop` não tem efeito aqui, já
que não é uma flag.

Para fazer com que uma configuração volte ao seu valor/estado original, use
`:set {opção}&`; para verificar o valor de uma opção, use `:set {opção}?`.

Talvez a coisa não esteja muito clara aqui, mas quando examinarmos um arquivo
de configuração real, as coisas irão clarear.

## let

`let` é usado para definir o valor de uma variável. Uma variável tem sempre um
valor -- ou seja, não existem "variáveis flags". Variáveis são normalmente
utilizadas por plugins ou arquivos de sintaxe e, portanto, as variáveis que
você terá que usar vão depender do que você está usando.

(Obviamente, se você estiver escrevendo seu próprio plugin — que eu não vou
abordar aqui — o uso de variáveis vai ser praticamente obrigatório.)

## if

`if`, como em qualquer linguagem de programação, serve para execução
condicional. Você pode, por exemplo, verificar se alguma feature foi ativada na
compilação do binário, se alguma opção está ligada, etc.

Por exemplo, para verificar se o suporte à scripts Python foi adicionado, você
pode fazer:

```viml
if has('python')
   " configuração em python vai aqui
end
```

Para verificar se alguma opção está ativa:

```viml
if &compatible
   " configuração em modo de compatibilidade com o VI original
end
```

ou para conferir um valor:

```viml
if &t_Co > 2
   " configuração quando há suporte a mais de 2 cores.
end
```

E assim por diante.

## map, imap (e outros)

`map` pode ser usado para mapear teclas para outras funções. Por exemplo `:map Y
y$` irá mapear "Y" para executar `y$` (copiar da posição atual do cursor até o fim
da linha). Com excessão de [Shift], qualquer modificador pode ser usado:

* C - para `[Control]`
* M - para `[Alt]` (que normalmente é chamado de "Meta" em sistemas Unix — e por isso "M")
* O - para `[Command]` (somente em Macs)

Por exemplo, `:map C-m yy` irá adicionar `[Ctrl]m` para copiar a linha inteira.

Ainda, a diferença entre `map` e `imap` é que `map` é global enquanto que
`imap` só irá funcionar em modo de inserção (e assim você pode imaginar o que
`nmap` e `vmap` fazem, certo?)

## au (ou autocmd)

Comandos que são executados em determinadas condições. Condições podem desde
"FileType" para ações confirme o tipo de arquivo e "BufRead", "BufWrite" e
relacionados quando um buffer for aberto ou fechado.

O que seriam os "relacionados"? Bom, alem de ser na leitura/escrita do arquivo,
podem ser adicionados comandos antes da execução ("BufReadPre", "BufWritePre"),
depois da execução ("BufReadPost", "BufWritePost") e durante ("BufReadCmd",
"BufWriteCmd").

(Existem ainda auto-comandos para quando o editor entrar em modo de edição,
abrir o VIM gráfico, VIM está fechando, e assim por diante. Para ver todos os
eventos, digite `:help autocmd-events`.)

Por exemplo, `au FileType smarty set ai` para ligar a auto-identação quando VIM
detectar que você está editando um arquivo Smarty (engine de templates para
PHP). Ou ainda `au BufRead set nocompatible` irá configurar o editor para entrar
em modo de não-compatibilidade com VI depois de abrir qualquer arquivo.

Ainda, é possível encadear auto-comandos, por exemplo, `autocmd FileType python
autocmd BufWritePre :%s/\s\+$//e` irá fazer com que quando o tipo de arquivo for
"python", seja criado um auto-comando que antes de salvar o arquivo, seja
executado um comando de substituição no buffer -- que remove espaços em branco
no final da linha).

(Se você está perdido com o que está vendo aqui, não se preocupe -- a tendência
é que, ao ver um arquivo de configuração real, você entenda o que está
acontecendo).

[^1] Existe um terceiro, .exrc, mas honestamente, em todo esse tempo usando o
     VIM, eu nunca tinha ouvido falar que este arquivo sequer existia.

{{ chapters(prev_chapter_link="./10-abas", prev_chapter_title="Abas", next_chapter_link="./11-01-vimrc", next_chapter_title="Meu .vimrc") }}
