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

<!-- 
vim:spelllang=pt:
-->
