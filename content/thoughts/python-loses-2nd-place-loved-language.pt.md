+++
title = "Python Perde a Segunda Posição Nas Linguagens Mais Amadas: Uma Reflexão"
date = 2020-06-09

[taxonomies]
tags = ["python", "typescript", "tipos", "stackoverflow", "pesquisa"]
+++

Na pesquisa desse ano do StackOverflow, Python perdeu a segunda posição no
ranking de "Linguagens Mais Amadas" para TypeScript. No nosso grupo de Python,
as pessoas começaram a se perguntar o porque. E eu achei que seria
interessante postar minhas reflexões sobre a situação.

<!-- more -->

Antes de mais nada, eu preciso fazer um aviso de que eu adoro Python, e eu
acredito que é uma grande linguagem por ser concisa mais ainda assim bem
expressiva. Eu não acredito que tenha algum outra linguagem que chegue perto
de Python nesses quesitos.

Aviso dado, me deixem explicar porque eu acho que Python perdeu o segundo
lugar no coração dos desenvolvedores.

## Tipos

Um dos primeiros pontos que as pessoas pensam quando falamos de "perdeu uma
posição" em qualquer ranking é porque "ficou pior". Mas eu não acho que seja o
que aconteceu aqui, e o que realmente aconteceu é que TypeScript mostrou algo
melhor para desenvolvedores.

TypeScript foi projetada para desenvolvimento JavaScript, uma zona onde
qualquer coisa vale, tipos são bem flexíveis e mágicos -- ao ponto de que a
maior parte das coisas produz um
[Wat](https://www.destroyallsoftware.com/talks/wat). Usando tipos,
certificando que você não está adicionando uma string a um array, um monte de
problemas desaparecem. Não que seja uma bala de prata, mas previne uma classe
inteira de problemas que iriam aparecer em produção.

Assim, em um ambiente onde coisas caóticas acontecem, de repente você tem algo
que coloca ordem de volta e você vai adorá-lo por isso. Não que os tipos sejam
a única coisa que faz com que TypeScript seja mais amado que JavaScript, mas
pode explicar parcialmente o porque.

(Apenas para adicionar nesse ponto: Rust ainda é a linguagem mais amada, agora
por 5 anos consecutivos, e tem uma tipagem bem forte, semelhante a Haskell,
com uma sintaxe mais próxima das linguagens mais usadas.)

Eu ainda acredito que, a longo prazo, type hinting pode preencher essa falha
do Python para voltar a sua posição original. Eu gostaria que se eu
adicionasse hints em todas as funções e ter algo que permitisse definir o
nível de validação em ambientes distintos: Fazer a aplicação gerar um erro se
a função fosse chamada com os tipos incorretos em desenvolvimento; gerar um
warning (no logging ou no stderr) em staging; e fazer absolutamente nada em
produção. Isso permitiria que eu tivesse o melhor de dois mundos: Dinâmico
quando desenvolvendo mas estático em testes.

## Python 2 Morreu

Uma das coisas que aconteceu com o Python no começo desse ano, quando a
pesquisa foi feita, foi que Python 2 ficou sem suporte oficial. Obviamente
isso não significa que as instalações de Python 2 simplesmente pararam de
funcionar, mas deu um empurrão a mais para portar código para Python 3.

E, mesmo com todas as melhorias no Python 3 para ajudar a portar aplicações,
ainda assim não foi algo completamente suave. Essa mudança, essa mudança
forçada, pode ter deixado alguns desenvolvedores Python com um gosto ruim. E
ninguém quer simplesmente corrigir problemas com a linguagem, deixando as
coisas funcionarem do jeito que estavam antes, coisas estranhas e tudo mais.

## Hype

Python não é mais uma linguagem "hypada".

Ainda é a referência para machine learnign e campos relacionados, mas o antigo
ambiente de desenvolvimento web foi capturado pelo hype de outras linguagens.

Python não é mais a "legalzisse" de desenvolvimento web. E porque não é mais a
legalzisse, pessoas não _querem_ a coisa antiga; a coisa antiga não é mais
legal, então o pessoal não gosta mais dela.

Relacionado: Só porque alguma coisa tem hype, não quer dizer que seja
_melhor_; apenas faz com que as coisas sem hype se tornem "não melhores",
mesmo que não tenha havido qualquer alteração nesses últimos.

## Relacionado

Um ponto que não foi levantado no grupo: Mesmo que Python tenha perdido o
segundo lugar no ranking de "Mais Amadas", Python ainda é a linguagem mais
procurada -- o que significa que ainda é a linguagem que os desenvolvedores
mais querem _aprender_. Se o sentimento geral fosse de "Python é ruim!", eu
duvido que a procuram ainda seria representativa -- e Python ainda tem uma
liderança considerável com relação a JavaScript.

<!-- 
vim:spelllang=pt:
-->
