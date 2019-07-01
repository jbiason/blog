+++
title = "Things I Learnt The Hard Way - Always Use Timezones With Your Dates"
date = 2019-07-01

[taxonomies]
tags = ["en-au", "books", "things i learnt", "dates", "timezones"]
+++

No matter if the date you're receiving is in your local timezone and you'll
display it in your timezone. Sooner or later, the fact that you ignored there
was a timezone behind that date will hurt you.

<!-- more -->

(Note: Most of this post when I say "date" you can think of "date and time",
although the date should also be timezone aware.)

At some point of my professional life, ignoring timezones was easy: You just
pick the date, throw in the database, then read it back and everybody was
happy.

But things are not like this anymore. People will access your site from far
away locations, the source of the date may not be in the same timezone of your
system, your system may be running in a completely different timezone of your
dev machine (it's pretty common to run things in our machines in the local
timezone but the production system will run in UTC), the display may be a
complete different timezone than your production and dev machine and so on.

So always carry the timezone with the data. Find modules/classes that support
dates with timezones (a.k.a. make things _timezone aware_), capture the
timezone as soon as possible and carry it around in all operations.
Modules/classes that don't support timezones for dates/times should, as soon
as possible, removed from the system.

Developers a bit more seasoned -- and by "seasoned" I meant "Had to deal with
times before" -- will probably claim "Hey, this is _obvious_!" And I'd have to
agree. But it's annoying how many times I got bitten by some stupid bug 'cause
we decided that "well, everything is in the same timezone, so it's all good".

{{ chapters(prev_chapter_link="/books/things-i-learnt/resist-easy", prev_chapter_title="Resist The Temptation Of Easy", next_chapter_link="/books/things-i-learnt/utf-utf8", next_chapter_title="Always Use UTF-8 For Your Strings") }}
