+++
title = "Um Shell Por Dia: Pipes"
date = 2021-09-14

[taxonomies]
tags = ["book", "por dia", "shell", "entradas", "saídas", "stdin", "stdout"]
+++

Ainda sobre entradas e saídas, imagine que você queira usar a saída de um
arquivo como entrada de outro. Usando apenas direcionamentos, poderíamos fazer:

```
comando1 > um_arquivo
comando2 < um_arquivo
```

(ou seja, salvar a saída de `comando1` em um arquivo qualquer -- que chamamos
de "um_arquivo" aqui -- e usar o conteúdo desse arquivo como entrada para
`comando2`.)

Com pipes, podemos fazer isso diretamente:

```
comando1 | comando2
```

O que o pipe (aquele "`|`") faz é pegar o stdout do comando da esquerda e fazer
com que esse seja o stdin do comando da direita.

A ligação pode ser usadas quantas vezes você quiser:

```
comando1 | comando2 | comando3 | comando4
```

O stdout de comando1 vai ficar como stdin do comando2; o stdout do comando2 vai
ser o stdin do comando3; e stdout do comando3 vai ser o stdin do comando4.

E como o pipe trabalha apenas com stdout, não dá pra fazer algo com stderr. Mas
você pode usar redicionamentos para mandar stderr para stdout e aí usar o pipe.

```
comando1 2>&1 | comando2
```
