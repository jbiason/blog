+++
title = "Um Shell por Dia: Shells"
date = 2021-09-16

[taxonomies]
tags = ["books", "por dia", "shell"]
+++

Mais uma interrupção entes de continuarmos vendo coisas de shell. Por que?
Porque dependendo do shell que você está usando, as coisas podem mudar daqui pra
frente. Até o presente momento, o que vimos de redecionamento e pipes funciona
igual em todos.

- "sh": "sh" é o Shell que deu origem e todos os demais. Ele é básico mais faz o
  serviço;
- "Bash": Bash é o shell mais usado por aí, principalmente porque é o padrão nas
  distribuições no Linux. Além do básico que o "sh" consegue fazer, Bash tem
  opções de cálculos matemáticos sem precisar usar uma aplicação externa e
  testes mais sofisticados (que é importante para quando começarmos a ver como
  criar scripts);
- "Zsh": Zsh tem algumas (poucas) diferenças no Bash, mas extende um bocado a
  parte de auto-complete;
- "Csh": Csh é um dos shells que basicamente morreu por falta de uso, mas ele
  permite que sejam escritos scripts usando um subset de C;
- "Tcsh": Tcsh é bem pareciso com o Csh, mas permite que scripts sejam escritos
  em um subset de TCL;
- "Nushell": Nushell é um novo shell na área, que resolveu tratar todos os
  resultados como Dataframes e pode ser usado para análise simples de dados.

E, por últmo, se você estiver pensando em trocar o shell de forma permanente, é
possível usar o comando `chsh` (change shell). A sintaxe é `chsh -s <caminho
para o shell que você quer> <username>`.
