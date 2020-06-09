+++
title = "Python Losing the 2nd Place on Loved Languages: A Thought"
date = 2020-06-08

[taxonomies]
tags = ["python", "typescript", "stackoverflow", "survey"]
+++

On this year StackOverflow Survey, Python lost its 2nd place to TypeScript. On
our Python group, people started wondering why that. And I just thought it
would be nice to post my thoughts on the situation.

<!-- more -->

Before anything, I may have do make a disclaimer saying that I do love Python,
and I think it is a great language 'cause it is very concise but also very
expressive. I don't think any other language get close to Python in doing
those points so well.

Disclaimer done, let me explain why I think Python lost its second place in
the hearts of developers.

## Types

One of the first thoughts one can think when we talk about "losing a
position" in any rank is "because it got worse". But I really don't think this
is what happened here, and what actually happened is that TypeScript shown
developers something better.

TypeScript is aimed to JavaScript development, a zone where anything goes,
types are very flexible and magical -- to the point what most of things
actually produce a [Wat](https://www.destroyallsoftware.com/talks/wat). By
using types, making sure you're not adding a string to an array, a lot of
problems suddenly disappear. It is no silver bullet, but it fixes a whole
class of issues that would popup in production.

So, in an environment that chaotic things happen, suddenly you have something
that puts order back and you gotta love it for that. Surely, it's not just
types that make TypeScript more loved than JavaScript, but it is partially
why.

(Just to add to this point: Rust is still the most loved language 5 years in a
row, and it uses some pretty strong typing, close do Haskell, with added
syntax closer to what most languages use.)

I still believe that, in the long run, type hinting can fill the gap for
Python to reach the proper position. I'd love to use it to add hinting in all
functions and then have something that I could set the level of checking on
different environments: make the application crash if the function was called
with the wrong types on development environment; just log (logging or stderr)
on staging; and do absolutely nothing on production. That would allow me to
use the best of both worlds: Dynamic when developing, but static when testing.

## Python 2 is dead

One of the things that happened to Python in the beginning of this year, when
the survey was done, was that Python 2 became unsupported. Surely, that
doesn't mean any Python 2 installation would stop working, but it gave an
extra jump to porting things to Python 3.

And, even with all the backporting and improvements in Python 3, it was not a
smooth sail. That change, that forced change, may have let some Python devs
with some bitter taste about the language. No one wants to just fix changes in
the language, when the way things work must still work, quirks and all.

## Hype

Python is not a hyped language anymore.

Sure, it is still a reference for machine learning and related fields, but the
once thriving environment of web dev was taking by the hype of other
languages.

Python is not the hot stuff on web dev anymore. And because it is not the hot
stuff, people don't _want_ the old stuff; the old stuff is not cool anymore,
so they don't like it anymore.

## Side-point

One point not raised by anyone in the group: Although Python lost its second
place, it is still the most wanted language -- meaning, it is the language
most developers _want_ to learn. If the general feeling was "Python sucks!", I
pretty much doubt the want would still be representative -- and Python have a
large lead compared to JavaScript.
