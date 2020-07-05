+++
title = "Functional Reactive Programming -  Stephen Blackheath, Anthony Jones"
date = 2020-03-04

[taxonomies]
tags = ["books", "reviews", "stephen blackheath", "it", "anthony jones", 
"0 stars"]
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

* (-) Some phrases are a bit hard to read. Maybe it's because I'm
	not a native English speaker[^1], but some are akin to "my beautiful
	nature photos", which you can read in different ways ("my beautiful photos
	of nature", "my photos of beautiful nature") and I had to backtrack and
	read the whole thing again.
* (-) Code listings are a mess: long and with no separation of concerns. It is
    ok if you use lambdas for simpler functions, but when you keep piling
	lambdas over lambdas, things get a bit out of hand. Trying to explain some
	functionality in a 200 line function is not actually helpful.
* (-) The ePub version seriously need another check. Some code listings are
	pure text, following the font size the user set in their reader; other are
	screenshots/images of code, which get way out of hand, as some of those
	had a font 1/5 of the size I set up (yes, I use a large font, I'm reading
	at night without my glasses, but the point remains).
* (--) There is very little explanation on what FRP really is, but a lot about
	how to do things with Sodium, the authors' library. Instead of focusing on
	how to build your own FRP system, using Sodium as reference, the book
	focuses _a lot_ in using Sodium and its relationship with FRP instead
	of explaining the concept behind the FRP functionality itself.
* (--) The authors show some weird prejudices against TDD. For example, they
	say that FRP doesn't require TDD and that using TDD is actually _harmful_
	for FRP (!!![^2]), "unless you test logic" (???[^3]). I have to ask: Seriously?
	What do you think TDD is about? Lines of code? TDD says that "tests should
	validate behaviors, not implementation" and I'm wondering why the authors
	are so reticent against TDD when their concept of TDD seems completely out
	of place.
* (---) There is a strong gatekeeping in the book. While talking about other
	frameworks, the authors decided to focus more on "why this framework
	is not pure FRP, while Sodium is" instead of, again, focusing on the
	concepts of FRP itself. "FRP says so and so, you can build this with
	framework X using that and that" is a good way to do it; "FRP says so and
	so, framework X do this which is not what the FRP says, so framework X is
	not FRP, but Sodium is!" is a dickish way to downplay other frameworks.
	Not only that, but every time Sodium break some FRP rule (rules that
	the authors themselves keep listing), they put a long explanation on why
	it's ok for you to break the rule there when using Sodium, but Sodium,
	although requiring you to break some FRP rule, is actually a pure-FRP
	framework, and not those pesky other frameworks that are not pure-FRP
	frameworks.

Honestly, I read the book and I still don't understand FRP; all I got was some
concepts for a Sodium framework.

---

[^1]: ... which may appear as no surprise, with the amount of grammar mistakes
  in this post. :p
[^2]: That's surprise.
[^3]: That's confusion.
