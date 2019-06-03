+++
title = "Don't Diminish Types"
date = 2019-06-03
categories = "code"

[taxonomies]
tags = ["programming languages", "dynamic types", "types", "en-au"]
+++

In a previous life, I had a long discussion on why adding booleans was a bad
idea. And just recently one of the core Python developers suggested the same
thing -- adding booleans, that is. This is a long rant on why such things are
bad.

<!-- more -->

Once at some previous job, I blocked a code review in which the other developer
did something like 

```python
if boolean1 + boolean2:
	do_thing()
```

Why this was bad, in my view? 'Cause it was reducing the booleans into simple
integers. While it is true that booleans are, internally, in Python, integers,
what they _represent_ is not integers, but actually true or false. People got
it -- or, at least, they say they got it, but the code changed, anyway -- and
live moved on.

But, last month, I had to see Raymond Hettinger, one of the core Python
developers, post 
[this on twitter](https://twitter.com/raymondh/status/1123950707273551878):

> #python tip:  The boolean values False and True are equal to zero and one.
>
> Replace:
>     sum(1 for x in data if pred(x))
>
> with:
>     sum(pred(x))

Obviosly, what he meant was to use

```python
sum(pred(x) for x in my_list)
```

... instead of

```python
sum(1 if pref(x) else 0 for x in my_list)
```

Again, basing on the fact that Python uses integers behind the scenes to deal
with booleans.

And, as you can guess, that really annoyed me.

## What Are Types

Let me explain, in a long rant, why "booleans are integers" is bad.

Imagine the computer memory. Imagine one specific memory location, being used,
with this value:

> 65

What does it mean? That's where languages and their types come in.

For example, let's imagine that this location is being managed by a C program
and the program and this program marked this value as a `char`. While `char`s
in C represent 8 bit integers[^1], they have being for a long time used to
represent one character in a string -- a sequence of `char`s actually
represents a string[^2]. So, when other developers see `char`, they think "Ok,
this is the character with code 65" (which is "A", by the way).

If the same code use `int`, other developers would think "Yeah, this is the
_number_ 65".

And, just to screw things up, it could be an `enum`, in which the value
represents the 65th variant (element) of that enum.

And that's the reason types exist: -- instead of, say, developers managing
memory directly and just changing their representation, like in Assembly --
they provide consistent representation over the internal storage.

## The Problem With Adding Booleans

So, we saw that memory is just a bunch of bytes and what gives meaning for
those bytes -- in programming languages, that is -- are types[^3].

Now let's see another developer seeing the code above; they go from the top of
the code to the bottom, and reach the line of `sum(pred(x) for x in my_list`.
The first thought they come is that `sum` acts on numbers, so obviously `pred`
is a function that return numbers. But what number it represents? So they go
check `pref` and see it returning `True` or `False`. Now they have to trace
back and rethink what the line did, leaving them with [cognitive
dissonance](https://en.wikipedia.org/wiki/Cognitive_dissonance), which is a
clever way of saying "they have to rethink what they already though".

And too many situations with cognitive dissonance is what makes code
"unreadable" -- the line above is still readable, but it doesn't actually
represent what it shows.

## Respect Your Types

Python is very loose with its type system[^4], but it doesn't mean one could
play "fast and furious" over it. Let's say that, at some point, Python
developers decide to change `True` and `False` from their integer roots to be
actually symbols -- things that simply "exist" and have no value[^5][^6]. Then
everyone that managed booleans as integers would see their code misbehaving or
crashing, simply because they didn't thread booleans _as booleans_.

Now let's see the other option: `sum(1 if pred(x) else 0 for x in my_list)`.
This line is (a) longer and (b) slower due the branching during execution (the
`if`). But when you read something like this you see that there is a function
where its value isn't being checked, which probably means it returns a
boolean[^7]; if it is true, returns 1; if it is false, returns 0; and you're
actually doing a sum of ones and zeroes -- as numbers.

No cognitive dissonance, no messing around and just because we treated types
as types.

---

Footnotes:


[^1]: They could use more than 8 bits, depending on the architecture, and due
  the fact that the C Standard is very flexible in this concept

[^2]: It doesn't mean that every single `char` is a character in a string, it
  could be used exactly as an 8 bit integer

[^3]: I'm being very lose here about types, there is a lot more complex
  context in them, but I'm going to stick with this "representation" for now.

[^4]: Maybe nose as loose as C, which lets you "convert" a memory that
  represents a float into a integer with no sign.

[^5]: Or, better yet, that can have _any_ value and would still work.

[^6]: As far as I know, Python standard already forced booleans to be
  integers, so that will never happen, but let's add this for the sake of
  discussion.

[^7]: This is one of times I feel jealous of Clojurist, which can use `?` in
  their functions and actually have a coding style that says that predicates
  -- functions that either return True or False -- end with `?`; so not only
  someone reading a piece of Clojure code seeing a `is_valid?` knows it
  returns a boolean, it actually _reads_ like a boolean check.
