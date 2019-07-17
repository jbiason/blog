+++
title = "Things I Learnt The Hard Way - Think About The Users"
date = 2019-07-17

[taxonomies]
tags = ["en-au", "books", "things i learnt", "privacy"]
+++

Think how the data you're collecting from your users will be used -- this is
more prevalent on these days, where "privacy" is a premium.

<!-- more -->

I once had a discussion with a CTO about collecting the user IMEI on our
mobile app. Basically, there was no use case for capturing that information
yet but, as he put at the time, "We may want to know if one user uses two
phones, or if two users use the same phone". I raised the fact that we didn't
need this information and, besides that, it felt like we were invading the
users privacy. He still decided to go ahead. My answer: "I'll do it, but I
want to point that I'm not happy with it."

In the end, the store blocked the app... because we were capturing the IMEI.

But there are cases and cases. If you really _really_ need to capture user
information, be sure to protect it against unauthorized use, be it by external
forces (someone found a way to attack your data) or internal (some disgruntled
colleague decided to take the data from your users with them).

And be sure, there _will_ be a leak at some point, it's just a matter of time.
If you can, the best way to protect your users data is to never capture it.
When a flaw on your system is found or when some colleague leaves the company
in bad terms, there will be no data to expose to the world, anyway. You can't
be more secure than this.

{{ chapters(prev_chapter_link="/books/things-i-learnt/debuggers", prev_chapter_title="Debuggers Are Overrated", next_chapter_link="/books/things-i-learnt/integration-tests", next_chapter_title="Unit Tests Are Good, Integration Tests Are Gooder") }}
