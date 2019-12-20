+++
title = "Things I Learnt The Hard Way - Take Responsibility For The Use Of Your Code"
date = 2019-07-18

[taxonomies]
tags = ["books", "things i learnt", "personal", "responsibility"]
+++

This is hard. Very very hard. It's the difference between "freedom" and
"responsibility".

<!-- more -->

There is nothing wrong in writing, for example, a software to capture people's
faces and detect their ethnicity, but you have to think about what that will
be used on.

Even on an open source project, you can take responsibility without blocking
people. You can make your project harder for people trying to abuse to use it,
to the point they will have to take control of their own fork.

One example is a small application called [Tusky](https://tusky.app/), which
is "An Android client for the microblogging server Mastodon", completely open
source. Mastodon is a network of microblogging servers with connect to each
other, kinda like Twitter, but you can pick a different server that is not
twitter.com and still get updates from that server. One of the servers that
appeared in the server list is an alt-right server which, as most alt-right
forums, promote a lot of hate. What Tusky did? When you try to add an account
on that server, instead of adding the account, [they play a video of Never
Gonna Give You Up](https://github.com/tuskyapp/Tusky/pull/1303), basically
[rickrolling](https://en.wikipedia.org/wiki/Rickrolling) anyone who, well, is
an alt-righter.

Tusky broke the open source license? No, the code is still available. Anyone
wanting to use the server can pick the code, fork it, remove the rickroll and
release their own version of the application. But Tusky developers took an
instead of saying "We'll not take part in promoting hate speech" and one can't
deny that they did.

It is a bit hard to do so on the company code -- you would get some reprimands
if you try to shame or block one of the company clients from using the company
application -- but you [can say no](/books/things-i-learnt/say-no) and,
depending on how offensive you think the use the code is, you can even start
looking for a new place to work. People on larger and "cooler" companies, like
Google, left their jobs because they didn't agree with what the company was
doing, and so can you.

{{ chapters(prev_chapter_link="/books/things-i-learnt/say-no", prev_chapter_title="Learn To Say No", next_chapter_link="/books/things-i-learnt/not-done", next_chapter_title="Don't Tell It's Done When It's Not") }}
