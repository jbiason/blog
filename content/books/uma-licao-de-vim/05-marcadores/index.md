+++
title = "Marcadores"
date = 2015-12-22
+++

Essa é a parte em que você não vai mais precisar se lembrar da última linha
que estava editando.

<!-- more -->

Algumas vezes você precisa ficar pulando entre partes diferentes do seu
arquivo. Alguns editores oferecem a funcionalidade de "bookmark" para linhas
específicas e ficam "pulando" entre estes bookmarks. O VIM tem uma
funcionalidade semelhante, chamada "Marcadores". A diferença é que enquanto os
demais editores só tem um estado para marcadores (ativo ou não), o VIM permite
que você tenha até 26 marcadores únicos -- e que podem ser acessados
diretamente.

Para marcar uma linha, você deve usar `m{nome do marcador}` em modo normal, onde
`{nome do marcador}` é uma letra de "a" a "z". Para ir diretamente para um
marcador, é só usar `'{nome do marcador}` para simplesmente mover o cursor para o
primeiro caractere não branco na linha do marcador ou `\`{nome do marcador}` para
mover o cursor exatamente para a posição do marcador (ambos também em modo
normal).

Como tudo no VIM, maiúsculas e minúsculas fazem diferença.

Criar um marcador com um nome em minúsculas signifca que o marcador é valido
somente dentro do arquivo. O marcador "a" do arquivo "arquivo1" não é o mesmo
marcador "a" do arquivo "arquivo2". Quando um marcador é criado em maiúsculas,
ele se torna global: Se você fizer `mA` no arquivo "arquivo1" e abrir o arquivo
"arquivo2", `\`A` irá voltar para o arquivo "arquivo1" (na posição do marcador,
obviamente).

E como tudo no VIM, sempre existem os comandos mágicos.

## \`\` ou ''

Retorna para a última posição onde foi feito um "pulo". Por exemplo, se você
está na linha 100 do arquivo atual, e fizer um pulo para o marcador "a" (com `\`a`,
por exemplo), ``\`\`` irá retorna para a linha 100. Note que isso não gera um
marcador per se, já que fazer ``\`\`` de novo irá retornar para a posição do
marcador "a" (pois foi lá que aconteceu o último pulo).


## \`. ou '.

Retorna para a última posição onde houve alteração de texto. O exemplo que eu
posso pensar neste caso é quando você está digitando um comando e não se lembra
se fez o #include ou import necessário. Neste caso, você simplesmente termina
de digitar o comando, usa `gg` para ir para o começo do arquivo para verificar se
o include/import está lá e, se tiver, usa `\`.` para retornar para a posição
original.


## \`[ ou '[ e \`] ou ']

Retorna para a posição onde o texto foi copiado ("yanked") para a área de
transferência (qualquer área de transferência). `[` irá mover para o primeiro
caractere copiado e `]` para o último.


## \`" ou '"

Move para a última posição do arquivo quando o arquivo foi fechado. Isto
normalmente é controlado pelo arquivo de inicialização, que veremos mais a
frente.

E, para ver onde estão as marcas atuais, você só precisa usar `:marks` no modo de
comando.

{{ chapters(prev_chapter_link="./04-registradores", prev_chapter_title="Registradores", next_chapter_link="./04-registradores", next_chapter_title="Registradores") }}
