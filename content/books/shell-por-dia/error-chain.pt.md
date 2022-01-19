+++
title = "Um Shell por Dia: Error Chain"
date = 2021-09-22

[taxonomies]
tags = ["books", "por dia", "shell", "erros"]
+++

Quando um comando é executado, ele "emite" um código para o shell indicando o
resultado de sua execução. Por exemplo, se você rodar `ls` e estiver no Bash,
você pode ver o resultado do comando com `echo $?` -- que será 0, já que o ls
conseguiu executar (a não ser que você esteja num diretório que não tem
permissão de listar o conteúdo, mas enfim).

{% note() %}
Para quem programa/programou em C, deve lembrar das constantes `EXIT_SUCCESS` e
`EXIT_FAILURE`, que ficavam no final do `main()`. Bom, SUCCESS tem definido o
valor 0 e FAILURE 1, e se você quiser, pode brincar de criar uma aplicação que
retorne os dois valores e verificar o resultado com o `echo $?`.
{% end %}

Algumas aplicações utilizam vários códigos diferentes para indicar que a
execução foi terminada por um erro específico.

Mas para encadeamento de erros, só precisamos saber que 0 é "tudo terminou
certo" e qualquer coisa diferente disso é "deu erro".

Para encadear comandos, podemos usar `&&` e `||`.

`&&` indica "se o comando anterior terminar em sucesso, execute o próximo
comando". Por exemplo `ls && cp arq1 arq2` indica que, se o `ls` terminar com
sucesso, então o comando `cp` (que copia arquivos) será executado; se, por algum
motivo, o `ls` falhasse, o comando `cp` não seria executado.

`||` indica "se o comando anterior falhar, execute o próximo comando". Assim,
`ls || cp arq1 arq2` faria com que o `cp` somente fosse executado se o `ls`
falhasse.

E vários comandos podem ser encadeados dessa forma:

```
ls && cp arq1 dir/arq2 || mkdir dir
```

Irá fazer o `ls`; se ele não falhar, executa o `cp`; se o `cp` falhar, cria o
diretório.
