+++
title = "Microserviços: Chassi"
date = 2020-04-17

[taxonomies]
tags = ["microserviços", "chassi", "framework", "linguagens"]
+++

O chassi de um fleet de microserviços é definido como as bibliotecas e
frameworks que alguém deve usar quando está criando um novo microserviço.

<!-- more -->

O "chassi" é um [design
pattern](https://microservices.io/patterns/microservice-chassis.html)
conhecido, mas a literatura fala sobre a escolha de bibliotecas e frameworks
que devem ser usados quando se está criando um microserviço.

Por exemplo, se você está trabalhando com Java, você provavelmente teria algo
como Spring Boot como chassi para os seus microserviços, de forma que qualquer
um que comece um microserviço já tenha uma biblioteca (e conhecimento local)
de como construir.

E, para cada linguagem, você precisa escolher um chassi diferente -- você não
pode usar Spring Boot com Python, por exemplo.

Você deve ter notado que eu coloquei um "mas" no segundo parágrafo.
Pessoalmente, eu acho que a escolha do chassi vai bem além da criação de
microserviços.

## Conhecimento Compartilhado

Um dos maiores fatores de se usar um chassi para o seu microserviço é o
conhecimento compartilhado entre os times.  Times que utilizam o mesmo chassi
podem trocar informações em como solucionar alguns problemas, como fazer o
processamento ficar mais rápido, informações sobre releases novas e assim por
diante.

Mesmo que os times nunca mexam nos códigos dos outros, o simples fato que eles
podem compartilhar essas informações entre eles é um grande avanço.

E mesmo para times que utilizam linguagens diferentes isso é um grande ponto:
Um time pode descrever como o framework que eles utilizam permite fazer alguma
coisa de forma mais simples, de forma que outro time possa pesquisar se o seu
chassi permite fazer algo da mesma forma.

## Aplicando uma Visão Comum

Enquanto o pattern descreve apenas frameworks e bibliotecas, as escolhas dos
serviços ao redor do serviço também faz parte do chassi, na minha opinião.

Por exemplo, um time decide usar Kafka como mensageria[^1] entre serviços -- o
que permite que qualquer outro time, usando qualquer outro framework, em
qualquer outra linguagem, a usar o mesmo serviço para troca de mensagens --
permitindo que qualquer time que precise usar um serviço de troca de mensagens
possa usar a mesma instalação (mas usando tópicos diferentes), reduzindo
custos de manutenção. Mas o que acontece quando um time decide usar Kafka como
banco de dados e define o tempo de retenção para "sempre"? Isso iria confundir
completamente todos os outros. "Por que esse tópico está sempre crescendo?"
Pior, sem uma documentação de DevOps bem descrita, alguém pode ver o tópico
crescendo, verificar, ver que a política de retenção está diferente do resto e
adicionar um baseada em outros projetos.

Outro exemplo: Para dados relacionados, há uma instalação do PostgreSQL para
todo mundo. Cada time tem o seu próprio database e usuários. Mas um time, que
acabou ficando responsável por dois microserviços, tem um serviço com dados
que são relacionais e outro que basicamente necessita de um armazenamento de
chave-valor. Ao invés de pedir por um banco de dados chave-valor, o time
decide criar um database com apenas uma tabela, com um campo para a chave e um
campo de texto para guardar JSONs. Isso, novamente, quebra a definição do
chassi, pois seria esperado que o PostgreSQL fosse usado como banco
relacional e não como um banco chave-valor.

## Conclusão

Chassis são bons para o desenvolvimento de microserviços por permitir um
início de desenvolvimento rápido e com compartilhamento de conhecimento, mas
eles vão além de apenas frameworks e bibliotecas: eles relacionado tudo ao
redor dos serviços e como esses são vistos por cada microserviço.

---

[^1]: "Message broker".

<!-- 
vim:spelllang=pt:
-->

