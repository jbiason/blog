+++
title = "Um Shell por Dia: Sub comandos"
date = 2021-09-21

[taxonomies]
tags = ["books", "por dia", "shell", "subcomandos"]
+++

Algumas vezes queremos que parte do comando que será executado seja calculado
automaticamente e, para isso, temos sub comandos.

Por exemplo, digamos que você queria executar um comando e mandar para um
arquivo com a data atual. Existe um comando pronto para mostrar a data atual,
`date`, que permite que o formato de saída seja definido como, por exemplo,
`date +"%Y%m%d"`, que gera algo como "20210921".

Apenas para lembrar, você pode querer fazer

```
comando > 20210921.txt
```

E amanhã fazer

```
comando > 20210922.txt
```

Só que isso significa que não é possível automatizar isso. Quer dizer, não
*daria*, se não fossem os subcomandos. E para usar subcomandos, são usadas
crases (ou, no original, "back-ticks"). No nosso exemplo

```
comando > `date +"%Y%m%d"`
```

E, assim, podemos automatizar a geração e não se preocupar em ver o dia correto
todo dia.

Mas um aviso: não são todos os shells que suportam esse formato. Fish, por
exemplo, requer que os subcomandos sejam executando entre parênteses (`comando >
(date +"%Y%m%d")`) e Bash suporta o formato de `$(subcomando)`. Portanto, cuide
qual o shell está sendo executado antes de sair usando os ticks.
