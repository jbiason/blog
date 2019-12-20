+++
title = "Flask em 40 Minutos ou Menos: Iniciando"
date = 2017-09-25

[taxonomies]
tags = ["python", "flask", "uwsgi", "companion post"]

+++

Uma "breve" explicação de como colocar uma aplicação Flask em produção em 40
minutos. Nessa primeira parte, vamos mostrar como começar um script Flask.

<!-- more -->


Flask é um micro framework web em Python, muito fácil de ser usado e
configurado. Mas o processo inteiro de como começar a aplicação, adicionar
rotas e depois disso partir para colocar em produção pode ser uma pequena dor
de cabeça. Então veremos como fazer todo o processo.


## O VirtualEnv

O primeiro passo de qualquer grande aplicação Python é o VirtualEnv.
VirtualEnv é utilizado para separar as bibliotecas do Python entre aplicações
-- assim você pode ter a biblioteca X numa versão para um determinado projeto
e outra versão para outro projeto. Apenas lembre-se que o VirtualEnv gerencia
apenas bibliotecas do *Python*, portanto não espere que o mesmo controle
versões diferentes de MySQL, por exemplo.

{% note() %}
VirtualEnv não vai cuidar da versão do MySQL, mas pode controlar a versão do driver para Python.")
{% end %}

Para criar um VirtualEnv:

```
python -m venv venv
```

{% note() %}
Se ainda estiver usando Python 2, o comando é `virtualenv venv`.
{% end %}

Depois de executar esse comando, você verá que irá surgir um diretório
`venv`. O último parâmetro é justamente o diretório que será utilizado para
armazenar as informações do VirtualEnv e pode ser criado com qualquer nome e
em qualquer lugar -- inclusive fora do projeto [#venvwrapper]_.

{% note() %}
Alguns pacotes como o [VirtualEnvWrapper](http://virtualenvwrapper.readthedocs.io/en/latest/)_
fazem exatamente isso: Os pacotes são instalados em um diretório separado,
apenas para VirtualEnvs.
{% end %}

Uma vez criado o VirtualEnv, é preciso ativar o mesmo:

```
source venv/bin/active
```

Ou, se estiver usando Windows (sim, você pode rodar os comandos no Windows):

```
venv/Scripts/activate.bat
```

Se tudo deu certo, deve aparecer um `(venv)` no começo do prompt, indicando
que o VirtualEnv está ativo.

Apenas note o seguinte: O VirtualEnv foi projetado para ser destruído e
reconstruído quantas vezes forem necessárias. Por isso, você *não deve*
adicionar o diretório do VirtualEnv no seu repositório;
quem precisar utilizar, que recrie o ambiente.

{% note() %}
Além de não colocar o diretório do virtualenv no seu repositório, tente não
instalar pacotes Python utilizando o sistema de pacotes da sua distribuição.
{% end %}

{% note() %}
O que o `venv` faz é criar vários scripts para as tarefas
relacionadas com o mesmo -- como a ativação do VirtualEnv -- e estes
scripts mantém o caminho de onde foram criados. Com isso, se você adicionar
o mesmo no seu sistema de controle de versão, somente você poderá usar (a
não ser que a outra pessoa tenha exatamente a mesma estrutura de
diretórios). Lembre-se: VirtualEnvs existem para conter as bibliotecas que
você usa e podem ser destruídos e criados livremente -- E como podem ser
criados facilmente, não devem ser incluídos no seu controle de versão -- e
se estou me repetindo, é porque *muitas* pessoas fazem isso, erroneamente.
{% end %}


## Requirements.txt

O modo mais fácil de instalar um pacote -- dentro de um VirtualEnv, obviamente
-- é utilizando o módulo `pip`:

```
python -m pip install flask
```

{% note() %}
Ou, se ainda estiver usando Python 2, `pip install` -- se
realmente preferir, você pode usar `pip install` mesmo com Python 3, pois
ele instala um alias para `python -m pip`.
{% end %}

Mas, como comentado sobre VirtualEnv, onde a ideia é criar, destruir e criar o
ambiente quantas vezes você quiser, ficar passando a lista de pacotes a serem
instalados não faz sentido. Por isso, normalmente é gerado um arquivo com a
lista de requisitos. Esse arquivo, mais por convenção da comunidade do que por
requisito da ferramenta, é o chamado `requirements.txt` Nesse
arquivo você pode colocar a lista de requisitos do seu sistema, incluindo a
versão se necessário.

{% note() %}
E, caso você tenha requisitos que são necessários somente para
desenvolvimento, a convenção diz pra ter um arquivo chamado
`requirements-dev.txt`, cuja a primeira linha é `-r requirements.txt`.
{% end %}

Por exemplo, como a versão do Flask no momento da escrita desse artigo é a
0.12.2, podemos ter um `requirements.txt` com o seguinte conteúdo:

```
flask==0.12.2
```

... indicando que queremos que seja instala a versão 0.12.2. Existe ainda o
operador `~=` [#specifiers]_,que significa "versão compatível com a
indicada". Assim nos precavemos da possibilidade de ser encontrada uma falha
de segurança no Flask, sem precisar sair correndo atrás de todos os
`requirements.txt` com Flask para atualizar a versão e garantimos que,
quando sair a versão 0.13 (ou qualquer outra seguinte) que seja incompatível
com 0.12.2, nosso código ainda vá funcionar.

{% note() %}
Para uma lista de todas as formas de como especificar
versões, olhe o [PEP 440](https://www.python.org/dev/peps/pep-0440/#version-specifiers).
{% end %}

Assim sendo, teremos um `requirements.txt` com o seguinte conteúdo:

```
flask~=0.12.2
```

Mas e para instalar isso? Para isso existe a opção `-r` do pip, que ao invês de
esperar por um nome de pacote para ser instalado, a lista de pacotes é
carregada a partir do arquivo indicado. Então para
gerar o ambiente:

```
python -m pip install -r requirements.txt
```


## O Esqueleto de uma Aplicação Flask

Para verificar se tudo está instalado corretamente, você pode utilizar o
seguinte arquivo de exemplo:

```
from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
   return 'Olá'
```

{% note() %}
Apenas lembre-se de *não* chamar o nome do arquivo de `flask.py`,
porque esse é o nome do módulo e ao invés de importar o módulo do Flask,
ele vai tentar importar o conteúdo do próprio arquivo e, como o objeto
`Flask` não existe, você vai receber um erro de `ImportError: cannot
import name 'Flask'`.
{% end %}

E para executar:

```
FLASK_APP=main.py flask run
```

{% note() %}
Se você percebeu, a variável `FLASK_APP` foi definida com o
nome `main.py`; esse é o nome que eu escolhi para a minha aplicação (e o
nome do arquivo fonte -- aquele que não pode ser `flask.py`),
mas você pode usar o nome que quiser. Apenas lembre-se de usar esse mesmo
nome em `FLASK_APP`.
{% end%}

Se estiver tudo ok, você deve receber a mensagem

```
* Serving Flask app "main"
* Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

E acessando a URL indicada, você deverá ver o "Olá".

Até aqui vimos como instalar e iniciar um projeto Flask básico. No próximo
post vou falar da aplicação Flask em si.
