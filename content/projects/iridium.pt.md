+++
title = "Potent Thrifty Iridium"
date = 2020-10-22
updated = 2020-10-23

[taxonomies]
tags = ["projetos", "pessoal", "postgres", "tui"]
+++ 

- TUI para Postgres.
- Interface simples, tipo Borland.
- Lista de servidores/conexões.

```
+----------------------------------------+
| *Connected to XXX*                     |
+----------------------------------------+
| Query                                  |
|                                        |
|                                        |
|                                        |
+----------------------------------------+
| Results                                |
| +----+---------+----------+------+---> |
| | Fi | Field   | Field    | Fiel | F   |
| +----+---------+----------+------+---> |
| | Va | Value   | Value    | Valu | V   |
| | Va | Value   | Value    | Valu | V   |
| | Va | Value   | Value    | Valu | V   |
| | Va | Value   | Value    | Valu | V   |
| +----+---------+----------+------+---> |
+----------------------------------------+
```

- `<Tab>` pula entre resultados e query.
- Salvar queries?
- Como fazer para desconectar/retornar para a lista de servidores?
- Teclas tipo Vim, talvez?
- Alterar comandos como `\dt` para `show tables` (mas acertar os dois)
   - Melhor ainda, se o usuário usar `show tables`, mostrar que o comando de
       verdade é `\dt`
- Auto-complete tabelas e campos (mais ou menos o que o psql já faz hoje)

<!--
vim:spelllang=pt:
--> 
