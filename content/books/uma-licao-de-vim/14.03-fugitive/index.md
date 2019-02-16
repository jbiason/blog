+++
title = "14.03. Plugins - Fugitive"
date = 2015-12-22
weight = 3587
+++

Essa é a parte que só faz sentido se você usa Git.

<!-- more -->

O terceiro plugin que eu vou comentar é
[Fugitive](https://github.com/tpope/vim-fugitive), que adiciona comandos para
gerenciar seu repositório Git dentro do VIM.

Para instalar, ou você baixa a versão do Github (no link acima) ou usa o Vundle:

```viml
Plugin "tpope/vim-fugitive"
```

(E, de novo: depois de adicionar essa linha no seu vimrc, você deve sair do VIM
-- ou, se não quiser fazer tudo isso, basta usar o comando acima em modo de
comando -- e usar `:PluginInstall` para instalar o plugin.)

A princípio, nada de diferente deve aparecer. Mas você agora pode usar qualquer
comando do Git com `:Git {comando}`, como faria no shell.

Mas só adicionar um comando não é o que o Fugitive faz. Ele também adiciona
outros comandos:

* `:Gwrite` (ou `:Gw`): salva o arquivo atual e já adiciona no index para o
  próximo commit.
* `:Gblame`: Faz um split da tela, mostrando do lado direito o fonte que já
  estava aberto e do lado esquerdo, o último commit (SHA1) e o autor do commit.
* `:Gread`: Descarta as alterações locais e recupera o arquivo atual na sua
  última revisão dentro do repositório do Git (ou seja, revert).
* `:Gdiff`: Mostra um diff da versão atual com a versão no repositório, com
  splits.
* `:Gcommit`: Faz o commit dos arquivos que estão no index.
* `:Gstatus`: Faz um "git status", mas deixa que você altere os arquivos no
  index (usando "-" para adicionar ou remover o arquivo -- leia o texto com
  atenção) e faça commit dos selecionados (usando "cc") [Note que ambos os
  comandos devem ser usados em modo normal dentro do split aberto por
  `:Gstatus`.]

Existem outros, mas você vai usar principalmente estes. E cuide para que você
esteja dentro de um repositório Git antes de tentar usar os comandos; se o VIM
não estiver num diretório com um repositório válido, nenhum dos comandos do
Fugitive ficarão disponíveis[^1].

E, como última dica: Se você estiver usando o Airline (comentado no capítulo
anterior), adicione

```viml
let g:airline_enable_branch = 1
```

... no seu vimrc e o branch atual será apresentando dentro do status do
Airline, logo após o indicador de modo.

[^1] Eu só preciso adimitir que não testei para ver o que acontece se você
	 abrir o VIM fora de um repositório e depois usar `:cd` para mudar para um
	 diretório que tem um repositório ou tentar abrir um arquivo que está
	 dentro de um repositório para verificar se os comandos se tornam
	 disponíveis.

{{ chapters(prev_chapter_link="./14-02-airline", prev_chapter_title="Plugins - Airline", next_chapter_link="./14-04-commentary", next_chapter_title="Plugins - Commentary") }}
