+++
title = "Condensed Sodium"
date = 2020-12-10

[taxonomies]
tags = ["projetos", "pessoal", "clientes", "status", "web", "rust"]
+++

Aplicação web de status de clientes:

* [Rocket](https://rocket.rs/)
* [Diesel](http://diesel.rs/)
* [TailwindCSS](https://tailwindcss.com/)
* Traduzível.
* Contatos
        * Nome
        * Telefone
        * Email
        * Empresa
* Clientes são basicamente grupos de contatos + interações.
* Interações podem ser marcadas como "Sucesso" ou "Aguardando".
* Arquivos podem ser anexados nas interações.
* Dashboard mostra todos os clientes e seus status.

```
+----------------------------------+
| +-----------+ +----------------+ |
| | Client 1  | | Client 2       | |
| | No issues | | Await response | |
| +-----------+ +----------------+ |
+----------------------------------+
```

"Await response" é o texto da última interação.

```
+----------------------------------+
| Client 2        [ See Contacts ] |
|                                  |
| New interaction:                 |
| [                              ] |
| [                              ] |
| [                              ] |
|            [ Await ] [ Success ] |
|                                  |
| Previous interactions:           |
| * DATE - Asked if this works   ! |
| * DATE - Await response        ? |
+----------------------------------+
```

"Previous interactions" vai do mais antigo para o mais novo.

<!--
vim:spelllang=pt:
-->
