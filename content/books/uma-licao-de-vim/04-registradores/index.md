+++
title = "04. Registradores"
date = 2015-12-22
weight = 1024
+++

Essa é a parte que o VIM fica melhor que os outros editores.

<!-- more -->

No capítulo anterior eu mencionei que o VIM tem uma área de transferência
própria e que ela não se comunica diretamente com a área de transferência do
sistema operacional, apenas através de registradores.

A forma mais simples de pensar em registradores é: são marcadores para áreas de
transferência com nomes[^1].

Para acessar os registradores, você deve usar `"{nome do registrador}`, onde
{nome do registrador} é uma letra apenas. Assim, para copiar texto para um
registrador, é utilizado `"{registrador}y{movimento}`; para retirar depois este
texto do registrador, é utilizado `"{registrador}p`.

Enquanto você estava vendo yank'n'paste do VIM, o VIM estava guardando o texto
numa área de transferência apontanda pelo "registrador sem nome". E eu não
estou brincando aqui: O próprio help do VIM chama este registrador de
"registrador sem nome". A letra do registrador sem nome é `"` (ou seja, `""yy` e
`yy` ambos irão copiar a linha atual para o registrador sem nome).

Números são registradores especiais. 0 contém o último texto copiado para área
de transferência; de 1 a 9 ficam os textos excluídos, em forma de pilha (o mais
recente no registrador 1, o anterior a este no 2 e assim por diante; e quando
mais texto é excluído, o conteúdo vai para o registrador 1, o conteúdo do
registrador 1 vai para o registrador 2 e assim por diante).

`-` é um registrador que guarda qualquer coisa excluída que for menor que uma
linha inteira.

Registradores com letras de "a" a "z" funcionam exatamente como esperado: `"ayy` irá
copiar a linha atual para o registrador "a" enquanto que `"bp` irá colar o conteúdo
do registrador b.

Note que até agora eu chamei os registradores normais com minúsculas. O motivo
é que, ao copiar algo para um registrador, o conteúdo anterior é removido, a
não ser que você passe o nome do registrado em maiúsculas. Neste caso, o
conteúdo movido para a área de transferência do registrador é adicionado ao
conteúdo já existente. Assim, você pode copiar linhas não-contíguas usando `"ayy`
para a primeira linha, `"Ayy` para as demais e depois colar com `"ap` (para o paste
não há diferença entre maiúsculas e minúsculas).

Outros registradores especiais são:

## =

Registrador de expressões. Você pode entrar fórmulas e depois colar o resultado
no conteúdo com `p`. Uma coisa a cuidar aqui é que não é possível fazer `"=p`; o
VIM irá imediatamente abrir espaço para entrar a fórmula ao digitar `"=`; ainda,
o conteúdo é perdido se depois de digitar a fórmula você utilizar qualquer
comando que não seja `p` (incluindo os comandos de movimentação).

## _

Registrador "buraco negro" (de novo, eu não estou brincando, o help do VIM
chama esse registrador de "buraco negro"). Qualquer coisa enviada para este
registrador é perdida; paste deste registrador retorna nada. Útil quando você
quer excluir algum texto sem mexer no registrador sem nome.

## +

Registrador da área de transferência do sistema operacional. Somente disponível
para aplicações GUI, já que estas tem acesso direto ao sistema (no caso do VIM
console em Linux, o "sistema operacional" seria o próprio shell, que não tem
uma área de transferência -- se você pensar nas bibliotecas envolvidas, a coisa
faz sentido).

[^1] Registradores também são usados para outras coisas, mas veremos isso mais pra frente.

{{ chapters(prev_chapter_link="./03-recortar-copiar-colar", prev_chapter_title="Recortar, Copiar e Colar", next_chapter_link="./05-marcadores", next_chapter_title="Marcadores") }}
