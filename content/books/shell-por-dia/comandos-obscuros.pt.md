+++
title = "Um Shell por Dia: Comandos Obscuros"
date = 2021-09-23

[taxonomies]
tags = ["book", "por dia", "shell", "comandos"]
+++

Existem alguns comandos que quase não são usados e por isso são pouco
comentados, mas se algum dia precisar, eles estão lá.

{% note() %}
Todos os comandos listados aqui são parte do "GNU CoreUtils" e
estão presentes na maior parte das distribuições Linux. Se você estiver usando
uma distribuição de BSD, possivelmente vai precisar instalar o pacote do
CoreUtils antes de poder usar.
{% end %}

Em nenhuma ordem em particular:

- `tac`: imprime o arquivo na ordem inversa, mostrando primeiro a última linha e
  indo até a primeira; é o inverso do `cat`.
- `head`: imprime as primeiras linhas de um arquivo; é o inverso do `tail` (e,
  infelizmente, não tem a opção `-f` para ver se surge alguma coisa no começo do
  arquivo).
- `nl`: imprime cada uma das linhas do arquivo, colocando o número da mesma na
  frente.
- `shuf`: embaralha o conteúdo de entrada; é o inverso do `sort`.
- `paste`: junta conteúdo do arquivo; é o inverso do `cut`.
- `expand`: Converte tabulações por espaços; é o inverso do `unexpand`.
- `unexpand`: Converte espaços por tabulações; é o unverso do `expand`.
- `shred`: apaga arquivos, mas antes de apagar, sobreescreve todo o conteúdo do
  mesmo no disco, para previnir que o mesmo não possa ser recuperado.
- `tee`: recebe o conteúdo e, ao mesmo tempo em que escreve o mesmo no "stdout",
  envia para um arquivo. Pode ser usado quando se queira salvar o conteúdo
  intermediário no meio de uma operação com pipes; por exemplo `cat | cut | tee
  temp | sort` fará com que o conteúdo do arquivo seja cortado, gravado no
  arquivo "temp" e passado ao `sort` ao mesmo tempo, podendo comparar o
  resultado antes e depois do sort.
- `cal`: mostra um calendário. Por padrão, mostra o mês atual, mas é possível
  usar, por exemplo `cal 2021` e ver o calendário do ano inteiro (infelizmente,
  só mostra o calendário, não é possível adicionar eventos).
- `nohup`: captura a execução de uma aplicação, permitindo que a mesma continue
  executando mesmo depois de perder o terminal. Explicando: Quando o terminal
  perde sua conexão (podendo ser porque o terminal foi encerrado, porque o
  emulador de terminal foi fechado ou porque a conexão foi encerrada), o sistema
  envia um sinal de "Hang UP" (HUP); o `nohup` captura este sinal e, como o
  processo executado é filho dele, ele pede para que o init/systemd assuma a
  paternidade do processo e deixe ele executando. Assim, caso você feche o
  terminal ou sua conexão ssh seja terminada, mesmo assim o comando vai
  continuar executando. Deve ser usado como `nohup comando`.
