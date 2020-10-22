+++
title = "Wiggly Duralim"
date = 2020-10-22

[taxonomies]
tags = ["projects", "personal", "webdav"]
+++

Rust WebDAV server.

- Stores entries in Sled
- Login
- Web interface
- WebDAV interface
- S3 backend
   - Saves files locally for faster access, moved it to S3 in the background,
       then updates the file record for delivery
