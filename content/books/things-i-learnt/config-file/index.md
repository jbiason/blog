+++
title = "Things I Learnt The Hard Way - The Config File Is Friend"
date = 2019-07-15

[taxonomies]
tags = ["en-au", "books", "things i learnt", "configuration", "config file"]
+++

Do not ignore the power of configuration files.

<!-- more -->

Imagine you wrote a function that you have to pass a value for it to start
processing (say, a twitter user account id). But then you have to do that with
two values and you just call the function again with the other value.

It makes more sense to use a config file and just run the application twice
with two different config files 'cause, this way, you have a single, small,
testable application instead of two, or a very complex application that does a
lot of stuff.

We can even jump into the idea of [creating
libraries](/books/things-i-learnt/libraries) and say that, instead of
splitting your e-commerce application into smaller parts and making a big one
by grouping these smaller parts, you could simply have one e-commerce
application and, for each of your clients, you would have a different
configuration file, pointing to different assets. This way, even the assets
may reside in the same repository in the same branch, 'cause all that
identifies which assets should be used are defined in the configuration file.

"But which one should I use?" you may ask. Well, "it depends". It may make
sense to have one single application with different configuration files if
most of its can be used all the time. If the intersection of used things is
very small, it may make more sense to split into different libraries and just
"pick and chose" what to use.

But besides the replacement of libraries, you can also think things like: "Ok,
I have to remove elements after a while[^1]; but which would be a good time
that they can exist before I can remove them?" Well, if you're not quite sure
(and, sometimes, even when you're sure), you can use a configuration file to
define how long those elements will stay in the system before being expunged.
Maybe you're not even thinking about how long each element will stay in the
system, but how many of those elements you'll keep in the system before
removing the old ones -- which is, again, a good candidate to be moved to a
configuration file.

Configuration files allow you to change properties of the system without
recompiling everything. And, if in the future you decide to follow the [12
Factor app](https://en.wikipedia.org/wiki/Twelve-Factor_App_methodology),
you'll find that you're half-way through it.

[^1]: In other words, they have a [time to
  live](https://en.wikipedia.org/wiki/Time_to_live).

{{ chapters(prev_chapter_link="/books/things-i-learnt/use-utf8", prev_chapter_title="Always Use UTF-8 For Your Strings", next_chapter_link="/books/things-i-learnt/log-events", next_chapter_title="Logs Are For Events, Not User Interface") }}
