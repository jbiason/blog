+++
title = "Devaneios Sobre Testes"
date = 2020-01-13

[taxonomies]
tags = ["testes", "testes de integração", "testes unitários", "companion post"]
+++

Hoje em dia, boa parte dos desenvolvedores utiliza alguma metodologia de
testes. Mas o que são os testes? Para que servem? Qual o objetivo de se
testar? Estamos testando as coisas certas?

<!-- more -->

{% note() %}
Esse post acompanha a minha apresentação de [Filosofando Sobre
Testes](https://presentations.juliobiason.me/filosofando-testes.html).
{% end %}

Antes de começar, alguns avisos:

1. **Eu sou não ortodoxo com relação a testes**. Com isso eu quero dizer que
   muitas das coisas que eu vou comentar aqui são exatamente contrárias do que
   todo mundo fala e da forma como muitos trabalham com testes.

2. De forma alguma, considere esse conteúdo como regras. O que eu quero é que
   as pessoas parem de sair criando testes sem saber porque estão fazendo
   esses testes.

3. Ainda, de forma alguma você precisa concordar com alguma coisa aqui. De
   novo, a ideia é parar para pensar no que está sendo testado antes de sair
   testando.

Agenda de coisas que eu vou comentar:

1. TDD no estilo Kent Beck;
2. "Fast Tests, Slow Tests";
3. Explosão de Testes Lentos;
4. Coverage;
5. Mocking.

## TDD no Estilo Kent Beck

O que me levou a repensar a forma como eu escrevia testes foi um vídeo do Ian
Cooper chamado ["TDD, where it all go wrong"](https://vimeo.com/68375232)
("TDD, aonde é que a coisa deu errado"). No vídeo, Cooper coloca que o livro que
Beck escreveu (que deu origem a toda a revolução do TDD) diz apenas duas
coisas:

1. Testes devem ser executados de forma isolada, nada mais, nada menos.
2. Evite testar detalhes de implementação, teste comportamentos.

O primeiro ponto é o que fala sobre "unit tests", significando "rodam de forma
isolada", no sentido em que um teste não depende de outro. Dessa forma, "unit
tests" seriam traduzidos como "testes unitários", não "testes de unidade" --
não há "unidade", o teste em si é uma unidade única que não depende de outras
coisas.

O segundo ponto é que deve ser testado o comportamento, não a implementação.
Esse é um ponto que eu vejo falhar um bocado quando pensamos em testar todo e
qualquer classe e/ou função: E se o comportamento esperado é a combinação de
duas classes? Vale a pena escrever testes para as duas, sendo que a questão de
separar em duas classes diferentes (ou duas funções diferentes) se referem ao
mesmo comportamento?

Ainda, outro questionamento sobre testar todas as funções e todas as classes:
o que sabemos de uma aplicação são os canais de entrada -- que pode ser por um
botão em uma interface gráfica, um texto digitado na linha de comando ou uma
requisição web -- e os canais de saída; assim, o _comportamento_ esperado é
"dado essa entrada pelo canal de entrada, quero ter essa saída", e qualquer
coisa no meio é implementação. De novo, para fazer a transformação de uma
entrada para uma saída específica, eu posso precisar de mais de uma função
e/ou classe; se eu estiver testando cada uma das funções, eu estou realmente
testando o comportamento ou a implementação?

"Mas isso é muito parecido com BDD!", você deve estar pensando. Cooper coloca
isso no vídeo acima: Como a ideia de "testar cada função/classe" se tornou a
norma do TDD, a questão do comportamento teve que ser colocado em outro
formato, o que deu origem ao ATDD (Acceptance-Test Driven Development,
Desenvolvimento Guiado por Testes de Aceitação) e BDD (Behaviour Driven
Development, Desenvolvimento Guiado por Comportamentos).

Um exemplo de como testar comportamento: No Subreddit do Django, foi criada
uma pergunta: [Devo Escrever Testes Para os Tipos Built-In do
Django?](https://www.reddit.com/r/django/comments/5bearg/should_i_write_unit_tests_for_djangos_built_in/) 
A questão se resume ao seguinte: Sabendo que no Django eu tenho tipos
definidos para meus dados no banco, e a partir dessas definições eu posso
criar formulários para colocar nos meus templates e esses formulários também
servem para validar os dados de entrada; assim, se eu defini que há um campo
no meu banco chamado "Ano de nascimento" -- que só pode receber números
inteiros -- e eu crio o formulário a partir do banco, coloco no meu template,
recebo os dados de volta e o próprio Django vai garantir, pelo tipo do dado no
banco, que o resultado é um número inteiro, eu ainda preciso escrever um
teste para isso?

A solução, no entanto, é dar um passo atrás e fazer a seguinte pergunta: _Por
que_ o ano é um inteiro? Obviamente, porque anos são definidos como números e,
portanto, o comportamento do campo foi definido bem antes do campo ser
adicionado na tabela. Ainda, imagine que, por algum acidente do destino, eu
precise guardar o ano como uma string[^1]; se o tipo foi alterado, o
_comportamento_ vai ser alterado também? Provavelmente não.

Quando eu ignorei que ano deve ser um número porque "o framework cuida disso
pra mim", eu ignorei o comportamento esperado por culpa da implementação.

De novo, "teste comportamentos, não implementação".

<!-- testes gerenciador de alertas -->

<!-- https://www.youtube.com/watch?v=RAxiiRPHS9k fast tests, slow tests -->
<!-- teste models, views, controllers ... soa similar? -->
<!-- "desenvolvedores podem testar suas alterações rapidamente" ... soa
familiar? -->
<!-- testes de aderência a arquitetura do projeto -->
<!-- qual o valor para o usuário desses testes? -->

<!-- testes lentos -->
<!-- "testes de integração são lentos" -->
<!-- suite de testes tem que dar a opção de testar apenas o comportamento
alterado -->

<!-- coverage -->
<!-- 100% de cobertura é possível, removendo código -->
<!-- testes de integração do gerenciador de alertas mostrou que tínhamos
código morto -->
<!-- exemplo validação nomes -->

<!-- mocks -->
<!-- "coisas externas" vs "coisas fora do nosso controle" -->

[^1]: O porque vai ser uma string pode ser variado: por causa de um plugin de
  segurança, porque é feito um armazenamento num banco que não trabalha bem
  com inteiros, por causa de uma integração com sistema legado...
