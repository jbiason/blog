+++
title = "Um Shell Por Dia: Redirecionamento"
date = 2021-09-14

[taxonomies]
tags = ["por dia", "shell", "redirecionamento", "stdin", "stdout", "stderr"]
+++

Agora que conhecemos os descritores de entrada, saída e erro, vamos ver como
redirecionar a saída dos descritores para arquivos.

Vamos pegar um exemplo simples: `python manage.py migrate`, um comando que faz
parte do Django que altera o banco de dados. Se quisermos mandar a saída do
comando para um arquivo, podemos usar `>`:

```
python manage.py migrate > saida_migrate.txt
```

Quando seguido por `>`, o shell faz com que o stdout de uma aplicação seja
enviada para um arquivo e, assim, qualquer saída da aplicação (com exceção do
que for escrito no stderr) será mandando para o arquivo.

Ainda, o arquivo é zerado toda vez que houver o redicionamento, e assim,
executar o comando acima duas vezes seguida fará com que o arquivo
"saida_migrate.txt" fique apenas com o resultado da segunda execução. Para
adicionar o conteúdo no final do arquivo ao invés de sobreescrever o conteúdo
inteiro, deve-se usar `>>` ao invés de `>`.

Mas, mais uma vez, até agora vimos como mandar stdout para um arquivo. Em
alguns casos, erros são enviados para stderr ao invés de stdout. Para
redirecionar stderr, usa-se `2>`.

E, finalmente, aplicações que esperam entrada de dados -- digamos que o nosso
comando acima esperasse uma configuração, algo como "Type 'y' to continue" --
poderíamos criar um arquivo com `y` dentro e mandar isso para o migrate com
`<`:

```
python manage.py migrate < confirmacao
```

Até aqui, simples e direto. Existe ainda uma questão: Imagine que você queira
que toda a saída de uma aplicação, stdout e stderr, seja enviada para um
arquivo. A princípio, você tentaria

```
python manage.py migrate > arquivo 2> arquivo
```

O problema desta chamada é que a saída do stdout iria criar o arquivo, e a
saída do stderr iria sobreescrever esta saída e mandar o stderr apenas (existe
uma complicação entre "descritores" e "arquivo em disco", onde o descritor pode
estar escrevendo num arquivo em disco que não existe mais, e para a aplicação
tudo continua andando normalmente, embora não pareça porque o arquivo não
exista, mas vamos ignorar essa parte aqui) o que podemos fazer é enviar o
stderr para stdout e redirecionar o stdout para o arquivo. Para redirecionar
stderr para stdout usamos `2>&1` -- `2>` é realmente a saída do stdout, e `&1`
indica que queremos que a saída indicada seja enviada para o descritor "1" --
que é o stdout.

E ainda dá pra usar todo mundo junto:

```
python manage.py migrate 2>&1 > saida_migrate.txt < confirmaca
```
