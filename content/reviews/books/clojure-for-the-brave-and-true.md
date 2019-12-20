+++
title = "Clojure for the Brave and True - Daniel Higginbotham"
date = 2017-04-09

[taxonomies]
tags = ["books", "daniel higginbotham", "clojure", "reviews", "it"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/20873338-clojure-for-the-brave-and-true):
As a Lisp-style functional programming language, Clojure lets you write robust
and elegant code, and because it runs on the Java Virtual Machine, you can
take advantage of the vast Java ecosystem. Clojure for the Brave and True
offers a "dessert-first" approach: you'll start playing with real programs
immediately, as you steadily acclimate to the abstract but powerful features
of Lisp and functional programming. Inside you'll find an offbeat, practical
guide to Clojure, filled with quirky sample programs that catch cheese thieves
and track glittery vampires.

<!-- more -->

{{ stars(stars=3) }}

There must be something wrong with Lisp (and Lisp-like) people that when they
write about their language, they show the code first, then explain what they
wrote -- which is kinda weird, because you read code that you barely
understand what it is doing at first, then they explain and you have to go
back and read it again to finally "click" it. And, sometimes, they forget what
code they just wrote and you're left with commands that you have no idea what
they do.

There is also a weird sense of humor, which I believe it could be fun if you
watch whatever TV series the author uses as reference. For someone that
doesn't follow and doesn't know what he's talking about, it's just... weird --
and not fun at all. Fortunately, the "humor" tones down to the end, which
makes more "pleasant" to read.

While it covers a lot of ground in the book, some pieces really fall short in
their examples. Threading and process fall short due the use of
<tt>sleep</tt>, which is not something you'd normally write; the last
appendix, about a tool called "Boot" tries to explain some concepts about
tasks and middlewares with things that are not tasks and do not reflect the
real world. Lacking this connection to real use of a tool just make things
harder to udnerstand -- and even harder to see *where* you'd use it.

It's not the worst book about a Lisp-like language I've read -- and heck, it
does a good job *selling* the language, to the point I'm already thinking
about writing something in it -- but damn if these problems don't appear in
every single one of those.
