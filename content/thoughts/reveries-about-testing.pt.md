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

Embora não factual, uma anedota: Num projeto, tínhamos um "gerenciador de
alarmes" onde, a partir de um evento, poderia ser gerado simplesmente um log,
ser gerado um log e enviado um sinal SNMP ou, dependendo da configuração do
usuário, log, SNMP e ativação de um LED no painel frontal do equipamento.
Assim, criamos um módulo com a geração do log, um módulo com o envio do SNMP e
um módulo com a ativação/desativação do LED. Embora tudo tivesse testes, nós
ainda não nos sentíamos tranquilos com aquilo. Foi quando sugeri que
escrevêssemos um teste que levantasse o serviço e enviasse os eventos e ver o
que acontecia. E, finalmente, os testes fizeram sentido. (Eu ainda vou fazer
referências a esses testes na parte de cobertura.)

## Fast Tests, Slow Tests

O contraponto do que eu comentei acima pode ser algo parecido com [Fast Tests,
Slow Tests](https://www.youtube.com/watch?v=RAxiiRPHS9k), do Gary Bernhardt.
Em resumo, nessa apresentação, Bernhardt comenta que mudaram os testes e que
agora era possível executar centenas de testes em menos de 1 segundo (um
exemplo mostra aproximadamente 600 testes em 1.5 segundos).

O que o Bernhardt sugere é escrever testes apenas para os models, sem conexão
com o banco ou views; testes de controllers sem conexão com os models ou
views; e testes de views sem controllers.

Soa familiar (principalmente em frameworks MVC que separam cada um destes em
classes separadas)?

Ainda sobre esses testes, Bernhardt aponta que essas "execuções rápidas"
ajudam os desenvolvedores a testar suas alterações rapidamente (ainda soa
familiar?) mas que esses testes não substituem os testes de integração.

Nesse ponto é preciso se perguntar: se são escritos testes que verificam a
execução de um controller de forma isolada do resto do sistema, mas ainda é
necessário escrever os (chamados) testes de integração para garantir que o
projeto está entregando o que foi prometido entregar, o que é que está
realmente sendo testado? A impressão que deixa é que o estilo de teste pregado
por Bernhardt está mais para _aderência à arquitetura_ do que um teste de
qualidade do sistema: Esse controller segue a estrutura de não ter conexões de
banco em si?  Esse model tem apenas as funções relacionadas com o
armazenamento e recuperação dos dados, sem qualquer lógica? Se é isso, qual o
valor para meu usuário se o controller não faz nenhuma gravação no banco de
dados?

Não que eu acredite que testes desse tipo sejam desnecessários, mas eles
deixam a impressão que, a longo prazo, eles tendem a se parecerem,
estruturalmente, muito parecidos, enquanto que (assim chamados) testes de
integração tendem a dar mais retorno a longo prazo para a qualidade do
projeto: Testes que definem uma entrada e um resultado esperado tendem a
garantir que, a longo prazo, o funcionando do sistema continuará sendo igual.

## Explosão de Testes Lentos

A primeira consideração que surge numa declaração como a de cima é que "testes
de integração são lentos e isso vai tornar os testes lentos e reduzir a
produtividade dos desenvolvedores.

Sim, testes de integração são lentos, principalmente porque há um bom trabalho
em criar o estado esperado, todas as entradas conforme esperado pelo sistema
de I/O (de novo, interface gráfica, linha de comando, web), percorrer todo o
percurso do processamento e verificar a saída. E sim, esperar esse tempo de
execução pode acabar distraindo o desenvolvedor.

Entretanto, quando um desenvolvedor está trabalhando num tratamento de algum
dado, se for uma nova funcionalidade/comportamento esperado, obviamente um
teste desse comportamento deve ser criado; se é uma alteração de
comportamento, deve haver um teste do comportamento esperado e esse deve ser
corrigido. Executar _apenas_ esse teste é o suficiente? Não, mas já dá boas
indicações de que a funcionalidade está funcionando como prevista. Depois de
garantir que a funcionalidade está correta, o desenvolvedor pode executar a
suite de testes do elemento sendo alterado e deixar o resto para o CI. 

Por exemplo, se eu estiver trabalhando numa funcionalidade nova de mostrar uma
mensagem de erro caso seja feito um pedido quando o produto pedido não exista
no estoque, eu tenho que escrever um novo teste que crie um produto, deixe-o
com uma quantidade 0 em estoque, faça o pedido de compra e verifique que houve
erro. Uma vez que esse teste confirme a funcionalidade, eu posso rodar os
demais testes de pedidos, e depois disso deixar o CI validar que eu não
quebrei nada no gerenciamento de estoque ou cadastro de clientes (por algum
motivo).

E note que provavelmente para fazer todas essas validações, eu ainda vou
precisar de várias funções/classes e testar cada uma em separado não garante a
funcionalidade, mas eu vou voltar a esse tópico quando tiver falando de
cobertura.

Isso me parece o mais complicado pois parece haver, ao mesmo tempo, uma
interface muito ruim das ferramentas de testes para executar suites de testes
(somente os testes de pedidos, no exemplo anterior) e preguiça em executar
apenas os testes da suite (é mais fácil chamar o comando que roda todos os
testes que lembrar do caminho específico da suite -- sem contar organização de
suites para isso).

## Coverage

Ao contrário de que muitos comentam por aí, eu realmente acredito que seja bem
viável chegar a 100% de cobertura de testes: Basta apagar código.

A ideia é bem simples, na verdade: Se meus testes testam o comportamento do
sistema, e eu estou garantindo que esses testes passam, qualquer coisa que não
tenha cobertura indica que o código não é necessário e que, portanto, pode ser
removido.

Entretanto, não é qualquer código que possa ser apagado. No exemplo do
gerenciador de alarmes, apesar dos "testes unitários" cobrirem todas as
funcionalidades, aconteceu que no "teste de integração" surgiu um bloco de
código que nunca era executado. Esse bloco era responsável por validar a
entrada de um dos módulos (garantindo que não seria possível enviar um SNMP
sem mensagem, por exemplo). Entretanto, ao examinar o código durante a
execução, nós percebemos que o módulo base já estava fazendo essa validação e
que o código de proteção do módulo jamais seria chamado. Obviamente, essa é
uma questão sobre qual dos dois testes deveria ser eliminado. Mas nós tínhamos
"código morto", considerado "vivo" porque um "teste unitário" estava passando
pelas duas validações.

Um exemplo mais prático. Imagine uma classe que guarde dados de clientes de
um serviço web de compras[^2]:

```python
class Client:
    def __init__(self, name):
        self.name = name
```

Entretanto, depois de um tempo, surge um novo requisito: Um tal de "Zézinho"
está criando usuários sem parar, sem fazer compras, só pra sujar o banco;
devemos bloquear todos os cadastros que tenham como nome do usuário apenas um
nome.

Aí, pensando em SOLID[^3], o desenvolvedor altera o código para o seguinte:

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

Agora o que acontece é que quando um cliente é criado, são passadas as
validações sobre o nome, e uma dessas é que o nome deve ter múltiplos
nomes[^4].

Nova funcionalidade, precisamos de novos testes, certo?

```python
import pytest

def test_single_name():
	"""'Cher' não tem multiplos nomes."""
    assert not _multiple_names('Cher')

def test_multiple_name():
	"""'Julio Biason' tem múltiplos nomes."""
    assert _multiple_names('Julio Biason')

def test_valid_name():
	"""'Julio Biason' é um nome válido."""
    _validate_name('Julio Biason')

def test_invalid_name():
	"""'Cher' não é um nome válido e por isso levanta uma exceção."""
    with pytest.raises(Exception):
        _validate_name('Cher')

def test_client_error():
	"""Se tentar criar uma conta com 'Cher', deve dar erro."""
    with pytest.raises(Exception):
        Client(name='Cher')

def test_client():
	"""Uma conta com nome 'Julio Biason' deve funcionar."""
    Client(name='Julio Biason')
```

E ao rodar os testes:

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

100% de cobertura e funcionalidade implantada! O desenvolvedor se dá uns
tapinhas nas costas e vai pra casa.

Entretanto, durante a noite, acontece de um dos gerentes ser amigo da Xuxa,
que tentou fazer uma compra e não conseguiu. O desenvolvedor chega de manhã e
vê o email do gerente e sai a corrigir o código:

```python
class Client:
    def __init__(self, name):
        self.name = name
```

Pronto, não tem mais validação[^5] e agora a Xuxa pode comprar. Mas ao rodar
os testes:


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

A, é claro! Agora Cher é um nome válido e o comportamento testado é invalido.
Vamos mudar o teste para o comportamento esperado para a Cher:

```python
def test_client_error():
	"""Se tentar criar uma conta com 'Cher', deve funcionar."""
	Client(name='Cher')
```

E rodando os testes de novo:


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

Maravilhoso, tudo está funcionando com o comportamento esperado e ainda temos
100% de cobertura.

Mas você consegue ver onde está o problema desse código?

O problema é que `_multiple_names` não é mais usado em lugar algum, mas o
mesmo se mostra "vivo" porque um teste perdido continua indicando que o código
está vivo. Se tivéssemos começado com os testes de comportamento desde o
começo -- considerando entradas e saídas -- de cara veríamos que a função não
é mais necessária -- e se, num futuro, ela for... bom, é pra isso que sistemas
de controle de versão existem.

Embora esse possa parecer um exemplo bobo, existem outros casos em que o fluxo
de processamento dos dados pode ser alterado pelo próprio ambiente. Por
exemplo, no Django, é possível ter classes "middleware", que são capazes de
interceptar Requisições ou Respostas e alterar o resultado o mesmo. O exemplo
mais comum é o middleware de Autenticação, que adiciona informações do usuário
logado na Requisição; mas essas alterações podem ser mais profundas, como
alterar os dados do formulário, por exemplo. Nesses casos, a entrada (ou a
saída, ou ambos) é afetada e, portanto, qualquer coisa que ignore os
middlewares não vai representar a entrada (ou saída, ou ambos) do sistema
corretamente. E aí podemos perguntar se o teste é válido por gerar estados que
não devem existir naturalmente no sistema.

## Mocks

Há um tempo, eu indicava que "mocks" deveriam ser usados para coisas externas
ao sistema. Entretanto, eu percebi que essa definição não é bem precisa --
existem coisas externas que não devem ser mockadas -- mas que uma definição
melhor para o que deve ser mockado é "qualquer coisa que esteja fora do seu
controle".

Por exemplo, se você está escrevendo um sistema que faz geolocalização de IPs
através de um serviço externo, você provavelmente irá mockar a chamada para o
serviço, já que ele está fora do seu controle. Mas uma chamada para o banco de
dados, quando você já utiliza um sistema de abstrai toda a parte de banco de
dados (por exemplo, Django), então o banco não é mais uma entidade externa, e
sim interna do sistema e que, portanto, não deveria ser mockada -- mas como o
sistema oferece uma abstração do banco, então usar qualquer banco não deve
afetar o resultado.

Outro exemplo são microserviços. Mesmo microserviços dentro da mesma empresa
ou mesmo grupo são externos e fora do controle do projeto e, portanto,
mockados. "Mas são da mesma equipe!" Sim, mas não são do mesmo projeto, já que
a) a ideia de microserviços é justamente desacoplar esses serviços e/ou b)
estão em árvores de diretórios separados. Uma das vantagens de microserviços
da mesma equipe é que o contrato esperado por um é conhecido pela equipe e
isso pode ser mockado de forma fácil (a equipe sabe que, chamando um serviço
com dados X, haverá a resposta Y -- ou erro).

# Conclusão

De novo, a ideia não é reescrever todos os casos de testes que você tem para
"o jeito certo, que é o meu jeito". Entretanto, eu realmente vejo muitos
testes sendo escritos "a revelia", considerando a simples métrica de "um teste
por função/classe" e, em muitos casos, isso não faz sentido e que precisariam
ser repensados. Expondo esses "pensamentos impuros" sobre testes, minha ideia
era realmente fazer com que as pessoas repensassem a forma como os testes
estão sendo criados.

---

[^1]: O porque vai ser uma string pode ser variado: por causa de um plugin de
  segurança, porque é feito um armazenamento num banco que não trabalha bem
  com inteiros, por causa de uma integração com sistema legado...

[^2]: Uma classe de entidades de clientes deveria ser bem mais completa que
  essa, mas vamos deixar ela simples assim para fins de exemplo.

[^3]: E não, isso também não é SOLID de verdade, mas vamos deixar assim de
  novo para fins de exemplo.

[^4]: E alguém vai me passar o link do "Falácias que Desenvolvedores Acreditam
  Sobre Nomes de Usuários" por causa disso.

[^5]: E sim, deveria alterar só o `_validate_name`, mas assim fica mais claro
  onde está o problema.
