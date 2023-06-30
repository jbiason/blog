+++
title = "Everything Everywhere At Once In Software Development"
date = 2023-06-30
draft = true

[taxonomies]
tags = ["software development"]
+++

A lot of stuff we learn (and some things we don't learn, specially at Uni) is
told in a vaccuum, in which only it exists. But there is a lot of things that
are connected (or, at least, they should).

<!-- more -->

Let's start with...

## TDD

Test-Driven Development, or just TDD for short, is the idea of building the
tests before you build the code. Sure, that means the test fails, then you add
the code, and the test finally passes. This flow is described as
"red-refactor-green" in the TDD lingo.

But what you need to test? Well, if you follow the language used in TDD, you
write the test **and then** refactor. This means you need to find out what the
code needs to do, write a test that replicates the behavior you want and then
write the code.

{% note() %}
**The internet hates me**: One general description of TDD you may find in the
internet is that you should write a test for every function/class in your
project. I've told those that you shouldn't make it an one-to-one when writing
tests like this, and I've been laughed at for that.

Just a warning that you may find other explanations for what TDD is and it
won't say exactly like that.
{% end %}

But where those behaviors come from? That's when we have to talk about...

## Agile

Agile is a set of project management methodologies in which you start with
small pieces, deliver them, and then gather more information. This process
assures that you're moving in the right way, letting the ideas settle instead
of having just concepts and hoping they are right the project reaches its end
and it is delivered.

{% note() %}
**The internet hates me**: If you look for agile on the internet, you may find
a series of posts saying that "agile sucks" or something like that. So far, all
the things I've read seem to follow the agile book line-by-line instead of
understanding *why* things are that way.

Also, the behavior descriptions can come from other project management
methologies, like Cascade, in which you have the whole project specified and
described way before any piece of code is written -- which have its own issues.
{% end %}

Besides gathering information at each step, there is a discussion about the
"Definition Of Done", on when a feature is complted: Is it when the developer
finishes writing the code? Is it when the testers say it is ok? Or is it when
the client says it fits their needs, 'cause the issue could be the information
gathering way before it reached the developer?

The point of "was it right before reaching the developer" have a definition
that is mostly forgotten: It should pass the "Definition Of Ready", which, as
with Definition of Done, tries to describe when something is good to be
developed, like "Do we have the proper definition?", "Does it have an example
of what is the expected behavior?", "Do we have the error
conditions/constrains?" and so on.

If a task passes the "Definition of Ready", then the developer have the
expected behavior from the system, which brings us back to...

## TDD
