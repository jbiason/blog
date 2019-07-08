+++
title = "Things I Learnt The Hard Way - Shortcuts Are nice, But Only In The Short Run"
date = 2019-07-08

[taxonomies]
tags = ["en-au", "books", "things i learnt", "frameworks"]
+++

A lot of languages/libraries/frameworks add a way to make things shorter,
reducing the number of things you need to type.

But, later, that will bite you and you'll have to remove the shortcut and do
the long things.

<!-- more -->

Frameworks and libraries -- and even some languages -- come with "helpers" for
most boilerplate things. Instead of typing the same 5 lines of code over and
over, you can use a simple function; instead of writing the function with 5
parameters, you can skip a bit and use another one with just one. Or you could
just add a simple macro expansion on top of your struct/class and it would
complete all the missing points.

Don't get me wrong, they are great.

But you must understand what the macro/function is hiding from you. 'Cause
sooner or later, you'll find a case where it doesn't have a perfect fit and
you need to change just a small detail. And then you'll start running in
circles 'cause, well, how the hell the macro/function did _that_?

I've bitten before by [Spring](http://spring.io/) and
[Serde](https://serde.rs/) 'cause I started with the shortcuts without
understanding what they were doing. And then I got a problem which the
shortcut wouldn't solve, requiring me to go deep into the documentation. And
because I skipped a few steps and jumped straight into the shortcut, it took
me awhile to actually get _what_ I needed to do different from the shortcut to
solve my problem: I had no idea what the shortcut did and, thus, I had no idea
what I needed differently from the shortcut to solve my problem.

{{ chapters(prev_chapter_link="/books/things-i-learnt/functional-programming", prev_chapter_title="Learn The Basics of Functional Programming", next_chapter_link="/books/things-i-learnt/debuggers", next_chapter_title="Debuggers Are Overrated") }}
