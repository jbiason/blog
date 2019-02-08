+++
title = "14.04. Plugins - Commentary"
date = 2015-12-22
weight = 3588
+++

Essa é a parte em que automatizamos a técnica de sumir código sem sumir com o
código.

<!-- more -->

O quarto plugin da lista de plugins é
[Commentary](https://github.com/tpope/vim-commentary).

Como de costume, para instalar, você pode baixar o conteúdo do repositório
acima para dentro do seu ~/.vim/ (o diretório, não o arquivo de inicialização)
ou usar o Vundle:

```viml
Plugin "tpope/vim-commentary"
```

Commentary não é um plugin visual, o que significa que, mais uma vez, depois de
instalado você não verá nada de novo.

O que o Commentary faz é adicionar um atalho para comentar linhas de código,
baseado no tipo de arquivo atual. O atalho é \\\\{movimentação} ou \\\\\\ para
comentar a linha atual (ou você pode entrar em modo visual para selecionar as
linhas e fazer \\\\ e a parte selecionada vai ficar comentada); para descomentar,
basta fazer a mesma coisa (ou seja, se o pedaço selecionado não estiver
comentado, ele será comentado; se já estiver comentado, o comentário será
removido.)

E era isso.

A única ressalva aqui fica por conta de um comportamento padrão do VIM: O VIM
tem apenas um tipo de arquivo (definido com `:set filetype={sintaxe}`) que vale
para todo o arquivo. Assim, se você estiver usando a sintaxe de HTML,
Commentary provavelmente não irá comentar seu código JavaScript corretamente. A
coisa fica pior se você estiver editando um arquivo com sintaxe de template, já
que o tipo de arquivo é o template, não HTML ou JavaScript ou CSS.

Ainda, aproveitando o gancho, existem sintaxes e sintaxes. Algumas sintaxes são
antigas e estão definidas de uma forma que o VIM perde o contexto do código
apresentado e apresenta com a coloração errada (andar no texto em direção ao
começo do arquivo, com [PageUp], normalmente resolve esse problema, pois o VIM
encontra um ponto onde a sintaxe volta a fazer sentido). Por exemplo, a sintaxe
"htmldjango", que funciona também para arquivos Jinja2 tem a leve tendência de
se perder em arquivos muito longos; usando uma sintaxe externa para Jinja2
(usando `:Plugin "Glench/Vim-Jinja2-Syntax"`) esse problema não acontece.

Então lembre-se: Se a sintaxe "pirar", voltar um pouco para o começo do arquivo
deve resolver (e, depois disso, o VIM carrega o contexto a medida que você for
voltando para o ponto original) e sempre verifique se não há um arquivo de
sintaxe que corresponda melhor às suas necessidades.

{{ chapters(prev_chapter_link="./14-03-fugitive", prev_chapter_title="Plugins - Fugitive", next_chapter_link="./14-05-tabular", next_chapter_title="Plugins - Tabular") }}
