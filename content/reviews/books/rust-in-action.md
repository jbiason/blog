+++
title = "Rust In Action - T.S. McNamara"
date = 2020-04-28

[taxonomies]
tags = ["books", "reviews", "rust", "t s mcnamara", "4 stars", 
"2020 challenge"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/45731908-rust-in-action):
Rust in Action introduces the Rust programming language by exploring numerous
systems programming concepts and techniques. You'll be learning Rust by delving
into how computers work under the hood. You'll find yourself playing with
persistent storage, memory, networking and even tinkering with CPU
instructions. The book takes you through using Rust to extend other
applications and teaches you tricks to write blindingly fast code. You'll also
discover parallel and concurrent programming. Filled to the brim with
real-life use-cases and scenarios, you'll go beyond the Rust syntax and see
what Rust has to offer in real-world use cases.

<!-- more -->

{{ stars(stars=4) }}

{% note() %}
The version of this book I got is not the final version, it's part of
Manning Early Access Program, which allows people to read and participate in
"constructing" a book. A lot of things may change in the final version, so be
aware of this.
{% end %}

I have to say, I don't buy the "introduces the Rust programming language" part
of the description. A few points seem related to people that already have some
knowledge about the language, and jumping straight to some non-trivial problem
appears to skip a few "introduction" points, in my opinion.

One have to ask what "in Action" means. Sure, you'll write your one RFC
754 for dealing with floating points, so you can understand why some floating
values get to 6.000000000001, and while you won't ever write your own floating
point processor, you have to ask yourself: What is being explained about Rust
here? Sometimes, the problems feel more like "I want to solve this" than "I
want to explain this feature of the language", while it should be the other
way around.

Another confusing point: The output of a program appears before its code.
While not that weird, you end up with some sections showing the output,
explaining a bit and then, way later, you get the code what actually produces
that output. I remember reading a bit about the output and some discussion
about it and I got really confused about what was producing that output.

The Rust part seems a bit out-of-date, too. There are some `extern crate`,
which is optional at this point. Updating the code to reflect the latest
version of the language (the syntax, that is) would be better.

On the other hand, I have to give the author the props for managing to explain
things _really well_. Why you should use something, how can you apply
different things to the same data and so on. That's the book greatest
strength.

So, is it a bad book? Not at all. It has some quirks, but overall is well
explained and, if you keep an eye on the language from outside, it answers a
lot of stuff that you won't figure out anywhere else.
