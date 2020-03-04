+++
title = "Functional Reactive Programming -  Stephen Blackheath, Anthony Jones"
date = 2020-03-04

[taxonomies]
tags = ["books", "reviews", "stephen blackheath", "it", "anthony jones"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/24671986-functional-reactive-programming)
Functional Reactive Programming teaches the concepts and applications of FRP.
It begins with a careful walk-through of the FRP core operations and
introduces the concepts and techniques you'll need to use FRP in any language.
Following easy-to-understand examples, you'll learn both how to use FRP in
greenfield applications and how to refactor existing applications. Along the
way, the book introduces the basics of functional programming in a
just-in-time style, so you never learn anything before you need to use it.
When you're finished, you'll be able to use FRP to spend more time adding
features and less time fixing problems.

<!-- more -->

{{ stars(stars=0) }}

* (-) Some phrase constructions are a bit hard to read. Maybe it's because I'm
	not a native English speaker, but some phrases are akin to "my beautiful
	nature photos", which you can read in different ways ("my beautiful
	photos of nature", "my photos of beautiful nature") and I had to backtrack
	and read the whole thing again.
* (-) Code is a mess. Long listings with no separation of concerns. I mean,
	ok, you can use lambdas for simpler functions, but when you keep piling
	lambdas over lambdas, things get a bit out of hand. Trying to explain
	some functionality in a 200 line function is not actually helpful.
* (-) The ePub version seriously need another check. Some code listings are
	pure text, so it follows the user font size; but other are
	screenshots/images of code, which get way out of hand, as some listings
	had fonts that where 1/5 of the font I use to read (yes, I use a large
	font, I'm reading at night without my glasses, but the point remains).
* (--) There is very little explanation on what FRP really is, but a lot about
	how to do things with Sodium, the authors library. Instead of focusing on
	how to build your own FRP system, using Sodium as reference, the books
	focuses _a lot_ in using Sodium and why that implementation is FRP instead
	of explaining the concept behind the FRP functionality itself.
* (--) The authors shows some weird prejudices against TDD. For example, they
	say that FRP doesn't require TDD and that using TDD is actually _harmful_
	for FRP, "unless you test logic". I mean, seriously? What do you think TDD
	is about? Lines of code? TDD says that "tests should validate behaviors,
	not implementation" and I'm wondering why the authors are so reticent
	against TDD when their concept of TDD seems completely out of place.
* (---) There is a strong gatekeeping in the book. While talking about other
	frameworks, the authors, they decide to focus more on "why this framework
	is not pure FRP, while Sodium is" instead of, again, focusing on the
	concepts of FRP itself. "FRP says so and so, you can build this with
	framework X using that and that" is a good way to do it; "FRP says so and
	so, framework X do this which is not what the FRP says, so framework X is
	not FRP, but Sodium is!" is a dickish way to downplay other frameworks.
	Also, it's weird that every time Sodium breaks some FRP rule (rules that
	the authors themselves keep listing), they put a long explanation on why
	it's ok to break the rule there, saying that it's ok that Sodium breaks
	it.

Honestly, I read the book and I still don't understand FRP; all I got was some
concepts for a Sodium framework.
