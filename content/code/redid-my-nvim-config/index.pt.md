+++
title = "Eu Refiz Minha Configuração do NeoVim"
date = 2022-01-19

[taxonomies]
tags = ["vim", "neovim", "configuração", "lsp", "treesitter"]
+++

Por algum motivo obscuro, minha instalação do NeoVim não queria mais mostrar os
alertas do LSP. Então eu decidi refazer minha configuração.

<!-- more -->

Acredite-me, eu não fiz porque "PQP, tudo quebrado". Eu acredito que eu poderia
encontrar o problema com a forma como o
[LanguageClient](https://github.com/autozimu/LanguageClient-neovim) estava
instalado -- poderia até mesmo estar desatualizado, já que eu atualizei para o
NeoVim 0.6 recentemente -- mas eu também geria instalar o TreeSitter para ter
um suporte melhor à coloração do fonte. Estes dois fatores foram suficientes
para tentar fazer uma configuração nova, e eu decidi que eu iria fazer a coisa
toda, usando o arquivo de configuração em formato Lua.

Eu comecei com [o post do Takuya
Matsyama](https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887)
como referência -- eu não costumo usar gerenciadores de pacote (e provavelmente
aí é que está o problema com o plugin desatualizado) e eu prefiro trabalhar com
submódulos e coisas do tipo -- um formato que é bem próximo da forma como o
[Pathogen](https://github.com/tpope/vim-pathogen) funciona.

Como eu queria mover algumas coisas da minha antiga configuração para a nova,
eu precisei procurar como "traduzí-las". Foi aí que eu encontrei [um post por
Heiker Curiel](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/),
que lista as antigas opções de configuração e como elas aparecem numa
configuração em Lua.

O resultado é que eu agora tenho uma instalação novinha do NeoVim, com todas as
firulas:

![](vim6.png "Sim, eu gosto de escrever longas descrições para as funções")

O arquivo de configuração (e submódulos) está no [meu repositório pessoal do
Git](https://git.juliobiason.me/dotfiles.git/tree/nvim).

### O que ficou pra trás?

Enquanto eu estava migrandion, eu resolvi não adicionar algumas coisas nessa
nova configuração:

- Fuzzy find: Anteriormente eu estava usando o
  [Skim](https://github.com/lotabout/skim) para abrir arquivos com fuzzy find
  (digite algumas letras, veja uma lista de arquivos que tem essas letras). O
  plugin do Vim para o Skim apresentava alguns problemas (algumas vezes
  ignorando completamente o que era digitado na entrada, o que me faz pensar
  que o plugin teria crasheado de alguma forma). Mas, como eu só usava quando
  estava entediado, eu acabei deixando a opção de fuzzy find de fora; minha
  forma favorita de procurar arquivos é usando o atalho `-`, que eu botei para
  chamar o `:Ex`.
- Snippets: [UltiSnips](https://github.com/sirver/UltiSnips) não estava
  funcionando antes então eu resolvi não tentar de novo. Eu provavelmente vou
  procurar por alguma outra opção no futuro.
- Configuração por tipo de arquivo: Anteriormente eu tinha um bocado de
  "autocommands" para definir configurações específicas para cada arquivo (por
  exemplo, arquivos Python devem usar espaços ao invés de tabulações, mas
  arquivos HTML devem usar tabulações ao invés de espaços). Eu deixei de fora
  porque, até onde eu vi, não há suporte na versão em Lua para isso (ainda é
  possível rodar comandos VimScript, mas eu tô sendo meio chato com relação à
  isso).
- Remover espaços no final das linhas: A minha configuração anterior tinha um
  autocommand para executar uma expressão regular que removia todos os espaços
  no final das linhas. Como eu atualmente estou usando mais Rust e a
  configuração do LSP roda um autoformatter (no caso, o `rustfmt`) e isso já
  remove os espaços, eu decidi não aplicar essa opção de novo.

<!-- 
vim:spelllang=pt:
-->
