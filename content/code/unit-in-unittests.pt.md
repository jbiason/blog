+++
title = "O \"Unit\" de \"Unit Tests\""
date = 2016-11-23

[taxonomies]
tags = ["unit", "unit tests", "tests", "kent beck", "tchelinux", "companion post"]
+++

Existem vários artigos sobre os "testes de unidade" e alguns até
falando de "a unidade dos testes"; todos estes estão errados e é
preciso parar de falar dessa forma.

<!-- more -->

{% note() %}
(Este post é relacionado com a apresentação que eu fiz no dia 19 de
novembro no TchêLinux. Os slides podem ser encontrados [na área de
apresentações](http://presentations.juliobiason.net/unit-in-unittest.html#).
{% end %}


Boa parte do conteúdo que eu vou comentar aqui é relacionado com o vídeo de Ian
Cooper [TDD, where did it all go wrong](https://vimeo.com/68375232). Quando eu
vi o vídeo, imediatamente eu comecei a relacionar os comentários dele sobre
TDD, na versão original de Kent Beck (o author do livro [Test Driven
Development By Example](https://www.goodreads.com/book/show/387190.Test_Driven_Development?from_search=true),
que foi o responsável por "reativar" a discussão sobre testes) com uma
experiência pessoal trabalhando com TDD no mundo embedded.

Antes que eu entre na discussão sobre o que é TDD de verdade, o que Kent Beck
quis dizer com o seu "unit test" e essa experiência pessoal, é preciso fazer
duas perguntas:

* Quem já usou a expressão "testes de unidade"?
* Quem já discutiu qual era a "unidade" de "testes de unidade"?

Existem várias discussões sobre isso, incluíndo uma recente (com relação à
este post, no entanto) sobre [como escrever testes de alta qualidade](http://www.marclittlemore.com/how-to-write-high-quality-unit-tests/) (em
inglês), em que o autor comenta

   Se você estiver programando com orientação à objetos, a sua unidade devem
   ser as classes; se estiver programando de forma funcional, a sua unidade
   são as funções.

O problema é que essa visão, além de incorreta com relação ao que Kent Beck
prega no seu livro (pelo menos, segundo Ian Cooper), ela gera mais problemas
do que soluções.

## Um exemplo errado de unidade

Vamos pegar a ideia geral de "unidades de teste" e aplicar num pequeno caso.
Digamos que você tenha a seguinte classe para manter seus clientes:

```python
class Client:
    def __init__(self, name):
        self.name = name
```

Uma classe simples, onde você tem o nome do cliente (obviamente, num caso real,
a classe teria mais propriedades e mais uma pilha de métodos, mas para fins de
exemplo, vamos manter simples e curto.)

Conforme o produto evolui, surge o seguinte requerimento:

> Não podem ser cadastrados clientes com apenas um nome.

Nesse ponto, você resolve aplicar os princípios [SOLID](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design)), aplicando o
"Princípio da Responsabilidade Única" e gera a seguinte alteração:

```python
def _multiple_names(name):
    split_names = name.split(' ')
    return len(split_names) > 1

def _validate_name(name):
    if not _multiple_names(name):
        raise Exception("Invalid name")
    return name

class Client:
    def __init__(self, name):
        self.name = _validate_name(name)
```

Isso obedece boa parte do SOLID e do SRP porque a função `_validade_name`
tem uma única responsabilidade, dizer se o nome é valido ou não (e o "bacana" é
que, se surgir uma nova condição definindo o que é um nome válido, basta
adicionar nessa função a chamada do novo validador); ainda, `_multiple_names`
tem uma única responsabilidade, dizer se o nome é composto por múltiplos nomes
ou um só.

Até aqui, não falamos nada de teste. Então vamos lá: você criou estes três
componentes e agora quer escrever os testes. Como é preciso escrever um
teste por classe e por função, você escreve essa excelente suíte de testes:

```python
import pytest

def test_single_name():
    assert not _multiple_names('Cher')

def test_multiple_name():
    assert _multiple_names('Julio Biason')

def test_valid_name():
    _validate_name('Julio Biason')

def test_invalid_name():
    with pytest.raises(Exception):
        _validate_name('Cher')

def test_client_error():
    with pytest.raises(Exception):
        Client(name='Cher')

def test_client():
    Client(name='Julio Biason')
```

{% note() %}
Sim, o certo seria escrever os testes antes do código, mas isso não é o que
acontece; afinal de contas, como é que você teria um teste para a sua classe se
você não escreveu a classe ainda -- e isso é mais uma prova que a pergunta de
"unidade de teste" está errada.
{% end %}

Uma vez escritos os testes, você roda os testes e... 

```
$ pytest client.py
==== test session starts ====
rootdir: /home/jbiason/unitt, inifile:
collected 6 items

client.py ......

==== 6 passed in 0.03 seconds ====
```

Excelente, todos os testes passaram; e como está a cobertura de testes (que é
algo que todo mundo que fala em "unidades de teste" se preocupa, afinal de
contas, você precisa garantir que tem testes para todas as classes e todas as
funções, certo?) 

```
$ pytest --cov=client client.py
==== test session starts ====
plugins: cov-2.4.0
collected 6 items

client.py ......

---- coverage: platform linux, python 3.4.3-final-0 ----
Name        Stmts   Miss  Cover
-------------------------------
client.py      25      0   100%

==== 6 passed in 0.11 seconds ====
```


100% de cobertura; excelente! Você encerra o dia e fica vendo vídeos no
YouTube o dia todo, até que alguém do financeiro vêm com essa notícia:

> "Não podemos perder a Cher, a Xuxa, a Madonna, a Björk e o String como
> clientes!"

Seu pensamento é "meleca". Bom, hora de retornar o código para seu estado
anterior:

```python
class Client:
   def __init__(self, name):
      self.name = name
```

{% note() %}
Na verdade, a parte que deveria ser alterada é justamente a `_validate_name`,
que não precisa mais perguntar se o cliente tem múltiplos nomes; eu mudei no
lugar errado propositadamente para aumentar o efeito catastrófico da coisa.
{% end %}

Alteração feita, é hora de rodar os testes para ver o que aconteceu:

```
==== FAILURES ====
____ test_client_error ____

    def test_client_error():
        with pytest.raises(Exception):
>           Client(name='Cher')
E           Failed: DID NOT RAISE <class 'Exception'>

client.py:37: Failed
==== 1 failed, 5 passed in 0.63 seconds ====
```

Ah, lógico! "Cher" agora é um nome válido e, portanto, não vai mais levantar a
exceção. Você altera o `test_client_error` para não esperar a exceção mais e
roda os testes de novo: 

```
$ pytest  client.py
==== test session starts ====
rootdir: /home/jbiason/unitt, inifile:
plugins: cov-2.4.0
collected 6 items

client.py ......

==== 6 passed in 0.03 seconds ====
```

Só para garantir, vamos rodar com cobertura de novo: 

```
$ pytest --cov=client  client.py
==== test session starts ====
rootdir: /home/jbiason/unitt, inifile:
plugins: cov-2.4.0
collected 6 items

client.py ......

---- coverage: platform linux, python 3.4.3-final-0 ----
Name        Stmts   Miss  Cover
-------------------------------
client.py      24      0   100%

==== 6 passed in 0.12 seconds ====
```

Aí você se dá uns tapinhas nas costas por ter arrumado as coisas super rápido
por ter pensado em seguir o SOLID, os testes escritos continuam todos
funcionando corretamente e volta a ver vídeos.

Entretanto, agora você criou um monstro: as funções `_validate_name` e
`_multiple_names` *não* são mais necessárias, mas você não vê isso porque os
testes de cobertura continuam indicando que tudo está sendo testado. E assim
sua base de código vai crescendo e ninguém vê exatamente que há partes
desnecessárias porque a cobertura, que deveria indicar partes que não estão
sendo chamadas... estão sendo chamadas (pelos testes).

{% note() %}
Algumas linguagens compiladas utilizam o conceito de "dead code": código que
nunca é chamado e que não é necessário. Entretanto, dependendo da linguagem,
isso pode não ser indicado em lugar nenhum porque o teste está usando a função
e, portanto, ele não está realmente morto.
{% end %}

## De volta a Kent Beck

Se voltarmos ao que Kent Beck disse no seu livro, temos que 

> "Rode de forma isolada", nada mais, nada menos.

Ou seja, não são "testes de unidade", mas "testes unitários", no sentido de
que o teste consegue gerar e consumir todas as informações necessárias para
completar sua execução. No nosso exemplo de clientes, um teste que faz a
pesquisa por um cliente com um certo nome não deve, de forma alguma, depender
do teste que cria clientes. O teste **deve ser** unitário, ele não depende de
mais nenhum outro teste para funcionar.

Discussões sobre "qual a unidade" é que levaram a criação de modelos como
Behavior Driven Development (BDD) e Acceptance Test-Driven Development (ATDD);
na verdade, o que elas fazem é mudar a semântica do que são os testes para que
as pessoas olhem o que precisa ser feito ao invés de sair testando "unidades".

## O que testar

A aproximadamente três semanas (novamente, baseada na data deste post)
apareceu uma pergunta no Reddit sobre se [devem ser testados os componentes
internos do Django](https://www.reddit.com/r/django/comments/5bearg/should_i_write_unit_tests_for_djangos_built_in/), 
especificamente, se um campo inteiro deve ter testes para averiguar se o mesmo
retorna erro no caso de serem passados valores não-numéricos.

Esse foi um ponto que, numa primeira instancia, eu achei que não, mas a
verdade é que sim, isso deve ser testado. Não porque você quer garantir que um
campo numérico só aceita valores numéricos, mas porque a sua definição desse
campo (que pode ser, por exemplo, um CEP, ou uma idade) deve aceitar somente
valores numéricos. Você não está testando se o framework retorna um erro com
valores não-numéricos, mas porque você precisa validar se *o seu campo é
numérico*.

Em outras palavras, o que deve ser testado não é como o sistema foi
implementado, mas se os *requisitos* pedidos estão sendo cumpridos ("a
idade/CEP deve aceitar apenas números"). *Essa* é a unidade dos testes, se
vocês quiserem insistir na falácia. Essa é a *única* unidade que deve ser
testada.

Ou, como melhor colocou Kent Beck:

> Evite testar detalhes de implementação, teste comportamentos.

## O ciclo do TDD e o LSP

Uma coisa que o TDD promove é o ciclo "Vermelho", "Verde", "Refatoração". Isso
pode ser "traduzido" como

> Escreva seu teste que garanta um certo requisito; como não há
> implementação, ele irá falhar (aparecer como vermelho nos resultados dos
> testes).
>
> Escreva a implementação. O teste irá passar para verde. Essa refatoração
> deve ser o mínimo de código necessário para fazer o teste passar.
>
> Refatore o código para remover código duplicado, má escolha de nomes de
> variáveis, quebras do SOLID, etc [#unclebob]_.

{% note() %}
Eu nunca consegui produzir código TDD de verdade, mas alguns vídeos, como por
exemplo [Uncle Bob falando sobre test transformations](https://vimeo.com/97516288>),
fazem com que eu acredite que TDD puro e correto *funciona*.
{% end %}

Normalmente, depois de refatorar, espera-se que o código volte para o vermelho
-- ou, pelo menos, é o que o gráfico utilizado deixa a entender. Entretanto,
se você focou no requisito e não na implementação, o teste deve continuar
verde, por mais que você refatore.

Se voltarmos para o exemplo do nome único, nossos testes seriam apenas dois:
barrar usuários com apenas um nome e deixar passar aqueles com dois ou mais.
Todos os demais testes são desnecessários porque não fazem parte dos
requisitos. Se essa validação será feita no próprio `__init__`, se isso vai
ser outra classe, se vamos mandar isso para outro serviço que fará a validação
do nome, nada disso importa: o que precisamos é *barrar* usuários com apenas
um nome e *aceitar* aqueles com dois ou mais. Nada mais, nada menos.

Se voltamos para o SOLID, existe um princípio que se encaixa nessa
consideração: LSP - Princípio de Substituição de Liskov. Esse princípio é, na
verdade, um nome complicado para "design por contrato"; no nosso exemplo,
nosso contrato é: "Se você mandar um cliente com apenas um nome, irá ocorrer
uma falha; clientes devem ter dois nome ou mais." Se amanhã eu trocar a classe
inteira por outra, se eu reescrever a classe inteira, se eu mudar de
linguagem, o teste deverá continuar passando (claro, considerando que eu
consiga rodar os testes numa linguagem diferente da linguagem da
implementação). Meu "contrato" continua válido, não importa a implementação
que estamos falando. Meus requisitos continuam sendo verdadeiros, não importa
como eu implementei. Meu *comportamento* continua sendo verdadeiro, validado
pelos testes.

Parte disso vem da definição de requisitos. Se você não tem requisitos bem
definidos, você não tem o que testar. E ficar testando funções e/ou classes
não vai lhe ajudar em nada, porque estes não são seus requisitos e, portanto,
não fazem parte do seu contrato.

## Como eu vi TDD funcionar de verdade

Eu comentei no começo desse post como o vídeo do Ian Cooper ressonou com uma
experiência pessoal trabalhando com TDD. Essa experiência foi relacionada ao
trabalho com um gerenciador de alarmes: Vários componentes do sistema iriam
gerar "eventos" e, conforme o evento gerado, o gerenciador de alarmes deveria
1) gerar apenas um log; 2) gerar um log e enviar um aviso pela rede; 3) ativar
um indicador de erro que continuaria ligado até que outro evento o desligasse.

Como seguimos os princípios do SOLID, o código ficou separado, internamente,
em quatro componentes: um componente de tomada de decisão, que indicaria para
quais outros componentes o evento seria enviado; um componente para geração de
logs; um componente para avisos através da rede; e, finalmente, um componente
que ativaria ou desativaria alarmes relacionados com o evento. Da mesma forma,
como eu não tinha noção ainda de testar comportamentos, eu acabei escrevendo
testes que injetavam diretamente um evento que deveria ser logado no
componente de logs e verificava o resultado; um evento que deveria ser enviado
pela rede e verificava se o mesmo era gerado; um evento que deveria ser
mantido como alarme para o componente de alarmes e verificava se o mesmo era
ativado (e outro teste que enviada o evento de ativar alarme e depois enviava
o evento de desativar alarme e verificava se o mesmo ficava desativado --
afinal de contas, um teste não pode depender de outro).

Entretanto, algo não "parecia" certo. No momento, parecia que tudo estava ok,
mas não tínhamos a sensação de que o aplicativo como um todo estava
funcionando. Foi nesse ponto que começamos a falar de "testes de ponta a
ponta": testes que utilizariam um componente para gerar o evento externamente
do gerenciador de alarme e, depois de chamado, verificaria o estado final do
sistema. Estes testes, apesar de serem mais complexos de serem escritos
(porque haviam várias camadas intermediárias até que que o evento partisse de
um aplicativo e chegasse ao gerenciador de alarmes), eles passaram a fazer
muito mais sentido que testar cada componente isoladamente. Na época, eu não
me liguei o porquê, mas depois do vídeo, eu entendi: Fazia mais sentido porque
estávamos testado o *comportamento*, não a *implementação*.

## Resumo

Se tudo ficou complexo, eu posso resumir TDD (de verdade) da seguinte forma:

* Escreva testes que verifiquem requisitos, não a implementação do requisito;
* A implementação pode mudar, os testes não deveriam;
* Garanta que o teste dependa apenas de si mesmo e não de outros testes;
* Use cobertura apenas para identificar código que pode ser *removido*, não
  que precisa de testes (afinal de contas, se você está verificando todos os
  requisitos e um trecho de código nunca é chamado, o que esse trecho de
  código está fazendo?)
