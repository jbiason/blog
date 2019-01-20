+++
title = "02. Outros Comandos"
date = 2015-12-22
weight = 512
+++

Esta é a parte em que eu comento alguns comandos que você vai usar
esporadicamente.

<!-- more -->

Neste ponto você deve estar entendendo como os modos do VIM funcionam, para que
cada um funciona e tento uma idéia básica de como editar arquivos. Como eu
falei já duas vezes, a quantidade de comandos disponíveis é gigantesca, então
vamos aproveitar esse pequeno momento em que as coisas começam a fazer sentido
para ver mais alguns comandos.

## [Shift]+j (Modo normal)

"Junta" a linha abaixo do cursor com a atual. Pode não parecer muito, mas o VIM
irá colocar um espaço no final da linha atual[^1] antes de juntar com a linha
abaixo e removerá todo caractere branco da linha de baixo antes de juntar as
duas linhas.

## x (Modo normal)

Apaga o caractere sob o cursor. O mesmo que `[Del]`.

## gq (Modo normal)

Reformata o parágrafo. Não faz muito sentido para código (com algumas
exceções), mas se você tiver configurado a coluna máxima (vou explicar como
fazer isso na parte de configuração do VIM), você pode selecionar um comentário
em modo visual e usar gq para que o VIM alinhe o comentário no espaço definido.
Também serve para quando você estiver editando arquivos de markup (MarkDown,
reSTRUCTURED text, HTML, etc).

## gg e G (Modo normal)

`gg` move o cursor para o início do arquivo e `G` move o cursor para o fim do
arquivo. Efetivamente, fazer `ggdG` (mover o cursor para o início do arquivo,
remover tudo até o final do arquivo) irá remover todo o conteúdo do arquivo.

## = (Modo normal)

Reidenta o código usando a sintaxe atual.

## u e [Ctrl]+r (Modo normal)

Undo e redo, respectivamente.

## [Ctrl]+y e [Ctrl]+e (Modo normal e Modo de inserção)

Dois comandos que funcionam de forma diferente se executados em modo normal ou
modo de inserção.

No modo normal, `[Ctrl]+y` irá rolar o conteúdo do texto para baixo, mantendo o
cursor na mesma posição enquanto que `[Ctrl]+e` irá rolar o conteúdo para cima,
ainda mantendo o cursor na mesma posição. Se você abusar destes comandos,
movendo a linha onde o cursor se encontra para fora da área visível, o cursor
irá se mover.

No modo de inserção, no entanto, `[Ctrl]+y` irá copiar o caractere da linha de
cima na mesma coluna na posição atual; `[Ctrl]+e` faz o mesmo, mas com a linha de
baixo.

## . (Modo normal)

Repete o último comando. Note que `.` irá repetir o último comando completo. Por
exemplo, quando eu falei sobre `ggdG`, estamos falando, na verdade, de dois
comandos completos: `gg` e `d{movimentação}`. `.`, neste caso, irá repetir o comando
`dG`. Mais adiante veremos como criar "macros de teclado" e efetivamente permitir
a execução de coleções de comandos.

## :e e :files (Modo de comando)

Edita um arquivo. Se não for passado o nome do arquivo depois do comando, o
mesmo arquivo é recarregado do disco (em outras palavras, o buffer é atualizado
com o conteúdo do arquivo). `:e#` recarrega o último arquivo aberto (por exemplo,
se você estiver com o arquivo "arquivo" aberto e fizer `:e arquivo2`, usar `:e#`
irá recarregar "arquivo" para o editor; usando `:e#` de novo, "arquivo2" será
apresentado).

Você pode ver os últimos arquivos abertos na sessão atual do VIM com `:files`. Se
quiser recarregar algum destes arquivos de novo, basta usar `:e#{número}`, onde
{número} é o número do arquivo na lista.

## :sh (Modo de comando)

Abre um shell dentro do VIM. Para retornar ao VIM, basta encerrar o shell.

## :{número} (Modo de comando)

Pula para a linha indicada. Por exemplo, `:100` irá para a centésima linha do
arquivo.

## [Ctrl]+] e [Ctrl]+t (Modo normal)

`[Ctrl]+]` pula para a tag sob o cursor e `[Ctrl]+t` retorna. Mais adiante veremos
como criar um arquivo de tags para que o VIM consiga navegar pelo código. A
mesma idéia é usada no help do VIM: se você digitar `:help` irá ver a primeira
página de ajuda do editor; para navegar entre os tópicos apresentados (marcados
de forma diferente, dependendo do esquema de cor utilizado), é utilizado
`[Ctrl]+]` para avançar e `[Ctrl]+t` para retornar para a página anterior.

## ~ (Modo normal)

Altera o caractere sob o cursor para maiúscula se for minúscula e vice-versa e
move o cursor uma posição pra frente.

## gu{movimentação}, gU{movimentação} e g~{movimentação} (Modo normal)

`gu{movimentação}` altera todos os caracteres em {movimentação} para minúsculas.

`gU{movimentação}` altera todos os caracteres em {movimentação} mara maiúsculas.

`g~{movimentação}` faz `~` nos caracteres em {movimentação} (ou seja, os caracteres
da posição do cursor até movimentação ficarão em maiúsculas se estiverem em
minúsculas e vice-versa).

## [Ctrl]+p e [Ctrl]+n (Modo de inserção)

Auto-complete. `[Ctrl]+p` tenta completar a palavra antes do cursor voltando no
texto enquanto que `[Ctrl]+n` tenta completar com palavras mais a frente no
texto.

## [Ctrl]+a e [Ctrl]+x (Modo normal)

Incrementa (`[Ctrl]+a`) ou decrementa (`[Ctrl]+x`) o número sob o cursor. O VIM
automaticamente detecta se o número está em decimal, octal ou hexa.

E MAIS!

## w (Modo normal)

Move o cursor para o começo da próxima palavra.

## e (Modo normal)

Move o cursor para o fim da próxima palavra.

## b (Modo normal)

Move o cursor para o começo da palavra anterior.

## ge (Modo normal)

Move o cursor para o fim da palavra anterior.

[^1] ... a não ser que o primeiro caractere (não branco) da linha de baixo seja
     um ")"; neste caso, o VIM não adiciona o espaço.

{{ chapters(prev_chapter_link="./01-05-modo-de-comando", prev_chapter_title="Modo de Comando", next_chapter_link="./03-recortar-copiar-colar", next_chapter_title="Recordar, Copiar e Colar") }}
