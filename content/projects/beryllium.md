+++
title = "Tacit Beryllium"
date = 2020-10-22

[taxonomies]
tags = ["projects", "personal", "telegram"]
+++ 

Telegram bot in Rust.

1. If the user sends a message with a link but didn't interact with the group
   before, the message is deleted.
2. URL blocklist; if message contains an URL from the blocklist, the message is
   deleted.
3. Welcome message (so, not so tacit, huh?). The main idea is to tell people
   how to share content in the group (use Gist, not paste images or code
   directly, etc).
4. Validate that the account is a real person? ("Click here to confirm you're a
   person") This doesn't invalidate point 1, as the person may connect, click
   the link and then simply some automate process post content.
