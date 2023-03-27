+++
title = "Pyngos de Python I"
date = 2023-03-27

[taxonomies]
tags = ["python", "generators"]
+++

"Pyngos de Python" são pequenas explicações de Python.

Nesse post, vamos falor sobre generators.

<!-- more -->

Vamos começar falando sobre list comprehensions, que são bem comuns em Python.
De forma gera, um list comprehension é definido como

```python
[transformação
 for variável
 in iterável
 if condição]
```

* `iterável` é o container com os elementos que queremos percorrer;
* `variável` define qual vai ser o nome da variável que vamos lidar cada um dos
  elementos do `iterável`;
* `transformação` é qualquer transformação que queremos fazer sobre `variável`;
* `condição` é um opcional caso queiremos processar apenas alguns elementos.

Um exemplo de list comprehension em ação:

```python
lista = [1, 2, 3, 4]
lc = [i * 2 for i in lista]
print(lc)   # [2, 4, 6, 8]
```

Embora útil, existe um problema: List comprehensions geram uma lista com, no
máximo, o mesmo tamanho do iterável original; se você tiver um array de 500.000
elementos, um list comprehension que não tenha uma condição vai gerar outro
array com 500.000 elementos.

E, em alguns casos, isso não é necessário.

Antes de ver onde generators podem ser usados, veremos a sintaxe de um:

```python
(transformação
 for variável
 in iterável
 if condição)
```

Como pode ser visto, a sintaxe é bem semelhante; a diferença é que
comprehensions usam `[]`, enquanto generators usam `()`.

E como exemplo:

```python
lista = [1, 2, 3, 4]
gen = (i * 2 for i in lista)
print(gen)   # <generator object <genexpr> at 0x7f7f30843df0>
```

O que diabos é esse `generator object`?

Generators não geram os dados todos numa passada; os dados somente são
processados quando pedidos. A forma de pedir o próximo elemento é usando a
função `next`; quando o generator encontra o final do iterável, ele levanta a
exceção `StopIteration`:

```python
lista = [1, 2, 3, 4]
gen = (i * 2 for i in lista)
print(next(gen))    # 2
print(next(gen))    # 4
print(next(gen))    # 6
print(next(gen))    # 8
print(next(gen))    # Exceção: StopIteration
```

Curiosamente, `for` sabe lidar com `StopIteration` e `next()`, o que torna
possível usar um generator diretamente no `for`:

```python
lista = [1, 2, 3, 4]
for i in (i * 2 for i in l):
    print(i)    # 2, 4, 6, 8
# Nenhuma exceção aqui.
```

Mas é a vantagem de usar generators?

A primeira vantagem pode ser vista no `for` acima: Imagine que `lista` tem
500.000 elementos. Usar list comprehensions não mudaria nada no código (com a
exceção de usar `[]` ao invés de `()`), mas estamos gerando a multiplicação
somente quando necessário. Agora imagine que estamos procurando algo na lista
original e vamos parar assim que encontrarmos o registro: com list
comprehension, a nova lista será sempre gerada, e se o o elemento procurado for
o primeiro, acabamos gerando 499.999 elementos que não vamos usar. Com
generators, no momento que encerramos a procura, nada mais é gerado -- e
somente o elemento procurado é gerado.

Um exemplo mais real: Arquivos são iteráveis, onde cada requisição é uma linha
do arquivo. Se o arquivo sendo processado é um CSV, podemos fazer um generator
que separa os campos sobre a iteração do arquivo enquanto procuramos um
registro específico:

```python
with open('arquivo.csv') as origem:
   for registro in (linha.split(',') for linha in origem):
      if registro[1] == 'entrada':
         return registro[2]
```

Neste código, estamos procurando a linha do CSV cujo 2o elemento (listas
começam em 0) tem o valor "entrada"; quando encontrarmos, retornamos o valor da
coluna seguinte. A medida que o `for` for pedindo valores, o generator é
chamado; o generator que criamos quebra a linha usando "," como separador; como
o generator usa o iterável do arquivo (que, por baixo dos panos, também é um
generator), somente quando for pedido um registro é que uma linha será lida;
somente quando a linha vier é que vai ser feito o split. E se, por algum
motivo, o registro procurando for o primeiro, foi somente lida uma linha do
arquivo[^1] e feito o split somente uma vez.

## BÔNUS: Generator Functions!

Existe uma forma de criar uma função que age como um generator, usando o
statement `yield`, da mesma forma que se usaria o statement `return`. A
diferença é que quando o Python encontra `yield`, ao invés de destruir tudo que
estava na função, ele guarda a posição atual e, na chamada do `next()`,
continua naquela posição.

Por exemplo, se tivermos:

```python
def double(lista):
   for i in lista:
      return i * 2

double([1, 2, 3, 4])
```

Irá retornar apenas `2` porque, ao ver o `return`, o Python vai destruir tudo
que a função já fez e retornar o valor indicado -- incluindo encerrar o `for`
antes de chegar no final.

Com generator functions, teríamos:

```python
def double(lista):
   for i in lista:
      return i


gen = double([1, 2, 3, 4])
next(gen)   # 2
next(gen)   # 4
next(gen)   # 6
next(gen)   # 8
next(gen)   # StopIteration
```

Note que a chamada para a função é que retorna um generator. Tentar fazer

```python
def double(lista):
   for i in lista:
      return i


next(double([1, 2, 3, 4]))   # 2
next(double([1, 2, 3, 4]))   # 2
next(double([1, 2, 3, 4]))   # 2
next(double([1, 2, 3, 4]))   # 2
...
```

... vai gerar um novo generator a cada chamada.

Ainda, é possível que a função tenha mais de um `yield`:

```python
def double(lista):
   yield lista[0] * 2
   yield lista[1] * 2
   yield lista[2] * 2

gen = double([4, 3, 2, 1])
next(gen)   # 8
next(gen)   # 6
next(gen)   # 4
next(gen)   # StopIteration
```

Aqui, a primeira chamada de `next()` vai retornar o valor do primeiro `yield`,
que é o primeiro elemento da lista multiplicado por 2; o próximo `next()` vai
executar o comando logo depois do primeiro `yield`, que é o segundo `yield`; e
a terceira chamada vai continuar a execução logo depois desse, que é o terceiro
`yield`. Como o código termina aí, o generator vai levantar a exceção
`StopIteration`.

Mas o que aconteceria se... a função nunca retornasse nada?

```python
def gen():
   i = 0
   while True:
      yield i * 2
      i += 1
```

Neste caso, usando `next()` no generator, a primeira vez será retornado "0"; o
`next()` seguinte irá continuar o código, somando "1" ao nosso contador,
retornando para o começo do loop e retornando "2"; e assim sucessivamente até o
fim do mundo (ou até ser pressionado Ctrl+C, desligado o computador ou atingido
o número máximo permitido para inteiros em Python).

---

[^1]: Tecnicamente, vai ser lido mais, porque o Python usa "buffers" de
    leitura, carregando blocos e depois enviando apenas os bytes desde a última
    posição lida até o caracter de nova linha. Mas, para simplificar as coisas,
    imaginem que apenas uma linha é lida mesmo.
