+++
title = "Abounding Palladium"
date = 2020-10-22

[taxonomies]
tags = ["projects", "personal", "activitypub"]
+++

Activity Pub

- Bastion or Actix?
- Post ID: MD5/SHA1/SHA256 of text + attachment info
   - This makes easy to mark content as "boosts" when someone posts the same
       thing as others.
- Posts are saved directly in the filesystem (ID is directory, content inside)
- Boosts are just symlinks
