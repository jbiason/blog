+++
title = "10. Abas"
date = 2015-12-22
weight = 2560
+++

Essa é a parte me que você acha coisas que já fazia antes.

<!-- more -->

Além dos splits, que vimos no capítulo anterior, VIM também tem suporte à abas.
O mais interessante é que você pode usar abas tanto no VIM gráfico (também
chamado de GVim) quanto no console.

Para abrir um arquivo no VIM, sabemos que temos que usar o comando `:e`; para
abrir o arquivo em uma aba, o comando é `:tabe`.

Ao contrário de splits, criar uma nova aba sem passar um arquivo não cria uma
nova aba com o buffer atual; `:tabe` sem um nome de arquivo irá criar uma nova
aba com um buffer em branco. E sim, você pode abrir o mesmo arquivo em mais de
uma aba e as alterações feitas em uma irão refletir na outra.

Para pular entre abas, você poder usar o comando `gt` em modo normal ou `:tabn` em
modo de comando. Se você usar um número de repetições (p.ex. `3gt` ou `:tabn 3`) o
VIM irá pular diretamente para aquela aba (no caso, para a terceira), não
importando a aba atual. `gT` em modo normal ou `:tabp` move o cursor para a aba
anterior.

Se quiser mover abas de posição, você deve usar `:tabm`. `:tabm` irá mover a aba
atual para ficar depois da aba indicada (p.ex., `:tabm 3` irá mover a aba atual
para depois da terceira aba). `:tabm` também aceita parâmetros considerando a aba
atual: `:tabm +2` irá mover a aba atual duas abas pra frente (para a direita) e
`:tabm -2` irá mover a aba duas abas pra trás (para a esquerda).

Atalhos padrão para mover para a próxima aba do sistema operacional também são
aceitos por padrão. `[Ctrl][PageDn]` e `[Ctrl][PageUp]` no Linux e
`[Command][Shift]]` e `[Command][Shift][` no OS X, por exemplo. Como não existe
nenhum padrão para consoles, não há nenhum atalho padrão e devem ser usados os
comandos de seleção de abas que vimos antes.

Mais pra frente, quando estivermos falando do arquivo de configuração, eu vou
explicar um "truque" para pular diretamente para a aba desejada, assim como
funciona no Firefox e no Chrome.

{{ chapters(prev_chapter_link="./09-splits", prev_chapter_title="Splits", next_chapter_link="./11-config", next_chapter_title="Arquivos de Configuração") }}
