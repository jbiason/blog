+++
title = "12. Modelines"
date = 2015-12-22
weight = 3072
+++

Essa é a parte em que você ignora seus arquivos de configuração.

<!-- more -->

Bom, agora você sabe como configurar seu VIM, mudar configurações baseadas no
tipo de arquivo... Mas o que fazer se um arquivo tem uma configuração
completamente diferente do resto?

A solução são modelines. Modelines são linhas que você pode adicionar no seu
arquivo e o VIM, quando carregar o arquivo, irá mudar suas configurações
baseadas nesta linha.

A sintaxe da linha é, simplesmente: `vim: set {configurações}:`.

"Mas é um código fonte e se eu colocar um 'vim' no meio, o compilador vai
reclamar!", você deve estar pensando agora. Acontece que o VIM procura uma linha
válida em qualquer lugar, desconsiderando a sintaxe atual. Se você colocar o
modeline dentro de um comentário, o VIM ainda vai encontrar e ainda vai
processar o modeline e ainda vai trocar as configurações do editor (apenas para
aquele arquivo).

Por exemplo, para garantir que meus templates Jinja fiquem com a sintaxe
correta (usando a sintaxe de templates do Django), eu tenho colocado, como
última linha do arquivo

```django
{# vim: set ft=htmldjango: #}
```

"ft", no caso, é o nome curto para "filetype", que define o tipo de arquivo que
está sendo usando e qual sintaxe será utilizada. E o par `{#` e `#}` são
comentários do template e completamente ignorados no resultado final.

Assim como vimos antes, várias configurações podem ser usadas no mesmo set.
Usando o exemplo acima, se eu quisesse que meus templates usassem tabulações ao
invés de espaços para identação mas fossem apenas 2 espaços por tabulação, eu
poderia colocar, no final do arquivo:

```django
{# vim: set ft=htmldjango noet ts=2 sts=2 sw=2: #}
```

O VIM ainda aceita que as opções sejam separadas em vários comandos, com a
adição de ":":

```django
{# vim: set ft=htmldjango:set noet:set ts=2:set sts=2:set sw=2: #}
```

Mas realmente não faz sentido, faz?

E apenas um aviso: Algumas distribuções Linux desligam modelines no arquivo
global (adicionando `set nomodeline` no arquivo global) e, assim, modelines são
completamente ignorados, sob a desculpa de "segurança".  Tentando descobrir o
porque descobri o seguinte: O único comando que pode ser usado em modelines é
"set", ou seja, não é possível colocar um modeline que abra outro arquivo, ou
mude o diretório atual ou qualquer outra coisa; nem todas as configurações pode
ser alteradas (infelizmente, o help do VIM não lista quais são e quais não são
permitidas); e, aparentemente, a pior forma de "ataque" seria alguém colocar um
"textwidth" e seu código ficar torto na primeira edição. Se você achar que
modelines não estão sendo executados, você pode adicionar no seu vimrc `set
modelines` para que modelines sejam processados (ou troque por uma distribuição
que não tenha configurações que não fazem sentido).

{{ chapters(prev_chapter_link="./11-02-gvimrc", prev_chapter_title="Meu .gvimrc", next_chapter_link="./13-tags", next_chapter_title="Tags") }}
