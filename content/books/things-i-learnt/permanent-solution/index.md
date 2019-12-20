+++
title = "Things I Learnt The Hard Way - Nothing More Permanent Than A Temporary Solution"
date = 2019-07-29

[taxonomies]
tags = ["books", "things i learnt", "code", "writing code", "temporary solutions"]
+++

Depending on where you look, "Nothing more permanent than a temporary
solution" is either an old Russian proverb or a quote by Milton Friedman.
Thing is, temporary solutions, unless you think about the future to fix them,
will become permanent.

<!-- more -->

A temporary solution may appear either as a proof-of-concept or due some
restrained deadline. You may create perfect [system
specs](/books/things-i-learnt/spec-first), you may have a perfect
understanding of the whole [in your Gherkin
files](/books/things-i-learnt/gherkin) but, at some point, you'll put some
small script to fix a minor problem, or do a "not so good" solution to a point
due to deadlines.

This happens and unless you take steps to get rid of those, you'll end up with
a bunch of spaghetti code pretty fast. And that will snowball to a point that
you won't be able to manage the project.

Once a scrum master suggested that we came with an idea to our product manager
to do something akin to "Every three sprints, we'll focus on product value;
the fourth one is ours to fix the things that are annoying us". I don't think
we ever talking to the product manager about this, but we managed to open
issues on our ticket system about the small warts we left behind, specially
due deadlines. So there we had, a specially crafted bug type for "technical
debt" which we never actually took the time to fix.

Unless you have a pretty good safety net to fix those, they will life forever.
And it may be a better option to tell "we can't deliver in time" than adding
(yet another) temporary solution, as hard as it is to convince the higher ups
that you can't deliver the product with a temporary solution.

{{ chapters(prev_chapter_link="/books/things-i-learnt/run-locally", prev_chapter_title="If It Doesn't Run On Your Computer, You Have A Problem", next_chapter_link="/books/things-i-learnt/config-file", next_chapter_title="The Config File Is Friend") }}
