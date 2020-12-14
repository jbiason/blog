+++
title = "Link Comentado: Expanding Fuchsia's open source model"
date = 2020-12-13

[taxonomies]
tags = ["link", "google", "fuchsia", "open source"]
+++

Google anunciou que eles estão [mudando o modelo de código
aberto](https://opensource.googleblog.com/2020/12/expanding-fuchsias-open-source-model.html)
do sistema Fuchsia. Mas o anúncio tem tantas bandeiras vermelhas que temos que
perguntar o que diabos o anúncio realmente é.

<!-- more -->

{% note() %}
O artigo original está em inglês, e eu traduzi as frases.
{% end %}

Por exemplo: "Nós estamos desenvolvendo Fuchsia de forma aberta, no nosso
repositório git nos últimos quatro anos." Acontece que ninguém tem acesso de
escrita no repositório, apenas o Google. E, embora esteja "aberto", você não
pode sugerir alterações ou qualquer outra coisa, mesmo que você estivesse
seguindo o desenvolvimento desde a sua concepção. O modelo é tão "aberto"
quando o Adnroid, onde a única forma de contribuir com o código principal é
fazer parte do Google; você pode clonar o código do Android tanto quanto o
código do Fuchsia, mas boa sorte tentar executar o mesmo sem estragar a
garantia do seu dispositivo.

"Começando hoje, nos estamos expandindo o modelo de open source do Fuchsia para
que seja mais fácil para o público participar do projeto." Esse ponto é
importando para os próximos pontos, mas você tem que perguntar: O que está
realmente mudando no modelo? Eles estão mudando a licença, para permitir que
pessoas façam contribuições contínuas como um projeto open source? Eles estão
mudando as formas de comunicação para permitir pull requests de fora do Google?
Não, eles somente estão criando uma lista de discussão e escrevendo como alguém
consegue ganhar permissão para enviar patches ou se tornar um committer. Quão
aberto é um projeto que você precisa de um distintivo para fazer parte do
projeto?

Deixem-me tentar explicar isso usando uma analogia: Imaginem uma casa
com uma grande janela a prova de som. Vocês conseguem olhar o que tem
dentro da casa, mas não tem forma alguma que vocês consigam dizer que
o sofá fica melhor se ficar apontando para a outra parede, que um vaso
está pra cair e quebrar ou até mesmo ajudar a mover o sofá para o
outro lado da sala. Vocês não chamariam isso de uma casa aberta
(open), certo? Bom, esse é o modelo open source dos projetos do
Google: Pode olhar, mas nós não vamos te escutar e nós não vamos
deixar você entrar para mover o sofá para onde a gente quer.

"Ainda, estamos publicando um roteiro do Fuchsia para dar uma melhor ideia da
direção e prioridades do projeto." Lembram do primeiro ponto sobre ser mais
fácil para que o público possa contribuir com o projeto? Bom, como podem haver
contribuições do publico se a direção já está definida? E se o público decidir
que a direção deve ser outra? De qualquer forma, é uma perda de tempo para os
desenvolvedores atuais ou "fácil de contribuir" é simplesmente para conseguir
trabalho grátis e não para construir um projeto open source.

"Fuchsia é um projeto open source que é inclusivo por design, da arquitetura da
plataforma, para a comunidade open source que estamos construindo." Esse é um
ponto que foi levantando por outro usuário no Mastodon (olá
[Berkes](https://bitcoinhackers.org/@berkes)): Não é que alguém "constrói" uma
comunidade open source; você faz uma projeto inclusivo, aberto a qualquer um,
onde pessoas podem contribuir com código, documentação, ideias, melhorias e até
mesmo sugerindo a direção do projeto e a comunidade se constrói sozinha -- Rust
é um grande exemplo disso (e eu só estou comentando porque vou usar mais pra
frente).

Mas mesmo com tudo isso, vamos voltar um passo: Por que o Google mudaria o
"modelo" de tal OS? Será que eles não conseguiriam desenvolver eles mesmos, de
forma fechada? Claro que conseguiriam. O fato é que eles estão "abrindo o
código" porque provavelmente o projeto perdeu a importância dentro do Google e
ninguém se importa se o desenvolvimento continua. O roteiro provavelmente é
apenas a "lista de desejos" dos desenvolvedores originais e nada mais.

Ainda, existe a pergunta do "Por que Fuchsia?"; por que o Google iria investir
em um novo OS quando o Linux parece servir para praticamente todas as
necessidades deles (no final das contas, funciona bem no ChromeOS e no
Android)? Mesmo que esteja sendo desenvolvido com Rust, uma linguagem que provê
proteções de memória e deve, em teoria, prover uma experiência melhor para os
usuários, isso não significa que outras linguagens não provêem as mesmas
proteções -- Rust somente tem elas diretamente no compilador e aponta melhor
esse tipo de problemas do que outras linguagens. Mas quando você tem um sistema
operacional como o Linux, que é revisado por centenas de desenvolvedores, sendo
altamente modular e com grupos focados em diferentes subsistemas, a proteção
vem da *comunidade*. Google poderia, simplesmente, reescrever alguns sistemas
críticos em Rust e continuar assim, mas eles decidiram ir com a ideia de um
sistema completamente novo. E há rumores do que eles fizeram isso simplesmente
porque Linux é licenciado sob a GPL, uma licença que permite a contribuição de
qualquer um -- e versões mais recentes inclusive requerem que empresas
distribuam as chaves criptográficas para dispositivo que existem essas chaves
-- e que o Google simplesmente odeia.

Assim, um sistema criado (possivelmente) de puro rancor por regras que
*realmente* constroem uma comunidade open soruce agora está tentando criar uma
comunidade open source. Se isso não for justiça poética, eu não sei o que é.

<!-- 
vim:spelllang=pt:
-->
