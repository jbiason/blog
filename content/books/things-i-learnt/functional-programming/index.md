+++
title = "Things I Learnt The Hard Way - Learn The Basics of Functional Programming"
date = 2019-06-26

[taxonomies]
tags = ["en-au", "books", "things i learnt", "functional programming"]
+++

At this point, you should at least have hard about how cool functional
programming is. There are a lot of concepts here, but at least the very basic
ones you should keep in mind.

<!-- more -->

A lot of talks about functional programming come with weird words like
"functors" and "monads". It doesn't hurt to know what they really mean
(disclaimer: I still don't). But some other stuff coming from functional
programming is actually easy to understand and grasp.

For example, immutability. This means that all your data can't change once
it's created. You have a record with user information and the user changed
this password? No, do not change the password field, create a new user record
with the updated password and discard the old one. Sure, it creates a lot of
create and destroy sequences which makes absolutely no sense (why would you
allocate memory for a new user, copy everything from the old one to the new
one, update one field, and deallocate the memory from the old one? It makes no
sense!) but, in the long run, it would prevent weird results, specially when
you understand and start use threads.

(Basically, you're avoiding a shared state -- the memory -- between parts of
your code.)

Another useful concept is pure functions. Pure functions are functions that,
called with the same parameters, always return the same result, no matter how
many times you call them. One example of a _non_ pure function is `random()`:
each time you call `random()`, you get a different number[^1]. An example of a
pure function would be something like this in Python:

```python
def mult(x):
   return x * 4
```

No matter how many times you call `mult(2)`, it will always return 8. Another
example could be our immutable password change above: You could easily write a
function that receives a user record and returns a new user record with the
password changed. You could call with the same record over and over again and
it will always return the same resulting record.

Pure functions are useful 'cause they are, first most, easy to test.

Second, they are easy to chain, specially in a [data
flow](/books/things-i-learnt/data-flow) design: Because they don't have an
internal state (which is the real reason they are called pure functions), you
can easily call one after the other and no matter how many times you pass
things around, they still produce the same result. And because each function,
given the same input, produce the same result, chaining them all _also_
produces the same result given the same inputs.

Just those two concepts can make code longer (again, you're creating a new
user record instead of simply changing one field), but the final result is a
more robust code.

[^1]: Except in Haskell, but it does require sending the seed every time, so
  you end up with random values based on the seed, so even there it is a pure
  function.

{{ chapters(prev_chapter_link="/books/things-i-learnt/magical-number-seven", prev_chapter_title="The Magic Number Seven, Plus Or Minus Two", next_chapter_link="/books/things-i-learnt/integration-tests", next_chapter_title="Unit Tests Are Good, Integration Tests Are Gooder") }}
