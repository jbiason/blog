+++
title = "Things I Learnt The Hard Way - Gerrit Is A Mistake"
date = 2019-07-29

[taxonomies]
tags = ["books", "things i learnt", "git", "gerrit", "source control"]
+++

I hate calling software "a mistake", but I can't find any other way to
describe Gerrit. You may see people using Gerrit 'cause Google uses it. The
thing is: Google misunderstood what Git actually is.

<!-- more -->

When Linus Torvalds came with Git, he was trying to mimic another system,
BitKeeper. Along with some improvements over CVS and SubVersion, Git made
really easy to create and merge branches, something that was either
almost-not-supported or slow-as-heck, depending on which tool you look at.

You need to take this into consideration: Git made branches easy.

Then someone came with the idea of Gerrit: Instead of managing branches, it
actually manages _commits_. Instead of having a branch for each feature, you
should have _one single commit_ as feature. You can have branches on your
machine, but the server only deal with commits.

So Gerrit took Git, a tool that improved the way we deal with branches, and
removed branches. This is akin to taking a text editor and taking away the
ability to _edit text_. Does that sound right to you?

In my personal opinion, what they did was to take git apart and put an err in
the middle: gERRit.

When I see someone using Gerrit, I know something is wrong there.

{{ chapters(prev_chapter_link="/books/things-i-learnt/one-change-commit", prev_chapter_title="One Commit Per Change", next_chapter_link="/books/things-i-learnt/git-flow", next_chapter_title="Git-Flow Is The Way To Go") }}
