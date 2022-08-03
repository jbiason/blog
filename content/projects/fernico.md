+++
title = "Condensed Fernico"
date = 2020-10-22
updated = 2022-08-03

[taxonomies]
tags = ["projects", "personal", "finance", "cli", "storage"]
+++ 

CLI Finance

- CLI interface
- Storage: ~~Diesel? SQLite directly?~~ SQLx
- Save attachments: How?
  - Store in the database, as Base64 (along mimetype and name)
- Short UUID for records
- Uses event store for all operations
   - We can sync using the event store
