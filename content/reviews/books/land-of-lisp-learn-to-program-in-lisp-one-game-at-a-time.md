+++
title = "Land of Lisp: Learn to Program in Lisp, One Game at a Time! - Conrad Barski"
date = 2017-03-16

[taxonomies]
tags = ["books", "conrad barski", "lisp", "reviews", "it"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/6905041-land-of-lisp):
Lisp is a uniquely powerful programming language that, despite its academic reputation, is actually very practical. Land of Lisp brings the language into the real world, teaching Lisp by showing readers how to write several complete Lisp-based games, including a text adventure, an evolution simulation, and a robot battle. While building these games, readers learn the core concepts of Lisp programming, such as data types, recursion, input/output, object-oriented programming, and macros. And thanks to the power of Lisp, the code is short. Rather than bogging things down with reference information that is easily found online, Land of Lisp focuses on using Lisp for real programming. The book is filled with the author Conrad Barski's famous Lisp cartoons, featuring the Lisp alien and other zany characters.


<!-- more -->

{{ stars(stars=3) }}

(Once again, ignoring the language itself to focus on the book).

Lisp is one hell of a language. Lots of things that are getting traction today
already exist in Lisp for a long time. And, still, Lisp is not a common
language. And this book shows why.

Just before reaching 1/4 of the book, there was a little piece of code that
had nothing less than six "close parenthesis" in it. Just to have an idea of
how bad it is, one of my friends that know Lisp inside and out rewrote the
same piece of code using two new functions and hell, it was a lot easier to
read -- simple because Lisp must be read from right to left, which most
written languages use the other way around and reducing the closing
parenthesis by moving pieces of code to other functions really does help.

The book also fails in a lot of places: There is the constant abuse of global
variables, which breaks the idea of functional programming, one of the pillars
of the language; the whole code focus on the REPL and nowhere it talks about
using an external editor and running the code, although in the very end a
magical "load" appears, out of the blue; there is some serious lack of
contextualization about concepts: things are simply thrown out and *then*
explained (there is a piece about minimax which the author simply explains the
code after showing it and, in the next chapter, he finally explains the
minimax concept, only to tell that the code could be "fixed" to follow it in
only 23 lines -- no shit, Sherlock, you wrote half of it without ever
explaining *why* you were writing it).

In the end, it's not a "oh so terrible" book, but it could really use some
editing help.
