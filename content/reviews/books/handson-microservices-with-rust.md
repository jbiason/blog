+++
title = "Hands-On Microservices with Rust - Denis Kolodin"
date = 2019-03-03

[taxonomies]
tags = ["reviews", "books", "en-au", "rust", "microservices", "denis kolodin"]
+++

<!-- more -->

{{ stars(stars=2) }}

The shortest and simpler way to describe this book is this:
```rust
let mut a = 1;
a = a + 1;
// increase a
```

Sure, increasing `a` may seem interesting, but where the heck is the
explanation on why you're increasing a?

The long version is this: this is an exact representation of what a Packt book
is. There are a bunch of grammatical errors from the half of the book to the
end, which should've picked by the editor; there are a bunch of weird
explanations and the incredible tendency of use a different package on each
project (one project uses Hyper, the other Rocket, the other Actix-Web) which
should've been picked by the reviewer; the whole book have a bunch of what the
code is doing, but not why it was designed that way.

So the whole thing feels rushed and without thought.

The "change package on each discussion" is also damming: you never really got
deep into a package, understanding its ins and outs, because it keeps changing
all the time (logs is another thing that keeps changing all the time in the
code, which seems really weird when you want to have a fleet of microservices
-- why would you use different packages on all of them; yes, you can do this
due the nature of microservices, but does it make sense?).

Also, no code is shown in completion. The book uses snippets all around instead
of showing everything. The full code is available on Github, but that means you
need to keep two sources open at the same time: one in the book, to follow
whatever the author is showing and the source code to understand where each
thing fall in the big picture.

Those two last points could be easily solved by starting with a simple code
(say, the Hyper that says "Hello world") and then, slowly, refactor it to reach
a fully asynchronous code, showing the full code with each refactor
highlighted.

Maybe this will be a good book in the 3rd edition.
