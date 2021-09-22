+++
title = "Um Shell Por Dia: Entradas e Saídas"
date = 2021-09-13

[taxonomies]
tags = ["books", "por dia", "shell", "entradas", "saídas", "stdin", "stdout", "stderr"]
+++

Antes de sairmos vendo comandos e coisas do tipo, vamos começar com um conceito
básico: entradas e saídas.

Para entradas e saídas em sistemas POSIX (incluindo os Unixes e Linux), existem
três "descritores" que estão presentes para todas as aplicações:

* `stdin`, que é descritor de entrada de dados (com o identificador "0");
* `stdout`, que é o descritor de saída padrão (com o identificador "1"); e
* `stderr`, que é o descritor de saída para erros (com o identificador "2").

Por exemplo, quando uma aplicação começa a jogar informações para o usuário,
ela está escrevendo no `stdout`; quando a aplicação fica esperando que o
usuário digite alguma coisa, ela fica tentando ler de `stdin`.

A importância desta informação ficará mais clara mais pra frente, quando
começarmos a ver redicionamentos e pipes.
