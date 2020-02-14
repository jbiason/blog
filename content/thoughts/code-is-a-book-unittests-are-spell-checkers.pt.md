+++
title = "Código É um Livro, Testes Unitários São Corretores Ortográficos"
date = 2020-02-14

[taxonomies]
tags = ["testes", "testes de integração", "testes unitários"]
+++

Se nós usássemos uma analogia para código sendo as palavras de um livro e o
sistema sendo construído como o livro inteiro, o que seriam os testes
unitários?

<!-- more -->

Eu vi uma analogia excelente esses dias[^1]: Você pode pensar que o código que
você está escrevendo como um livro: Cada módulo é um capítulo, cada classe é
um parágrafo e cada função é uma frase.

Nessa analogia, onde é que os testes unitários ficariam?

Para mim, testes unitários são como corretores ortográficos -- ou, pelo menos,
os mais modernos: Você está escrevendo as palavras da forma correta? As suas
frases estão gramaticalmente corretas? O correto ortográfico vai cuidar disso.

Mas existe uma coisa que um corretor ortográfico não vai fazer: garantir que o
capítulo que você está escrevendo faz parte do contexto total do livro. Saindo
um pouco da analogia, deixe-me perguntar isso: Você já leu "Les Misérables"?
Eu li, e nele há um capítulo no meio do livro no qual Victor Hugo discute a
Batalha de Waterloo. Embora faça sentido no período histórico da história do
Les Misérables, o capítulo não faz o menor sentido para a história em si --
não importa o qual correta está a pontuação, as palavras estão certas e a
gramática correta.

Essa é a grande falha dos testes unitários: Eles não validam o todo. O todo é
dado pelos revisores de um livro e pelos testes de integração de um sistema.
Voltando a analogia, quando os testes de integração são definidos pelos
requisitos do sistema, qualquer coisa que não esteja coberto é um capítulo que
não faz sentido no conjunto do livro.

A longo prazo, como escritores começam a lembrar as palavras que foram
escritas erradas e os verbos no tempo errado apontados pelo correto
ortográfico, este começa a aparecer menos e menos, assim como testes
unitários: a longo prazo, o ROI[^2] tende a ser cada vez menor, enquanto
testes de integração -- aqueles que validam se um "capítulo" faz sentido na
história sendo contada no "livro" -- tende a ser maior.

E eu achei a analogia perfeita para a forma como eu penso sobre essas duas
metodologias de testes.

---

[^1]: ... mas infelizmente eu perdi a origem dela. :(

[^2]: "Return of Investment" ou "Retorno do Investimento".
