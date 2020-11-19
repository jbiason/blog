+++
title = "Lazy Kovar"
date = 2020-11-19

[taxonomies]
tags = ["projects", "personal", "mastodon", "twitter", "rss", "microservices",
"rust"]
+++

Likes Keeper.

Just a bunch of microservices in Rust, to explore how it could be done.

- RSS -> Incoming Topic
- Mastodon Favourites -> Incoming Topic
- Twitter -> Incoming Topic 
- Incoming Topic -> Data Router (based on content, turns things into a more
    manageable format, finds if the content have any attachments [images/files]
    and puts those in a Download Topic)
- Data Router -> Save Content on Disk
- Download Topic -> Disk
