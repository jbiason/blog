+++
title = "Things I Learnt The Hard Way - One Version To Add, One Version To Remove"
date = 2019-07-30

[taxonomies]
tags = ["en-au", "books", "things i learnt", "versions", "upgrades"]
+++

A lot of things change during development. One day you need a field, another
day that field may be completely different. For those cases, use one version
to add the new field and another to remove.

<!-- more -->

You have a database with a lot of customers and their ID is numerical. But for
some reason, they now need to be strings. Instead of changing the field type
and doing a whole migration, make a deploy with a new field, in which you'll
keep the old _and_ the new format going on and, in the next release, remove
the old field. No downtime. You can even run the migration while the system is
up, since the new field won't be used.

(I'm simplifying the problem a lot here, 'cause the customer would have
references all around your system, but you get the point, right?)

I had a problem in which we store the link for an object directly in the
backend (we shouldn't, that's a frontend problem, but that's a discussion for
another time); our interface is changing and so should the link. If we did a
change in the link directly, that would mean the backend would have to be
deployed _at the same time_ as the new interface; by adding the new link
format in another field, we can deploy the backend easily without breaking the
current system.

{{ chapters(prev_chapter_link="/books/things-i-learnt/transparent", prev_chapter_title="Be Transparent With The User", next_chapter_link="/books/things-i-learnt/monitoring", next_chapter_title="Learn To Monitor") }}
