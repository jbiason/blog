+++
title = "Things I Learnt The Hard Way - If A Function Description Includes An \"And\", It's Wrong"
date = 2019-06-23

[taxonomies]
tags = ["en-au", "books", "things i learnt", "documentation", "single responsibility"]
+++

Functions should do one thing and one thing only. I clear indication that
you're breaking this principle is the need to add an "and" in its
documentation.

<!-- more -->

This is kind like "sometimes rule", but most of the time, when you feel you
need to add and "and" to the function documentation (it's
[contract](/books/things-i-learnt/document-is-contract)), then you're telling
that that function is doing two (or more things).

One of guiding principles of good code is the [Single responsibility
principle](https://en.wikipedia.org/wiki/Single_responsibility_principle), in
which each module/class/function should do one thing and one thing only. And,
again, if you're saying that a function is doing "this" _and_ "that", you can
be sure it's not doing just _one_ thing.

Ok, but what now? Well, you have two functions, with two distinct contracts.
Ok, but you _had_ those two being called, what happens now? Well, where you
called one, you now will need to call two. If your preferred language have
support for function composition, you can use that to group both functions
again.

{{ chapters(prev_chapter_link="/books/things-i-learnt/document-is-contract", prev_chapter_title="The Function Documentation Is Its Contract", next_chapter_link="/books/things-i-learnt/throw-away", next_chapter_title="Be Ready To Throw Your Code Away") }}
