+++
title = "Learning Concurrency in Python - Elliot Forbes"
date = 2021-12-13

[taxonomies]
tags = ["books", "reviews", "books:2021", "stars:1", "python", "concurrency"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/36083578-learning-concurrency-in-python):
Practically and deeply understand concurrency in Python to write efficient
programs.

<!-- more -->

{{ stars(stars=1) }}

A good book if you want examples of code in some concurrency topics -- and some
that don't -- but nothing that could actually *teach* you how to use this.

For example, there are consecutive examples of things that only change one
option. It tells what the option says it does but doesn't example *what* it
actually does and *when* you should use it. The whole *when* is missing from the
book: Here is the options, here are examples for each option, have fun.

Also, as usual for Packt books, editing would require some work. For example,
you're following with examples using `.join()` but it is not initially explained
why you need to do that -- only a few sections later that you find out it "waits
for the completion of threads/processes", with no mention that the call blocks
the current thread.

And, on top of that, none of the examples (ok, maybe two) actually follow
PEP8. It is a pet peeve of mine, I reckon, but when you're explaining some
language feature, I'd expect the examples to follow the code style of the
language (although it is not that bad 'cause at least there is a consistent
style through the book, even if it is not PEP8).

Suddenly, I have a feeling that the book is actually the notes of the author
while learning something, not something that they want to help you learn...
