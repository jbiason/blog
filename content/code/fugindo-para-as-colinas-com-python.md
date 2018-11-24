+++

title = "Fugindo Para as Colinas Com Python"
date = 2017-09-18

category = "code"

[taxonomies]
tags = ["python", "pt-br"]

+++

"Hello World" não mostra exatamente o poder de qualquer linguagem.
Por isso resolvi fazer uma "introdução" ao Python com um problema de
fujir para as colinas. Ou quase isso.

<!-- more -->

Um dos problemas de qualquer iniciante em qualquer linguagem é pegar o
"feeling" da linguagem. E, realcionado com isso, é o fato que a maior parte
dos códigos introdutórios de uma linguagem é o "hello world". Por exemplo:

```python
print('hello world')
```

O que isso diz de Python? No máximo que `print` precisa de parentêses,
strings podem ser geradas com aspas simples e não precisa de pronto-e-vírgula
no final.

O que não é muita coisa.

Uma coisa que eu sempre digito quando acontece algum problema é 

> Fujam para as colinas!

Só que repetir isso toda hora não me faz um cara muito popular. É por isso que
eu fico mudando essa frase para coisas do tipo

> Funam para as colijas!

Ou ainda

> Lunam para as jocifas!

Obviamente eu não paro para ficar pensando em todas as possibilidades e fico
alterando letras randomicamente manualmente. Eu tenho um script para isso. Um
script em Python.

## O Básico

```python
print('Fujam para as colinas!')
```

Assim já podemos irritar as pessoas repetindo a mesma informação.

O próximo passo é preparar o terreno para a randomicidade de frase.

```python
print('{}u{}am para as {}o{}i{}as!'.format('f', 'j', 'c', 'l', 'n'))
```

Agora já temos algumas coisas pra estudar.

### Help incluso e `format`

Primeiro, `format`. `format` é um método dos objetos do tipo string. Como
eu sei disso? Porque, um dia, estava eu muito belo e folgado, me perguntando
"O que as strings em Python podem fazer?", abri o interpretador do Python e
digitei:

> `help(str)`

E, lá no meio...

```
|  format(...)
|      S.format(*args, **kwargs) -> string
|
|      Return a formatted version of S, using substitutions from args and kwargs.
|      The substitutions are identified by braces ('{' and '}').
```

E uma das coisas legais do Python é que ele é capaz de buscar o tipo através
de um dado; e o que eu quero dizer com isso é que eu não precisaria saber que
o tipo de uma string é `str`, eu poderia simplesmente fazer `help('fujam
para as colinas')` e o interpretador mostraria o mesmo help.

Aqui temos mais uma informação importante: `*args` e `**kwargs`. O que são
esses dois desgraçados?

### Definindo Funções

Em outras linguagens esses são os chamados "variable arguments" ou "argumentos
variáveis" ou ainda "varargs". Ao invés de definir uma função que tenha um
número definido de parâmetros, *varargs* permite que a função tenha um número
indefinido de parâmetros. E eles funcionam da seguinte forma:

Vamos começar definindo uma função:

```python
def soma(primeiro, segundo):
  total = primeiro + segundo
  return total
```

Uma pequena pausa para falar de uma coisa que acabamos de ver de Python, que
não tínhamos visto ainda: definição de funções e blocos.

Primeiro, funções são definidas com `def`, seguidas do nome da função, um
parênteses, a lista de argumentos separados por vírgulas, fecha parênteses e
dois pontos. Em Python, os dois pontos indicam que haverá um início de bloco.

Segundo, ao contrário de outras linguagens, Python não usa colchetes para
definir os blocos. Isso é feito através da identação (e, obviamente, os dois
pontos).

Terceiro, Python é uma linguagem de tipagem dinâmica, o que significa que não
se define o tipo do parâmetro, simplesmente se usa.

{% note() %}
Em Python 3, é possível definir um "hint" para o tipo, da
seguinte forma:

```python
def soma(primeiro: Int, segundo: Int) -> Int:
   return primeiro + segundo
```

A única coisa a se cuidar é que isso é só um hint e que se for passado uma
string, não irá ocorrer qualquer erro.
{% end %}

### Chamando Funções

Ainda, existem duas formas de passar valores para uma função:

A primeira é só chamar a função passando os argumentos:

```python
soma(1, 2)
```

A segunda é que o Python aceita que sejam nomeados os argumentos:

```python
soma(primeiro=1, segundo=2)
```

O interessante de se nomear os argumentos é que é possível passar os mesmos
fora da ordem original da função:

```python
soma(segundo=2, primeiro=1)
```

(Essa parte de nomear os argumentos é importante para entender o `**kwargs`.)

### De volta a Varargs

Mas voltando aos *varargs*, o important é notar que a função acima tem dois
parâmetros. Se eu tentar chamar a função com um número diferente de
argumentos, o Python vai reclamar:

```python
>>> soma(1)
Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
TypeError: soma() takes exactly 2 arguments (1 given)
```

*varargs* remove essa limitação. Se eu mudar a função para:

```python
def soma(*args):
   print(args)
```

O que `*args` faz é pegar todos os argumentos e transformar numa lista. No
caso, se eu chamar:

```python
soma(1, 2, 3)
```

O resultado seria:

```python
[1, 2, 3]
```

E se eu chamar da forma original, com `soma(1, 2)`, eu tenho: [#fixo]_

```python
[1, 2]
```

{% note() %}
Também é possível criar funções com parâmetros fixos e uma parte
variável, com algo do tipo `def fun(param1, param2, *outros)`; se a
função for chamada com `fun(1, 2)`, `outros` ficará como uma lista
vazia (`[]`); se for passado `fun(1, 2, 3, 4)`, `outros` ficará com 3
e 4, já que 1 pertence à `param1` e 2 pertence à `param2`.
{% end %}

O que nós temos aqui é uma lista de elementos. Para fazer o `soma` funcionar
com uma lista ao invés de argumentos, teríamos que fazer o seguinte:

```python
def soma(*argumentos):
   total = 0
   for valor in argumentos:
      total = total + valor
   return total
```

De novo, coisas novas:

De novo, blocos são marcados com dois-pontos e uma identação. Assim, o bloco
do `for` tem uma linha só, porque o `return` está no mesmo nível do
`for`, ele só vai ser executado depois que o `for` terminar.

E aqui vemos como percorrer elementos de uma lista: `for/in` faz com que
seja percorrido cada elemento de `argumentos` e o valor será colocado em
`valor`.

Agora que vimos *varargs* e listas, existe uma coisa mágica do Python que o
`*`, além de servir para receber um número variável de argumentos e
transformar numa lista, também serve para fazer o contrário: converter uma
lista para uma lista de argumentos.

De novo, com o nosso `soma` original:

```python
def soma(primeiro, segundo):
   return primeiro + segundo
```

Eu posso chamar com:

```python
soma(1, 2)
```

Mas eu também posso chamar com:

```python
argumentos = [1, 2]
soma(*argumentos)
```

### Varargs de kwargs


Nós vimos duas coisas relacionadas a chamadas de função:

1. É possível criar funções com número variável de parâmetros, usando `*`.
2. É possível chamar funcões passando o nome do parâmetro.

O que acontece quando juntamos os dois?

```python
>>> def fun(*args):
...   print args

>>> fun(args=1)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: fun() got an unexpected keyword argument 'args'
```

O problema aqui é que `*` recolhe todos os argumentos sem nome. Para
recolher os com nomes, é preciso usar `**`. Ele funciona praticamente da
mesma forma que `*` mas ao invés de uma lista, ele irá conter um dicionário
-- também conhecido como "array associativo", "objeto", "mapa" e outros nomes,
dependendo da linguagem.

Por exemplo:

```python
def fun(**names):
    print names

fun(1)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: fun() takes exactly 0 arguments (1 given)
```

O problema aqui é que não foi passado nenhum argumento nomeado. Obviamente o
Python não sabe o que fazer com um valor qualquer e deu erro.

Agora, se a função for chamada com:

```python
fun(name='Julio', age=41)
{'age': 41, 'name': 'Julio'}
```

Ou seja, é possível criar uma função que só aceita parâmetro nomeados, mas é
preciso que os valores sejam buscados do dicionário ao invés de "aparecerem"
no bloco pelos parâmetros.

## Colocando tudo junto

Por que tudo isso é importante?

Porque, como foi visto no nosso primeiro código com o `format`, o que a
gente precisa é passar um número variável de elementos

```python
print('{}u{}am para as {}o{}i{}as!'.format('f', 'j', 'c', 'l', 'n'))
```

E nós precisamos alterar a ordem dos argumentos e a única forma que temos de
fazer isso é usando o *varargs* reverso:

```python
consoantes = ['f', 'j', 'c', 'l', 'n']
print('{}u{}am para as {}o{}i{}as!'.format(*consoantes)
```

Nesse momento, os dois códigos vão fazer a mesma coisa. A questão é que agora
temos uma lista que podemos mexer no conteúdo.

O que precisamos fazer agora: Embaralhar o conteúdo de `consoantes`. O resto
do código continua o mesmo, já que ele imprime as consoantes nos lugares
marcados e nós estamos passando a lista para isso.

Para randomizar o conteúdo, nós vamos utilizar uma das bibliotecas disponíveis
pelo próprio Python: `random`.

Para usar uma biblioteca -- que no Python são chamadas de "módulos" --, é só
fazer `import` e o nome da biblioteca. No nosso caso

```python
import random
```

Mas o que diabos tem dentro de `random`? Bom, dá pra ver tudo no site
oficial do Python, onde tem a documentação, ou nós podemos fazer o mesmo
`help(random)` para ver o help ou ainda usar `dir(random)` para ver o
conteúdo do módulo.

```
>>> import random
>>> dir(random)
['BPF', 'LOG4', 'NV_MAGICCONST', 'RECIP_BPF', 'Random', 'SG_MAGICCONST',
'SystemRandom', 'TWOPI', 'WichmannHill', '_BuiltinMethodType',
'_MethodType', '__all__', '__builtins__', '__doc__', '__file__',
'__name__', '__package__', '_acos', '_ceil', '_cos', '_e', '_exp',
'_hashlib', '_hexlify', '_inst', '_log', '_pi', '_random', '_sin', '_sqrt',
'_test', '_test_generator', '_urandom', '_warn', 'betavariate', 'choice',
'division', 'expovariate', 'gammavariate', 'gauss', 'getrandbits',
'getstate', 'jumpahead', 'lognormvariate', 'normalvariate',
'paretovariate', 'randint', 'random', 'randrange', 'sample', 'seed',
'setstate', 'shuffle', 'triangular', 'uniform', 'vonmisesvariate',
'weibullvariate']
```

No caso, o que nós queremos é o `shuffle` (como eu sei? Porque eu olhei a
documentação, oras!)

E assim nós temos o código:

```python
import random
consoantes = ['f', 'j', 'c', 'l', 'n']
random.shuffle(consoantes)
print('{}u{}am para as {}o{}i{}as!'.format(*consoantes)
```

E está feito nosso randomizador de Fugir para as Colinas.

Embora aqui tenhamos alcançado nosso objetivo, existem algumas outras
coisinhas que são interessantes de se ver.

## In-place

Uma das coisas que `random.shuffle` faz é alterar a ordem do conteúdo, não
retornando nada no resultado. Por exemplo

```python
>>> import random
>>> lista = [1, 2, 3, 4]
>>> random.shuffle(lista)
>>> print(lista)
[2, 4, 1, 3]
```

Isso não é um problema caso a lista não seja mais necessária depois do uso (ou
a ordem original não seja mais necessária). Se fosse necessária, seria preciso
fazer uma cópia da lista antes de usar o `shuffle`. Existe um módulo chamado
`copy` para fazer cópias tanto de listas quanto de dicionários.
Entretamento, para este caso, existe uma forma mais simples.

## Slices

Para acessar um elemento de uma lista, basta usar a posição do element
(começando em zero, obviamente).

```python
>>> lista = ['a', 'b', 'c', 'd']
>>> print(lista[1])
'b'
```

Também é possível acessar um grupo de elementos usando `:`, com a posição
inicial e a posição final (que é exclusiva, ou seja, antes de chegar no
elemento indicado).

```python
>>> lista = ['a', 'b', 'c', 'd']
>>> print(lista[1:3])
['b', 'c']
```

{% note() %}
Existe ainda um terceiro parâmetro para slides, que é o "step".
Por exemplo, 

```python
>>> lista = [1, 2, 3, 4]
>>> print(lista[::2])
[1, 3]
```

Aqui foi indicado que é pra ir do começo da lista até o final, mas pulando
de dois em dois.

Embora não muito usado, a parte que realmente importa é que step também
aceita valores negativos, indicando que é pra seguir na ordem inversa. E o
uso mais comum é criar uma cópia da lista, mas com os valores invertidos.

```python
>>> lista = [1, 2, 3, 4]
>>> print(lista[::-1])
[4, 3, 2, 1]
```
{% end %}

Também é possível omitir as posições: Se for omitida a primeira posição,
significa "desde o começo"; se for omitida a posição final, significa "até o
fim".

```python
>>> lista = ['a', 'b', 'c', 'd']
>>> print(lista[:3])
['a', 'b', 'c']
```

```python
>>> lista = ['a', 'b', 'c', 'd']
>>> print(lista[1:])
['b', 'c', 'd']
```

Também é possível usar índices negativos, tanto na posição inicial quanto
final, indica que é "a partir do fim da lista".

```python
>>> lista = ['a', 'b', 'c', 'd']
>>> print(lista[-2:])
['c', 'd']
```

Essas operações de "pegar pedaços de uma lista a partir de uma posição inicial
e final" são chamados de *slides*.

## Copiando listas por Slices

Mas porque eu comentei de slices? Porque, se você reparar, quando é utilizada
uma faixa, o Python retorna o resultado como uma lista. Na verdade, não é um
pedaço da lista original, é uma nova lista. 

Considerando que:

1. Sem uma posição inicial, significa que é pra começar do começo da lista.
2. Sem uma posição final, significa que é ir até o final da lista.
3. Slices são cópias de uma lista.

O que você acha que acontece se não forem passadas as *duas* posições ao mesmo
tempo?

Sim, você cria uma cópia da lista.

```python
>>> import random
>>> lista = [1, 2, 3, 4]
>>> copia = lista[:]
>>> random.shuffle(copia)
>>> print(copia)
[2, 4, 1, 3]
>>> print(lista)
[1, 2, 3, 4]
```

E, com essa cópia, evitamos de termos problemas com a lista passado pelo
`shuffle`, porque a lista original vai ter sempre os dados na mesma ordem, sem
nunca ser alterada -- desde que o `shuffle` seja feita na cópia.
