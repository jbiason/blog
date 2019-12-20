+++
title = "Things I Learnt The Hard Way - Don't Mess With Things Outside Your Project"
date = 2019-06-25

[taxonomies]
tags = ["books", "things i learnt", "frameworks"]
+++

Simple rule: Is the code yours or from your team? Good, you can make any
changes you want. Does it come from outside? DON'T. TOUCH. IT.

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

Sometimes the change you need is impossible 'cause the framework you're using
doesn't have any support for extensions. This is the time you'll need to build
a new layer _on top_ of the framework. Again, this may seem painful and
changing the framework directly is a lot easier, but you'll have to keep
updating your patch for newer versions, which may not be that easy. Building
on top of the framework will at least give you some assurance 'cause the
exposed API must be way more stable than the internal code.

{{ chapters(prev_chapter_link="/books/things-i-learnt/use-structures", prev_chapter_title="If Your Data Has a Schema, Use a Structure", next_chapter_link="/books/things-i-learnt/resist-easy", next_chapter_title="Resist The Temptation Of Easy") }}
