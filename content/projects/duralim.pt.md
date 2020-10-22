+++
title = "Wiggly Duralim"
date = 2020-10-22

[taxonomies]
tags = ["projetos", "pessoal", "webdav"]
+++

Servidor WebDAV in Rust.

- Guarda as entradas com Sled
- Login
- Interface Web
- Interface WebDAV
- Backend S3
   - Salva o arquivo localmente para acesso mais rápido, move o arquivo para o
       S3 usando uma thread em background e atualiza a entrada com o endereço
       de entrega

<!--
vim:spelllang=pt:
-->
