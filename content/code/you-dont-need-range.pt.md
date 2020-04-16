+++
title = "Você Não Precisa de range()"
date = 2020-04-16

[taxonomies]
tags = ["código", "python", "range"]
+++

Quem está começando com Python tende a usar `range()` quando precisa iterar
sobre listas. Mas isso não é realmente necessário.

<!-- more -->

Quando as pessoas começam a programar em Python, elas tendem a usar
construções vindas de outras linguagens, e por isso iteram sobre uma lista da
seguinte forma:

```python
a_list = [1, 2, 3, 4]
for i in range(len(a_list)):
    print(a_list[i])
```

Mas Python tem o conceito de "iteráveis", o que quer dizer que algumas coisas
podem ser iteradas diretamente, sem precisar acessar cada elemento
individualmente. Por exemplo, nossa lista anterior poderia ser iterada com:

```python
a_list = [1, 2, 3, 4]
for value in a_list:
    print(value)
```

"Para cada elemento em `a_list`, recupere-o e chame-o de `value`."

Vários elementos são iteráveis: Strings são iteráveis, retornando cada
caractere nelas; dicionários são iteráveis, retornado cada chave neles;
conjuntos são iteráveis, retornado cada elemento neles; tuplas são iteráveis,
retornando cada elemento nelas; generators são iteráveis, retornando o próximo
valor que eles conseguem produzir.

Mas e se precisássemos iterar sobre mais de um elemento ao mesmo tempo?

## Entra o `zip()`

É aí que o `zip()` entra. `zip()` permite que você junte dois iteráveis:

```python
a_list = [1, 2, 3, 4]
a_tuple = ('a', 'b', 'c', 'd')
for mixed_tuple in zip(a_list, a_tuple):
    print(mixed_tuple)
```

Esse código imprime:

```
(1, 'a')
(2, 'b')
(3, 'c')
(4, 'd')
```

O que o `zip()` faz é criar uma tupla com o primeiro elemento do primeiro
iterável e o primeiro elemento do segundo iterável; depois com o segundo
elemento do primeiro iterável e o segundo elemento do segundo iterável; e
assim por diante. Você pode colocar quantos iteráveis você quiser no `zip()` e
ele ira produzir tuplas maiores em cada iteração.

## Interlúdio: Destruturação

Uma das coisas legais de Python é "destruturação". Destruturação
(de-estruturar ou mais como "quebrar uma estrutura") permite que elementos de
um iterável sejam extraídos diretamente.

Por exemplo, se você tem uma tupla com dois elementos:

```python
a_tuple = (1, 2)
```

... você provavelmente iria extrair cada um dos elementos com alguma coisa do
tipo:


```python
a = a_tuple[0]
b = a_tuple[1]
```

Mas com destruturação, você pode fazer isso numa única passada com:

```python
(a, b) = a_tuple
```

Este código e o acima dele fazem exatamente a mesma coisa.

Mas porque destruturação é importante se estamos falando sobre iterar sobre
elementos? Porque `for` também tem a capacidade de destruturar:

```python
a_list = [1, 2, 3, 4]
a_tuple = ('b', 'c', 'd', 'f')
a_string = 'aeio'

for (a_number, lowercase_char, uppercase_char) in zip(a_list, a_tuple, a_string):
    print(a_number)
    print(lowercase_char)
    print(uppercase_char)
    print()
```

{% note() %}
Lembra que eu falei que strings também eram iteráveis e cada iteração traz um
caractere? É isso.
{% end %}

Mas o que acontece quando um dos iteráveis é menor que o outro?

```python
a_short_list = [1, 2]
a_long_list [10, 20, 30, 40, 50, 60, 70, 80, 90]
for (small, big) in zip(a_short_list, a_long_list):
    print(small, big)
```

Esse código imprime:

```
1 10
2 20
```
`zip()` pára quando o menor iterável não tem mais elementos. Para consumir
todos os elementos do iterável mais longo, você precisa de
`itertools.zip_longest()`.

## `itertools.zip_longest()`

`zip_longest()`, parte do módulo `itertools`, irá percorrer os iteráveis até
que nenhum deles tenha mais elementos. O que acontece com o menor deles é que
os seus valores são substituídos por `None`. Usando nosso exemplo anterior:

```python
import itertools

a_short_list = [1, 2]
a_long_list [10, 20, 30, 40, 50, 60, 70, 80, 90]
for (small, big) in itertools.zip_longest(a_short_list, a_long_list):
    print(small, big)
```

Isso irá imprimir:

```
1 10
2 20
None 30
None 40
None 50
None 60
None 70
None 80
None 90
```

## Cuidado com generators

Uma coisa que você precisa ter cuidado quando estiver usando `zip()` ou
`zip_longest()` são generators. Por que? Porque alguns deles não tem fim.

Vamos usar um exemplo: `cycle()`. `cycle()`, também parte do módulo itertools,
é um generator que, quando for pedido um valor, retorna o próximo valor de um
iterável mas, quando chegar ao fim deste, retorna pro começo. Por exemplo (e
eu estou usando `zip()` apenas para nos mantermos no tópico, mas não é preciso
usar `zip()` para usar `cycle()`):

```python
a_list = [10, 20, 30, 40, 50, 60, 70, 80, 90]
for (bullet, value) in zip(cycle(['-', '*', '.']), a_list):
    print(bullet, value)
```

Este código produz:

```
- 10
* 20
. 30
- 40
* 50
. 60
- 70
* 80
. 90
```

O que acontece é que `zip()` pegou o primeiro elemento do primeiro iterável,
nosso `cycle(['-', '*', '.'])`, que tem como primeiro valor no seu iterável
`'-'` e o segundo valor do segundo iterável, `10`; na próxima iteração, o
segundo valor de `cycle()` foi `'*'` e o segundo valor de `a_list` foi `20`;
na terceira iteração, `cycle()` retornou `'.'` e `a_list` `30`; agora, na
quarta iteração, foi pedido um valor ao `cycle()` e, como o seu iterável
terminou, ele retorno o primeiro valor, retornando `'-'` de novo.

Certo?

Então qual o problema com generators?

Alguns generators -- como o `cycle()` acima -- não tem fim. Se você trocar
`zip()` por `zip_longest()` no exemplo acima, você vai ver que o código não
irá terminar. Não são todos os generators que produzem valores de forma
infinita, e você pode usá-los sem problema.

{% note() %}
Não é só `zip_longest()` que tem problemas. Você pode botar dois `cycle()`s
num `zip()` e ele vai ficar gerando tuplas sem parar.
{% end %}

Certo, legal, mas e se eu precisar mostrar o índice também?

## `enumerate()` ao resgate!

Então, nós falamos sobre usar dois iteráveis ao mesmo tempo, mas e se
precisarmos da posição também? E se a nossa lista for uma lista de resultados
ordenados e nós precisamos mostrar a posição em si?

De novo, você pode ficar tentado a usar `range()`:

```python
winners = ['first place', 'second place', 'third place', 'fourth place']
for pos in range(len(winners)):
    print(pos + 1, winners[pos].capitalize())
```

Isso irá imprimir:

```
1 First place
2 Second place
3 Third place
4 Fourth place
```

Uma das coisas que você pode tentar ser esperto é tentar misturar o seu novo
conhecimento sobre `zip()` e fazer:

```python
winners = ['first place', 'second place', 'third place', 'fourth place']
for (pos, name) in zip(range(len(winners)), winners):
    print(pos + 1, name.capitalize())
```

... que, pessoalmente, parece mais complexo do que a primeira opção. Mas
Python tem outro generator chamado `enumerate()` que recebe um único iterável,
mas produz tuplas com o índice e seu valor:

```python
winners = ['first place', 'second place', 'third place', 'fourth place']
for (pos, name) in enumerate(winners):
    print(pos + 1, name.capitalize())
```

Melhor ainda, `enumerate()` tem uma opção para definir o valor inicial do
primeiro elemento, e ao invés de usar `pos + 1` no `print()`, nós podemos
mudar o enumerate para `enumerate(winners, start=1)` e remover a adição no
`print()`.

## Conclusão

Iteráveis são as grandes potências de Python, como você pode ter percebido com
a lista de coisas que podem ser iteradas. Entendendo-os vai lhe ajudar a
escrever código Python melhor e mais conciso, sem perda de significado.

<!-- 
vim:spelllang=pt:
-->
