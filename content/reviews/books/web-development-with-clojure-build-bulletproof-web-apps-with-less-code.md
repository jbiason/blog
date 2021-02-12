+++
title = "Web Development with Clojure: Build Bulletproof Web Apps with Less Code - Dmitri Sotnikov"
date = 2017-06-22
updated = 2021-02-12

[taxonomies]
tags = ["books", "dmitri sotnikov", "reviews", "clojure", "web development",
"it", "stars:2", "published:2013"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/18399028-web-development-with-clojure):
Modern web development needs modern tools. Web Development With Clojure shows
you how to apply Clojure programming fundamentals to build real-world
solutions. You'll develop all the pieces of a full web application in this
powerful language. If you already have some familiarity with Clojure, you'll
learn how to put it to serious practical use. If you're new to the language,
the book provides just enough Clojure to get down to business.

<!-- more -->

{{ stars(stars=2) }}

First of all, this book suffers from the same mistakes every single Lisp-like
language book I've read: They throw a truck at you, then slowly, while you're
being crushed by it, explain each part that creates a truck -- In other words,
they throw a large piece of code at you and then slowly explain each part of
it.

Even worst, in the last parts, it's basically "here is truck, take it" -- very
little explanation about the code itself, just "we'll do this" and code. What
the pieces of code mean, that's entirely to you.

Another problem: no tests. The author prefers the REPL approach, which is okay
for little projects, but for projects that should last longer than a weekend
project. No only that, but even the tests are wrong, because it mocks the
database -- Database is part of your project so it **should** be tested along
all the other tests.

And, on top of that, there is a REST server with sessions, and a lot of code
just to keep the frontend session in sync with the server session. That's
actually **not** how a REST server works.

And while I usually don't comment the technology behind the book (because it's
not the author's creation), I really have to ask if Clojure is the right tool
for web servers. I mean, a lot about Clojure is about immutability and a lot
about the shown code is forcing mutability -- one function even is composed
with nothing but functions that force mutability.

So, not only the book itself doesn't give a clear picture about web
development in Clojure, the language itself doesn't appear appropriate for
such task.
