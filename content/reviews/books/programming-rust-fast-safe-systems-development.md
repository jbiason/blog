+++
title = "Programming Rust: Fast, Safe Systems Development - Jim Blandy"
date = 2018-05-22
updated = 2021-02-12

[taxonomies]
tags = ["books", "jim blandy", "reviews", "it", "rust", "stars:4",
"published:2017"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/25550614-programming-rust):
Rust is a new systems programming language that combines the performance and
low-level control of C and C++ with memory safety and thread safety. Rust's
modern, flexible types ensure your program is free of null pointer
dereferences, double frees, dangling pointers, and similar bugs, all at
compile time, without runtime overhead. In multi-threaded code, Rust catches
data races at compile time, making concurrency much easier to use.

<!-- more -->

{{ stars(stars=4) }}

First off, this is not a book for *learning* Rust: This is a Reference Book. A
good one at it, but not for learning.

My inclination to learn Rust is how it deals with errors (it's `Result` enum),
something that most languages seem to drop out of context or accept some
"catch all" which let developers ignore such errors. Rust doesn't; you
<b>have</b> to deal with errors.

And, in such small thing, which I thought it was very simple and
straightforward... is not. The `Err` part can be very complex, specially if
you want to keep in line with the rest of the system. Which is good.

Although a good book, it's not great. The explanation for generics is very
convoluted and complex and doesn't help grasping the whole context -- maybe
it's easier if you're already working with a language that has generics. And
then, when you are almost getting how they work, they throw lifetimes in it
and the confusion grows. 

Several topics are started and then become "beyond the scope of this book". So
it just brushes some pointers at it and then completely forget about it. I,
personally, would drop some of those -- it could mention that they exist --
and expanding for not being "beyond the scope of this book".
