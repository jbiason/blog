+++
title = "Sharing Daily Links"
date = 2020-03-03

[taxonomies]
tags = ["meta", "links", "sharing"]
+++

I'm changing the way I share links around the web.

<!-- more -->

For a while, I used my [Mastodon
Account](https://functional.cafe/@juliobiason) to share interesting links from
different subjects.

Today I decided to change that.

From now on, instead of sharing links directly on the microblogging site, I'll
make one post per day[^1] with links for different subjects that I collect
around the web. The difference between those two, besides the fact that I used
to post one toot[^2] per link and now it will be a post with several links, is
that I'll add some small information about the link itself or its content.

In case you're wondering why the change, the reason is that I realized it is
way better to `grep` the content of this blog than using the search feature of
DayOne, which collects all the toots I do.

{% note() %}
Just to explain how I collect those links:

1. I favourite toots and some tweets;
2. Every morning, I run [downfav](https://git.juliobiason.me/downfav.git/) to
   collect those toots and save them locally;
3. A small Python script (which I want to replace at some point) uploads the
   saved texts to my [Joplin](https://joplinapp.org/);
4. I check a specific Notebook (the one the Python script uploads things to)
   for things that have links;
5. I click the links, which open a tab on Firefox;
6. Repeat 4 till all links have been clicked;
7. Read posts;
8. If interesting, make a toot.

The step I'm changing is the 8th: Instead of making a toot for each link, I'm
going to start a blog post, add every interesting link, add a comment about it
(something missing in the previous flow) and then post everything.
{% end %}

---

[^1]: People who remember "Delicious" (or "De.li.cio.us") may remember that it
  had a feature that it will make a post on a WordPress install with the links
  you captured the day before. This is basically me resurrecting this, but in
  a manual form.

[^2]: For those who don't know Mastodon, a "toot" is a post, kinda like
  Twitter calls its posts "tweets".
