+++
title = "Um Shell por Dia: Jobs"
date = 2021-10-04

[taxonomies]
tags = ["book", "por dia", "shell", "jobs"]
+++

Algumas vezes estamos rodando um comando que é demorado, mas precisamos ter
acesso novamente ao shell por algum motivo. Para isso, podemos suspender a
execução do processo com as teclas `Ctrl`+`z`. Um processo suspendo não executa
nada e não consome CPU, mas ainda está presente no sistema -- sendo chamado de
"job" nesse ponto.

Para ver a lista de jobs, basta chamar `jobs`. Note que o resultado desse
comando é a lista do nome do processo com um identificador.

Uma vez que eu tenha feito que precisava ser feito e quiser voltar para
aplicação, usa-se o comando `fg` (de "foreground"). Entretanto, eu posso querer
que a aplicação continue executando, mas não em primeiro plano; para isso,
existe o comando `bg` (de "background"). Chamados diretamente, `fg` e `bg` irão
trabalhar com o último comando executado mas é possível indicar um processo
específico para estes, usando o identificador apresentado em `jobs`.

{% note() %}
Uma forma de fazer uma aplicação iniciar diretamente em background é usar um `&`
no final da chamada; por exemplo `curl url &` irá iniciar o `curl` mas deixar o
terminal liberado, pois o comando estará rodando em background.

Seria o mesmo que chamar `curl url`, usar `Ctrl`+`z` para suspender a execução e
depois usar `bg` para fazer o processo rodar em background.
{% end %}

Quando um processo está em background, o terminal fica "bloqueado" para logouts
-- pois, afinal de contas, o shell ainda é pai dos processos, mesmo que eles
estejam em background. Para passar a guarda de um processo filho para o init --
e, assim, poder ser encerrado sem problemas -- pode-se usar o comando
`disown`. Assim, o processo em background ou suspendo passa a ser filho do init
e o terminal pode ser encerrado sem que o processo anterior seja encerrado junto.
