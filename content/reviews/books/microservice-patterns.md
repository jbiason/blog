+++
title = "Microservice Patterns, Chris Richardson"
date = 2019-10-09

[taxonomies]
tags = ["books", "review", "microservices", "spring", "java"]
+++

[GoodReads summary](https://www.goodreads.com/book/show/34372564-microservice-patterns):
Microservice Patterns teaches enterprise developers and architects how to
build applications with the microservice architecture. Rather than simply
advocating for the use the microservice architecture, this clearly-written
guide takes a balanced, pragmatic approach. You'll discover that the
microservice architecture is not a silver bullet and has both benefits and
drawbacks. Along the way, you'll learn a pattern language that will enable you
to solve the issues that arise when using the microservice architecture. This
book also teaches you how to refactor a monolithic application to a
microservice architecture.

<!-- more -->

{{ stars(stars=1) }}

I have a rule: The "badness" of a book is directly proportional to the number
of "as follows" the author uses in it.

And, oh boy, do they use "as follows" in this book (no, seriously).

The first 1/4 of the book is pretty good, showing patterns and giving
explanations about it. The rest of the book is strongly focused on external
frameworks and libraries and has almost no patterns discussion at all -- for
example, the second 1/4 is, basically, focused on the author's framework -- a
Java framework. . Also, the author seems strongly focused on Java code, even
after explaining that a microservice fleet can be written in lots of different
languages -- even listing some languages.

There is a strong preference for Java and Spring on the book, to the point
that, when discussing a point, it shows a Spring module with a huge
explanation on what it does and another saying, simply, "another Java
framework".

The code examples are also bad. It seems the author decided to use IntelliJ as
IDE and use its variable-name-generator (based on the class name) to create
the variable names. Classes names are really long on Java and, using the IDE,
the variables names <i>also</i> get really long, which by itself is not bad,
but in a book, it means the code will get formatted like any text and, thus,
get completely broken, and really hard to read.

There are <i>lots</i> of images. And, as usual with a lot of images, 90% of
them are completely irrelevant, adding absolutely nothing of whatever was
described already.

Those failures are extremely upsetting. You're getting a book about patterns
and end up with lots of pages of discussion and code -- badly formatted code
-- and very little pattern. Instead of explaining each pattern in depth, the
author decided to skip the whole thing and just show you how to use some
framework that already implements the pattern. That, by itself, isn't bad, but
without understanding what the pattern is, and what it is good for, you won't
know if it is a good idea to use it or not -- because patterns are ways to
describe your solution, not "ready made" solutions.

Honestly, I can't recommend this book for anyone that is starting their way
into microservices.
