+++
title = "Things I Learnt The Hard Way - The Magical Number Seven, Plus Or Minus Two"
date = 2019-06-26

[taxonomies]
tags = ["en-au", "books", "things i learnt", "complexity"]
+++

"[The magical number](https://en.wikipedia.org/wiki/The_Magical_Number_Seven,_Plus_or_Minus_Two)" 
is a psychology article about the number of things one can keep in their mind
at the same time.

<!-- more -->

I've seen twice this weird construction on where a function would do some
processing, but its return value was the return of a second function and
some bit of processing. Nothing major. But the second function would also do
some processing and call a third function. And the third function would call a
fourth. And the fourth a fifth. And the fifth, a sixth function.

Something like this

```
func_1
 +-- func_2
     +-- func_3
	     +-- func_4
		     +-- func_5
			     +-- func6
```

Now, when you're trying to understand this kind of code to find a problem,
you'll have to keep in mind what the first, second, third, fourth, fifth and
sixth functions do, 'cause they are all calling each other (inside them).

This causes some serious mental overflow that shouldn't be necessary.

Not only that, but imagine that you put a log before and after `func_1`: The
log before points the data that's being send to func_1, and the log after its
result.

So you'd end up with the impression that `func_1` does a lot of stuff, when it
actually is passing the transformation along.

(I got a weird experience with a function called `expand`, which logging
before the call would show some raw, compressed data, but the after was not
the expanded data, but actually a list of already processed data from the
compressed data.)

What would be a better solution, you may ask?

Well, if instead of making `func_1` call `func_2`, you can make it return the
result (which may not be the final result, anyway) and _then_ call `func_2`
with that result.

Something like:

```
result1 = func_1
result2 = func_2(result1)
result3 = func_3(result2)
result4 = func_4(result3)
result5 = func_5(result4)
result6 = func_6(result5)
result7 = func_7(result6)
```

Now you can see _exactly_ how the data is being transfomed -- and, obviously,
the functions would have better names, like `expand`, `break_lines`,
`name_fields` and so on, so you can see that that compressed data I mentioned
before is actually being decompressed, the content is being broke line by
line, the lines are getting names in its fields and so on (and one could even
claim that it would make things clear if there was a function after
`break_lines` which would just `break_fields`, which would make `name_fields`
more obvious -- and in a construction like this it would be almost trivial to
add this additional step).

"But that isn't performant!" someone may cry. Well, maybe it's just a bit less
performant than the original chained-calls ('cause it wouldn't create and
destroy frames in the stack, it would just pile them up and then unstack them
all in the end), but heck, optimization is for compilers, not people. Your job
is to make the code _readable_ and _understandable_. If you need performance,
you can think of a better sequence of steps, not some "let's make this a mess
to read" solution.

Just a quick note: Although the famous paper mentions that the number is
around 7, new research is actually pointing that the number is way lower than
that, at 4. So simply making `func_1` call `func_2`, which would call
`func_3`, which would call `func_4` may be enough to overload someone and make
them lose the track of what the code does.

{{ chapters(prev_chapter_link="/books/things-i-learnt/data-flow", prev_chapter_title="The Magic Number Seven, Plus Or Minus Two", next_chapter_link="/books/things-i-learnt/functional-programming", next_chapter_title="Learn The Basics of Functional Programming") }}
