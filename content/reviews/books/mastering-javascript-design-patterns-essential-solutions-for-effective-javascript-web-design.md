+++
title = "Mastering JavaScript Design Patterns - Essential Solutions for Effective JavaScript Web Design - Simon Timms"
date = 2016-03-12

category = "review"

[taxonomies]
tags = ["books", "en-au", "simon timms"]
+++
{{ stars(stars=2) }}

With a book named "Master JavaScript Design Patterns", I was expecting something about some JavaScript common patterns, like subscribing and generating events, proper way of transversing structures and such.

But nope.

The book starts with the classical design patterns from the Gang of Four, which doesn't seem so bad if the book was named "Learning Design Patterns with JavaScript", in a way to make learning the design patterns more streamlined for people who already know JavaScript. But, then again, things fall apart, with the Observer pattern being designed with a list of callbacks in a structured, instead of creating a real event -- something, again, really common in JavaScript.

Not only that, but some stuff seems really off. Like explaining lazy evaluation -- something only ES6 has -- with... lists. Yup, lazy evaluation, for the book, means adding things in a list only when you need to remove things from the list. It would make so much more sense if the author jumped into the ES6 bandwagon for this and explained the "yield" command... but no, he had to write some lazy text.

The fact that all examples are based on Game of Thrones -- with all being based on things that happen in Westeros -- don't make it funny or interesting. Worse, none of the examples are related, so the author just keeps jumping between weird scenarios to explain the "patterns".

Even when you throw the JavaScript away and decide to read it to learn some design patterns, you waste your time. Some designs, mostly the MV*, are hastily described and just superficially analyzed. 

It really starts a bit off -- again, if it was "Learning Design Patterns with JavaScript", it would be almost perfect -- and then goes downhill by some lazy writing and wrong assumptions.