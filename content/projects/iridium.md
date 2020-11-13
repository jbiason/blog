+++
title = "Potent Thrifty Iridium"
date = 2020-10-22
updated = 2020-11-13

[taxonomies]
tags = ["projects", "personal", "postgres", "tui"]
+++ 

Postgres Text Interface.

- Simple, Borland-like interface.
- List of servers/connections.

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

- `<Tab>` jumps between results and query.
- Save queries?
   - Could save and load files, the are pure text anyway...
- How does one disconnect/return to server list?
- VIM-like keybinds, maybe?
- Replace commands like `\dt` with `show tables` (accept both)
   - More interesting, using `show tables` should show that the actual command
       is `\dt`
- Auto-complete tables, fields, etc (pretty much what psql does already)
