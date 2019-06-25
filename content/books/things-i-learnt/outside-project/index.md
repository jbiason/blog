+++
title = "Things I Learnt The Hard Way - Don't Mess With Things Outside Your Project"
date = 2019-06-25

[taxonomies]
tags = ["en-au", "books", "things i learnt", "frameworks"]
+++

Simple rule: Is the code yours or from your team? Good, go break it. Does it
come from outside? DON'T. TOUCH. IT.

<!-- more -->

Sometimes people are tempted to, instead of using the proper extension tools,
change external libraries/frameworks -- for example, making changes directly
into WordPress or Django. Believe me, I've seen my fair share of this kind of
stuff going around.

This is an easy way to make the project -- the team project, that is --
a huge security problem.  As soon as a new version is released, you'll -- or,
better yet, someone who was not the person who decided to mess with outside
code -- have to keep up your changes in sync with the main project and, pretty
soon, you'll find that the changes don't apply anymore and you'll leave the
external project in an old version, full of security bugs.

Not only you'd end up with something that may very soon put at risk your whole
infrastructure, you won't take any benefits from things in the new versions,
'cause hey, you're stuck in the broken version!

Sometimes doing it so is faster and cheaper, and if you would do the same
thing using extensions or actually coding around the problem, even duplicating
the framework functions, would probably take longer and make you write more
code, but in the long run, it's worth the time.

{{ chapters(prev_chapter_link="/books/things-i-learnt/use-structures", prev_chapter_title="If Your Data Has a Schema, Use a Structure", next_chapter_link="/books/things-i-learnt/languages-are-more", next_chapter_title="A Language Is Much More Than A Language") }}
