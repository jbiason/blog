+++
title = "Things I Learnt The Hard Way - Not Just Function Composition, But Application Composition"
date = 2019-07-15

[taxonomies]
tags = ["en-au", "books", "things i learnt", "composition", "applications"]
+++

When we were discussing [the magical number
seven](/books/things-i-learnt/magical-number-seven), I mentioned that it made
more sense to actually call the functions in sequence instead of each calling
the next. That's basically a "function composition", one thing you can also do
with your applications.

<!-- more -->

Unix came with the idea of "applications that do one thing and do it well".
And then you could just pick the output of one application and plug it as
input of another (and then plug the output of the second into a third, and so
on).

Also, I mentioned that you could use [configuration
files](/books/things-i-learnt/config-file) to do the same processing over
different source elements (based on a configuration, that is) instead of
writing an application that would process both in a single shot.

One problem with that approach is that you may need _both_ results to actually
produce a usable result (for example, how would you build a list of common
followings of two Twitter users if you don't have both lists?).

That problem can easily be solved if you write a different application that
just receives both lists and compare them. That would greatly simplify your
general codebase 'cause instead of one massive codebase with lots of moving
pieces, you'd have two small codebases, with less moving pieces. One could
still break the other -- say, if you or someone else changes the result of the
first function -- but you will still get the results of the first without
missing the whole 'cause the second is breaking.

PS: I reckon it's really hard to create application composition with graphical
applications (why would you ask your user to have _two_ applications open at
the same time to make something work?) but you can extrapolate this for almost
everything else.

{{ chapters(prev_chapter_link="/books/things-i-learnt/command-line-options", prev_chapter_title="Command Line Options Are Weird, But Helpful", next_chapter_link="/books/things-i-learnt/app-composition-stupid", next_chapter_title="Even for Application Composition, Start Stupid") }}
