+++
title = "Things I Learnt The Hard Way - Be Transparent With The User"
date = 2019-07-31

[taxonomies]
tags = ["books", "things i learnt", "ux", "ui"]
+++

Since we are talking about [logging](/books/things-i-learnt/log-events),
another thing you must do is to be transparent with the user in your user
interface.

<!-- more -->

And by "be transparent", I meant that your website/mobile app needs to point
out to the user that the webserver is down instead of saying to the user to
check their internet connection; your application _is_ getting something from
the webserver, so you _can_ say "Oops, something wrong on our side".

Another example: If you need to check a bunch of data before saying "It's
done", add a counter to show the user that the application is doing something.
[Joplin](https://joplinapp.org/), when syncing data with a webdav server,
needs to check a bunch of files; one version would simply sit still with a
spinner on "Syncing" and nothing more; when they added a counter, I could
easily see that there was something going on.

Those small details, for as bad as they may make you look, will win points
with the user in the long run.

{{ chapters(prev_chapter_link="/books/things-i-learnt/log-events", prev_chapter_title="Logs Are For Events, Not User Interface", next_chapter_link="/books/things-i-learnt/add-then-remove", next_chapter_title="One Version To Add, One Version To Remove") }}
