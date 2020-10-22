+++
title = "Tacit Beryllium"
date = 2020-10-22

[taxonomies]
tags = ["projetos", "pessoal", "telegram"]
+++ 

Bot do Telegram em Rust.

1. Se o usuário envia uma mensagem com um link, mas não interagiu com o grupo
   antes, a mensagem é apagada.

2. Blocklist de URLs; se a mensagem contem uma URL do blocklist, a mensagem é
   apagada.
3. Mensagem de boas vindas. A ideia é colocar um texto indicando para os novos
   usuários como se compartilha conteúdo no grupo (use Git, não cole código ou
   imagens diretamente, etc).
4. Validação de que a conta é uma pessoa real? ("Clique aqui para confirmar que
   você é uma pessoa"). Não invalida o ponto 1, já que a pessoa pode conectar,
   clicar no link e simplesmente deixar um processo automatizado de postar
   conteúdo.

<!--
vim:spelllang=pt:
--> 
