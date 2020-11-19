+++
title = "Lazy Kovar"
date = 2020-11-19

[taxonomies]
tags = ["projetos", "pessoal", "mastodon", "twitter", "rss", "microserviços",
"rust"]
+++

Likes Keeper (Agregador de Favoritos)

Um conjunto de microserviços em Rust, para explorar a possibilidade de ser
feito.

- RSS -> Incoming Topic
- Mastodon Favourites -> Incoming Topic
- Twitter -> Incoming Topic 
- Incoming Topic -> Data Router (baseado no conteúdo, transforma para um
    formato mais maleável, verifica se o conteúdo tem anexos [imagens/arquivos]
    e coloca estes no tópico de Download)
- Data Router -> Save Content on Disk
- Download Topic -> Disk
