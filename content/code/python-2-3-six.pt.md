+++
title = "Python 2 + 3 = Six"
date = 2016-11-21

[taxonomies]
tags = ["python", "six", "python 2", "python 3", "tchelinux", "companion post"]
+++

"Six" é uma pequena biblioteca Python que pode ajudar você a passar o seu
código de Python 2 para Python 3.

<!-- more -->

{% note() %}
(Esse post é relacionado com a apresentação que eu fiz no dia 19 de novembro
no TchêLinux. Os slides podem ser encontrados 
[na área de apresentações](http://presentations.juliobiason.net/python23six.html).)
{% end %}


Antes de mais nada, uma coisa que precisamos responder é: Porque alguém usaria
Python 3?

* Todas as strings são unicode por padrão; isso resolve a pilha de problemas
  macabros, chatos, malditos, desgraçádos do `UnicodeDecodeError`;
* `Mock` é uma classe padrão do Python; ainda é possível instalar usando `pip` e
  a sintaxe é exatamente igual, mas é uma dependência a menos;
* `Enum` é uma classe padrão do Python; Enum é um dos abusos mais
  interessantes de classes em Python e realmente útil;
* AsyncIO e toda a parte de lazy-evaluation que o Python 3 trouxe; muita coisa
  no Python 3 deixou de ser "gerar uma lista" para ser um retorno de um
  iterador ou um generator; com AsyncIO, tem-se um passo a frente nessa idéia
  de geração lazy das coisas e, segundo pessoas mais inteligentes que eu, com
  PyUV, o Python consegue ser tão ou mais rápido que o Node;
* E, principalmente, **o suporte ao Python 2 termina em 2020!**

{% note() %}
Existe ainda a interpolação de strings com o novo identificador `f`; a
funcionalidade é semelhante à chamada `str.format` usando `locals()`, por
exemplo, `f'{element} {count}` é equivalmente à `'{element}
{count}'.format(locals())` (desde que você tenha `element` e `count` como
variáveis locais da sua função).
{% end %}

O último ponto é o mais importante. Você pode pensar "mas ainda tem três anos
até lá", mas natal está chegando, daqui a pouco é carnaval e, quando menos se
espera, é 2020.

## O caminho para Python 3

Quem quiser já começar a portar seus aplicativos para Python 3, existem duas
formas:

A primeira é executar seus aplicativos com `python -3 [script]`; isso irá fazer
com que o interpretador Python avise quando qualquer instrução de código que
ele não consiga converter corretamente seja alertado. Eu executei um script
pessoal [com data de 2003](https://bitbucket.org/juliobiason/pyttracker) e o 
Python não apresentou nada. 

{% note() %}
Apenas para fins de melhor elucidação: o código que eu estava gerando já estava
mais correto e seguindo os padrões mais pythônicos; em 2014 eu ainda estava
vendo casos em que código rodando em Python 2.6 ainda usava `has_keys()`, que
foi deprecado no Python 2.3.
{% end %}

Existem vários motivos pra isso:

1. As pessoas se acostumaram a escrever código "Pythonico"; a linguagem em si
   não sofreu grandes alterações.
2. Apesar da linguagem Python ter algumas coisas removidas, essas foram
   lentamente reintroduzidas na linguagem; um exemplo é o operador de
   interpolação de strings (`%`) que havia sido removido em favor do
   `str.format` mas acabou voltando.

A segunda forma para portar seu código para Python 3 é usar a ferramenta
`2to3`. Ela irá verificar as alterações conhecidas para Python 3 (por exemplo,
a transformação de `print` para função, a alteração de alguns pacotes da STL)
e ira apresentar um patch para ser aplicado depois.

Entre as conversões que o `2to3` irá fazer, está a troca de chamadas de
`iter`-alguma-coisa para a versão sem o prefixo (por exemplo,
`iteritems()` irá se tornar simplesmente `items()`); `print` será
convertido para função; serão feitos vários ajustes nas chamadas das
bibliotecas `urllib` e `urlparse` (estas duas foram agrupadas no Python 3
e a primeira teve várias reorganizações internas); `xrange` passa a ser
`range`; `raw_input` agora se chama `input` e tem um novo tratamento de
saída, entre outros.

Existe apenas um pequeno problema nessa conversão de Python 2 para Python 3:
Como pode ser visto na lista acima, alguns comandos existem nas duas versões,
mas com funcionalidades diferentes; por exemplo, `iteritems()` é convertido
para simplesmente `items()`, mas os dois métodos existem em Python 2: o
primeiro retorna um iterador e o segundo retorna uma nova lista com as tuplas
de todos os elementos do dicionário (no caso do Python 3, é retornado um
iterador). Assim, apesar do código ser gramaticalmente igual tanto em Python 2
quanto Python 3, semanticamente os dois são diferentes.

Esse problema de "comandos iguais com resultados diferentes" pode ser um
grande problema se o sistema está sendo executado em ambientes que não
permitem modificação fácil -- por exemplo, o mesmo é executando num Centos 4
ou ainda necessita compabilidade com Python 2.6, ambos "problemas" sendo, na
verdade, requisitos do grupo de infraestrutura.

## Six (e `__future__`) ao Resgate

Para resolver o problema de termos código que precisa executar nas duas
versões, existe a biblioteca [Six](https://pythonhosted.org/six/); ela faz o
"meio de campo" entre Python 2 e Python 3 e fornece uma interface para que
código Python 2 seja portado para Python 3 mantendo a compatibilidade.

Num exemplo (relativamente idiota):

```python
import collections

class Model(object):
    def __init__(self, word):
        self._count = None
        self.word = word
        return

    @property
    def word(self):
        return self._word

    @word.setter
    def word(self, word):
        self._word = word
        self._count = collections.Counter(word)

    @property
    def letters(self):
        return self._count

    def __getitem__(self, pos):
        return self._count[pos]

if __name__ == "__main__":
    word = Model('This is an ex-parrot')
    for letter, count in word.letters.iteritems():
        print letter, count
```

Nesse exemplo, temos uma classe que guarda uma frase e a quantidade de vezes
que cada letra aparece, utilizando `Counter` para fazer isso (já que `Counter`
conta a quantidade de vezes que um elemento aparece em um iterável e strings
*são* iteráveis).

Nesse exemplo, temos os seguintes problemas:

1. `class Model(object)`: em Python 3, todas as classes são "new class" e o
   uso do `object` não é mais necessário (mas não afeta o funcionamento da
   classe);

2. `for letter, count in word.letter.iteritems()` Conforme discutido
   anteriormente, `iteritems()` deixou de existir e passou a ser `items()`;
   `items()` existe no Python 2, mas a funcionalidade é diferente. No nosso
   caso aqui, o resultado da operação continua sendo o mesmo, mas o consumo de
   memória irá subir cada vez que a chamada for feita.

3. `print leter, count`: `print` agora é uma função e funciona levemente
   diferente da versão com Python 2.

Então, para deixar esse código compatível com Python 2 e Python 3 ao mesmo
tempo, temos que fazer o seguinte:

> `class Model(object)`

Não é preciso fazer nada.

> `print letter, count`

```python
from __future__ import print_function
print('{} {}'.format(letter, count))
```

`print` como função pode ser "trazido do futuro" usando o módulo
`__future__` (apenas disponível para Python 2.7); como a apresentação de
várias variáveis não é recomenando usando-se vírgulas, usar o
`str.format` é a forma recomendada.

Uma opção melhor (na minha opinião) é:

```python
from __future__ import print_function
print('{letter} {count}'.format(letter=letter
                                count=count))
```

Assim, os parâmetros usados na saída são nomeados e podem ser alterados.
Isto gera um erro estranho quando um nome usado na string de formato não
for passada na lista de parâmetros do format, mas em strings mais
complexas, o resultado é mais fácil de ser entendido (por exemplo, eu acho
mais fácil entender `{letters} aparece {count} vezes` do que `{} aparece {}
vezes`; ainda, é possível mudar a ordem das variáveis na string de formato
sem precisar alterar a ordem na lista de parâmetros).

Uma opção melhor ainda é:

```python
import six
six.print_('{letter} {count}'.format(letter=letter,
                                     count=count))
```

Com Six, remove-se a dependência com `__future__` e assim pode-se usar o
mesmo código em Python 2.6.

> `for letter, count in word.letters.iteritems():`
 
```python
import six
for letter, count in six.iteritems(word.letters):
```

Six provê uma interface unificada para iterador de itens tanto em Python 2
quanto Python 3: `six.iteritems()` irá chamada `iteritems()` se estiver
rodando em Python e `items()` se estiver rodando com Python 3.

E, assim, nosso código relativamente idiota agora é compatível com Python 2 e
Python 3 roda de forma idêntica nos dois.

Mas vamos para um exemplo real:

```python
import urllib
import urlparse

def add_querystring(url, querystring, value):
	 frags = list(urlparse.urlsplit(url))
	 query = frags[3]
	 query_frags = urlparse.parse_qsl(query)
	 query_frags.append((querystring, value))
	 frags[3] = urllib.urlencode(query_frags)
	 return urlparse.urlunsplit(frags)

if __name__ == "__main__":
	 print add_querystring('http://python.org', 'doc', 'urllib')
	 print add_querystring('http://python.org?doc=urllib', 
								  'page', '2')
```

{% note() %}
Sim, sim, o código poderia ser um simples "verificar se tem uma interrogação na
URL; se tiver, adicionar `&` e a query string; se não tiver, adicionar `?` e a
query string". A questão é: dessa forma, eu consigo fazer uma solução que vai
aceitar qualquer URL, em qualquer formato, com qualquer coisa no meio porque as
bibliotecas do STL do Python vão me garantir que a mesma vai ser parseada
corretamente.
{% end %}

Esse é um código de uma função utilizada para adicionar uma query string em
uma URL. O problema com essa função é que tanto `urlib`
quanto `urlparse` sofreram grandes modificações, ficando, inclusive, sob o
mesmo módulo (agora é tudo `urllib.parse`).

Para fazer esse código ficar compatível com Python 2 e 3 ao mesmo tempo, é
preciso usar o módulo `six.moves`, que contém todas essas mudanças de escopo
das bibliotecas da STL (incluindo, nesse caso, a `urllib` e `urlparse`).

```python
import six

def add_querystring(url, querystring, value):
	 frags = list(six.moves.urllib.parse.urlsplit(url))
	 query = frags[3]
	 query_frags = six.moves.urllib.parse.parse_qsl(query)
	 query_frags.append((querystring, value))
	 frags[3] = six.moves.urllib.parse.urlencode(query_frags)
	 return six.moves.urllib.parse.urlunsplit(frags)

if __name__ == "__main__":
	 six.print_(add_querystring('http://python.org', 'doc', 'urllib'))
	 six.print_(add_querystring('http://python.org?doc=urllib', 
										 'page', '2'))
```

O que foi feito, aqui, foi usar `six.moves.urllib.parse`. Essa estrutura não
vêm por acaso: no Python 3, as funções de `urlparse` agora se encontram em
`urllib.parse`; Six assumiu que a localização correta para as funções dentro
"de si mesma" seriam os pacotes utilizados no Python 3. 

E, assim, temos dois exemplos de programas que conseguem rodar de forma igual
tanto em Python 3 quanto Python 2.

Ainda, fica a dica: Se houver algum software que você utiliza que não roda
corretamente com Python 3, utilizar o Six pode ajudar a manter o código atual
até que uma escrita resolva o problema.

## Outras Perguntas

### Como fica a questão de ficar sempre com o Six?

Boa parte das aplicações hoje botaram uma "quebra" do suporte às suas versões
que rodam em Python 2. Por exemplo, Django anunciou que em 2020 vai sair a
versão 2.0 do framework e essa versão vai suportar Python 3 apenas.

## Quão difícil é portar para Python 3?

Não muito difícil -- agora. Muitas das coisas que foram removidas que davam dor
de cabeça na conversão retornaram; o caso mais clássico é o que operador de
interpolação de strings `%`, que foi removido e teria que ser substituído por
`str.format`, mas acabou retornando. Outro motivo é que os scripts são mais
"pythônicos" atualmente, muito por causa de gente como [Raymond
Hettinger](https://rhettinger.wordpress.com/), que tem feito vídeos excelentes
de como escrever código em Python com Python (ou seja, código "pythônico"). E,
como anedota pessoal, eu posso comentar que meu código de 2003 rodou com
`python -3` sem levantar nenhum warning.
