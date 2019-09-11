+++
title = "Porque Você Deve Aprender Rust"
date = 2019-09-10

[taxonomies]
tags = ["pt-br", "rust", "companion post"]
+++

Rust é uma nova linguagem de programação que eu acredito que deveria ser vista
por desenvolvedores, mesmo que eles não venham programar em Rust.

<!-- more -->

{% note() %}
Esse post acompanha a minha apresentação [Porque Você Deve Aprender
Rust](https://presentations.juliobiason.net/porque-rust.html#/).
{% end %}

Quando eu comecei a apresentação, eu pensei em chamar a mesma de "Porque Você
Deveria Aprender Rust"; mas eu pensei bem sobre isso e como a linguagem tem
vários conceitos interessantes, eu acho que o título correto deve ser "Porque
Você DEVE Aprender Rust".

Mas antes de começar a falar sobre Rust, é interessante que vocês conheçam
quem está falando sobre aprender Rust:

Eu comecei a programar a mais de 30 anos. Em todos esses anos, eu já programei
em Basic (usando número de linhas e Basic estruturado, também conhecido como
QBasic), dBase III Plus, Clipper (que foi a primeira linguagem que eu usei
profissionalmente), Pascal, Cobol (sim, Cobol, façam suas brincadeiras agora),
Delphi (cujo nome científico é "ObjectPascal" e possui algumas diferenças para
o Pascal original), C, C++, ActionScript (que é a linguagem para geração de
applets Flash sem usar o editor da Adobe), PHP (quem nunca?), JavaScript (quem
nunca?), Python, Objective-C, Clojure, Java, Scala (que eu não desejo que nem
meu pior inimigo tenha que programar nela) e Rust. E essas são as linguagens
que eu já escrevi código e que rodou. Fora essas, eu ainda conheço Haskell,
Perl e Swift, mas nessas eu não programei nada ainda.

Mas por que eu comentei sobre isso? Porque o que eu vou comentar aqui é,
basicamente, _minha opinião_, depois de conhecer essas linguagens todas.
Então, obviamente, existe um _viés_ para os motivos que eu vou citar daqui pra
frente.

Mas existe uma frase do Alan Perlis, criador do ALGOL, que diz "A language
that doesn't affect the way you think about programming, is not worth knowing"
(uma linguagem que não afeta o modo que você pensa sobre programação, não vale
a pena ser aprendida). E mesmo depois de todas essas linguagens citadas acima,
Rust ainda me fez repensar coisas que eu sempre pensei quando estava
programando.

## A Parte Burocrática

Antes de sair falando da linguagem, eu tenho que falar sobre a parte
burocrática da linguagem. Coisas como, por exemplo:

* Rust foi criada em 2006 por Graydon Hoare.
* Rust começou a ser patrocinada em 2009 pela Mozilla Foundation.
* A versão 1.0 saiu em 2015.
* A versão atual é a 1.37.

Rust tem uma história engraçada: Hoare começou a desenvolver a linguagem de
forma independente, em seu tempo livre. Quando ele começou a pegar gosto pela
coisa, ele veio falar com seu gerente dizendo que iria deixar a Mozilla
Foundation para poder trabalhar na sua linguagem de programação. "Que
linguagem é essa?", perguntou o gerente; Hoare afirmou que era uma linguagem
com foco em proteção de memória mas que ainda fosse uma linguagem rápida. Ao
ouvir isso, o gerente pediu para Hoare segurar o pedido de demissão e
conversou com seus superiores. E, por ter vários problemas com a estrutura em
C++ do Firefox, a Mozilla resolveu patrocinar Hoare para que ele pudesse
trabalhar na linguagem.

{% note() %}
Eu gosto de brincar, dizendo que o Hoare chegou pro gerente dele dizendo que
iria deixar a Mozilla pra trabalhar na sua linguagem e o gerente, depois de
pedir pra ele esperar um pouco, chegou dizendo que só conseguiu 2 estagiários.

A verdade é que Hoare realmente quis deixar a Mozilla Foundation, mas ao
explicar os motivos -- trabalhar na sua própria linguagem, cuja principal
diferença seria a proteção de memória e velocidade -- a Mozilla se interessou
pela mesma, por causa dos problemas que eles estavam encontrando ao trabalhar
com C++. Por isso a Mozilla continuou pagando Hoare para que ele trabalhasse
na sua linguagem.
{% end %}

Uma coisa a cuidar: Aqui eu comento que a versão atual é a 1.37. Isso pode não
ser verdade no momento que você lê esse post (ou viu a apresentação) porque a
cada 6 semanas uma nova versão do Rust é liberada. Essas versões trazem
correções de bugs e novas features.

{% note() %}
Uma outra anedota é que o primeiro projeto em Rust foi um browser --
normalmente a gente pensa que para primeiro projeto, as linguagens querem algo
mais simples, como um microserviço ou algo parecido, mas a equipe do Rust
partiu direto para um browser.

O resultado, chamado [Servo](https://servo.org/), hoje faz parte do [Firefox
Quantum](https://www.mozilla.org/en-US/firefox/?gclsrc=aw.ds), o que diminui o
uso de memória e diminuiu o número de "crashes" da aplicação.

Ainda, num certo ponto, um desenvolvedor do Chrome resolveu fazer alguns
testes, utilizando SVG animados, colocando 1 elemento animado 300 vezes numa
página. Para animar todos os elementos, o Chrome conseguia manter 30 FPS;
Firefox, 20; Servo, 300 (sim, 10 vezes mais que o Chrome!).

Outro exemplo de Rust no Firefox é um bug que estava em aberto por 8 anos. O
bug em questão, [631527](https://bugzilla.mozilla.org/show_bug.cgi?id=631527)
-- que, na verdade, é uma feature -- seria permitir que dois elementos possam
ter os estilos definidos no CSS aplicados em mais de um elemento ao mesmo
tempo; o browser lê primeiro o HTML, constrói o DOM e depois sai aplicando o
estilo em cada um dos elementos; com dois elementos um depois do outro, seria,
teoricamente, possível aplicar o estilo no primeiro ao mesmo tempo em que
aplica no segundo. O bug ficou aberto por 8 anos e duas re-escritas foram
feitas pra tentar resolver o problema. Nenhuma conseguiu prover um resultado
funcional, por vários motivos, mas principalmente por causa da forma com a
memória era compartilhada nas threads em C++. Quando o Firefox mudou para o
Quantum (de novo, em Rust, usando a base do Servo), a correção foi (conforme
descrito por Niko Matsakis na abertura do Rust Latam 2019) "trivial".
{% end %}

## Motivo 1

Em 2019, O [StackOverflow](https://stackoverflow.com/) fez uma enquete com os
visitantes, perguntando, entre várias outras perguntas, qual linguagem eles
usavam e se eles gostavam de programar nessa linguagem. No resultado dessa
enquente, [Rust aparece como a linguagem mais
amada](https://insights.stackoverflow.com/survey/2019#technology-_-most-loved-dreaded-and-wanted-languages)...
pelo 4o ano seguido.

"Ah, mais isso é fácil! Os quatro caras que programam em Rust dizem que gostam
dela todo ano!", você deve estar dizendo. Na verdade, o percentual tem subido
desde a primeira vez, saindo de 76% em 2016 e indo a 83% em 2019.

## Motivo 2: "Uma Linguagem de Baixo Nível Com Abstrações de Alto Nível"

Quando comparado com C, Rust tem uma performance bem semelhante:

![Comparativo de algumas linguagens com relação à utilização de CPU, Energia e
Memória](rust-energy.png)

O gráfico acima foi tirado de uma pesquisa que foi feita para verificar [qual
linguagem gasta mais
energia](https://jaxenter.com/energy-efficient-programming-languages-137264.html). 

Na implementação utilizada, C foi a linguagem cujo código gerado usou menos
energia; em segundo, com uma utilização apenas 3% maior, Rust.

Ainda, em tempo de execução, a aplicação gerada em C também é a mais rápida e
Rust fica em segundo com um tempo de execução apenas 4% maior.

No quesito utilização de memória é que vemos algo engraçado: A linguagem que
melhor utiliza memória é Pascal, C utiliza 17% mais memória e Rust 54% a mais.
A explicação para isso pode ser pela forma como Rust trata memória,
principalmente de código, mas eu vou explicar isso melhor mais pra frente.

E, apesar disso tudo, Rust tem implementações de:

* Strings com tamanho crescente;
* Listas dinâmicas;
* Mapas.

E considerando todo o tempo que eu passei programando em várias linguagens, se
amanhã surgisse uma linguagem que conseguisse ter uma performance melhor que
C, mas que eu tivesse que implementar minha própria lista encadeada, eu
acredito que botaria fogo em tudo e iria plantar batatas, porque,
honestamente, significa que nós não aprendemos nada sobre linguagens de
programação.

# Motivo 3: Compilador É Chato, Mas Amigável

Deixem-me mostrar um código Rust:

```rust
fn main() {
    let a = 2;
    a = 3;
    println!("{}", a);
}
```

Aqui temos nosso primeiro contato com a sintaxe de Rust: `fn` define funções;
assim como C, `main` é a função que indica onde a execução começa; `let` deixa
definir variáveis e, apesar de não mostrar nesse trecho, as variáveis são
fortemente tipadas, mas eu não precisei colocar o tipo porque o compilador
consegue inferir o tipo sozinho; linhas terminam com `;`; `println!` tem uma
exclamação porque essa função é uma macro e a exclamação é colocada para
diferenciar de funções normais (no caso, o `println!` vai ser expandido pelo
compilador por um conjunto maior de comandos).

E esse código Rust não compila.

Se vocês tentarem compilar esse código, vocês verão a seguinte mensagem de
erro:

```
3 |     let a = 2;
  |         -
  |         |
  |         first assignment to `a`
  |         help: make this binding mutable: `mut a`
4 |     a = 3;
  |     ^^^^^ cannot assign twice to immutable variable
```

O que acontece é que, em Rust, alem das variáveis serem fortemente tipadas,
elas também são, por padrão, imutáveis. Ou seja, não é possível, por padrão,
alterar o valor de uma variável.

Mas prestem atenção na mensagem de erro:

```
4 |     a = 3;
  |     ^^^^^ cannot assign twice to immutable variable
```

O compilador não apenas disse qual era o erro -- "não é possível atribuir um
valor duas vezes para uma variável imutável" (indicando, ainda qual a linha)
como também passou uma dica de como corrigir esse problema:

```
  |         help: make this binding mutable: `mut a`
```

{% note() %}
Essa parte da mensagem de erro é importante para o time de desenvolvimento do
Rust.

Na Rust Latam, Esteban Kuber fez uma apresentação chamada "Friendly Ferris:
Developing Kind Compiler Errors" ("Ferris Amigável: Desenvolvendo Erros
Amigáveis do Compilador", onde "Ferris" é o nome do mascote da linguagem),
onde ele conta que foi brincar com Rust pela primeira vez e recebeu um erro do
compilador sobre o código que ele tinha escrito, mas não conseguiu entender
exatamente qual era o problema.

Aqui fica a pergunta pra vocês: Se vocês encontrassem um erro que não
entendessem o que vocês fariam? Boa parte provavelmente diria que iria
perguntar ao Google.

Esteban, no entanto, resolveu abrir um issue no Github da linguagem, para ver
o que iria acontecer. A resposta? "Você tem razão, a mensagem do erro é
difícil de entender, e isso é um bug do compilador. Nós vamos arrumar."
Esteban se ofereceu pra tentar encontrar o problema, recebeu uma tutoria de
como compiladores funcionam e hoje é um dos expoentes nas questões de
mensagens de erro do compilador.
{% end %}

# Motivo 4: O Borrow Checker
