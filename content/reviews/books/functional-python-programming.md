+++
title = "Functional Python Programming - Create Succinct and Expressive Implementations with Python - Steven F. Lott"
date = 2020-08-27

[taxonomies]
tags = ["books", "review", "it", "steven f lott", "python", "functional", 
"1 star", "2020 challenge"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/24925633-functional-python-programming---create-succinct-and-expressive-implement):
With Functional Python Programming by your side you’ll understand the core
concepts of function Python, its impact on the programming workflow, and how
to implement it in Python, giving you the ability to take your applications to
an even higher level.

<!-- more -->

{{ stars(stars=1) }}

Another book the proves my theory that the quality of a book is inversely
proportional to the amount of "as follows".

But functional programming in Python is generators. 

That's it: Generators. Oh, generators and tuples.

There is a lot in this book, but mostly seems... wrong. For example, talking
about "tail call optimization", when Python does not have them. And then
talking how to optimize those -- which, again, it is plain "replace with a
generator".

Also, the case for tuples is that namedtuples is mentioned, but rarely used.
This makes code hard to read, except the author decided to create lambdas to
extract them, so you end up with a bunch of `xy_g = lambda p: p[0][1][0]`.
What the fuck is `0`, `1` and `0` again in this? Why not use name tuples and,
instead of this atrocity, go with `p.position.x`?

Other examples of wrong things:

- "extract the docstring function": Doctstrings are strings, not functions.
- "GNU Image Manipulation Program (GIMP) GNU General Public License (GPL) file
	format": Neither GIMP not GPL is a file format; one is a photo editor and
	the other is a license.
- "This is relatively simple implementation copied from the World Wide Web":
	And we all know how things on the web are reliant.
- "We can use `((line.split() for line in file)` to create a sequence of ten
	tuples": First of all, yes, the there is some unbalanced parenthesis
	there; second, that thing won't generate ten tuples, it will generate as
	many as the lines in the file -- which is never shown, by the way.
- Calling functions that return generators "higher-order functions". And no,
	the function does not receive a function, it simply returns a generator.
- "perms = permutations(range(6)))))". Yup, there are 4 extra closing
	parenthesis.
- Splitting a string with a path in it by `/`, then checking the first value
	instead of, say, `path.startswith('expected_value')`.
- "We've created a Counter() function": Counter is a class, not a function.
- Lots of "not clear if this is helpful". Ok, showing some sort of code is ok,
	but not explaining where if it is useful -- or if it is useful at all --
	is plain... lazy.
- "We've shown the loop here to clarify that the server must, generally, be
	crashed": It's the first time that I see that we expect a server to be
	crashed.
- There is a convoluted aggregation grouping things in a dictionary with a key
	and a count, and then using `Counter()` to check the number of times
	something appear. Problem is, when `Counter()` process the dict, it will
	get only the keys, so the whole process of generating the dictionary is
	completely useless.
- By the end of the book, I'm not sure if things are being double
	double-quoted (as in ""this is string"") or quadruple single-quote
	(''''this is string'''') -- but neither format is valid Python.

Besides all that, there is a bunch of explanations that are very much akin to

> `a = a + 1`
>
> Adds 1 to `a`

Also, there are chapters for multiprocessing, which has absolutely nothing
functional about it and WSGI, which, again, has nothing functional about it.

The whole book feels rushed and badly reviewed -- if reviewed before
publishing at all.
