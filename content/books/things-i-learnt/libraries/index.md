+++
title = "Things I Learnt The Hard Way - Create Libraries"
date = 2019-07-15

[taxonomies]
tags = ["en-au", "books", "things i learnt", "libraries", "project organization"]
+++

One thing you must learn is how to break your project into smaller libraries,
to avoid doing rounds to deal with "the same, but a bit different".

<!-- more -->

I've seen a lot of projects that use things like branches for different
things. Say, you have an e-commerce page. But you also have different clients,
and they all have different colours and logo. Some people would take this
scenario and, using the VCS properties, use the main branch for the main code
and a branch for each client, merge from main branch from time to time -- and,
thus, the branches are never merged back.

This is suboptimal, 'cause that's not how VCS are supposed to be used.

But you can, for example, break the main code into a library/framework and
have one project for each client, with their assets and you just reference the
library/framework in each.

Simple and clean.

But stop there for a second. Although this makes the code cleaner, avoids
duplication and uses a VCS in the way it was supposed to be used, you can't
start this way.

Remember that [future thinking is future
trashing](/books/things-i-learnt/future-trashing). What you can do is actually
break your project by functionality, [making modules related to their
data](/books/things-i-learnt/project-organization) and then, when you get a
reasonable number of clients, you'll notice what can be reused in each, what
modules make sense for one client and not for another. And then you'll have a
good way to deal with those.

One project that may appear when creating libraries is "How do I create my own
library repository?" 'Cause all modern languages today have support for
importing external libraries and, even if your libraries will never be out of
your control, they are external to the project. So you may need to learn how
to deal with this before creating the libraries. And, unfortunately, each
language and build tool has its own way to manage this.

{{ chapters(prev_chapter_link="/books/things-i-learnt/project-organization", prev_chapter_title="Organize Your Code by Data/Type, Not Functionality", next_chapter_link="/books/things-i-learnt/paper-notes", next_chapter_title="Paper Notes Are Actually Helpful") }}
