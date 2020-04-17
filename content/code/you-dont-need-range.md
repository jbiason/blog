+++
title = "You Don't Need range()"
date = 2020-04-16

[taxonomies]
tags = ["code", "python", "range"]
+++

Beginners in Python tend to use `range()` for iterating over lists. This is
not really necessary.

<!-- more -->

When people start programming Python, they tend to use constructions coming
from other languages, so they iterate over a list with something like:

```python
a_list = [1, 2, 3, 4]
for i in range(len(a_list)):
    print(a_list[i])
```

But Python have the concept of "iterable", meaning some things can be iterated
over, without the need of accessing each element individually. For example,
our previous list can be iterated with:

```python
a_list = [1, 2, 3, 4]
for value in a_list:
    print(value)
```

"For every element in `a_list`, retrieve it and name it `value`."

A lot of elements are iterable: Strings are iterable, returning every
character in them; dictionaries are iterable, returning every key in them;
sets are iterable, returning every element in them; tuples are iterable,
returning every value in them; generators are iterable, return the next value
they can produce.

But what if you need to iterate over more than one iterable at the same time?

## Enters `zip()`

That's where `zip()` comes in. `zip()` allows you to merge iterables:

```python
a_list = [1, 2, 3, 4]
a_tuple = ('a', 'b', 'c', 'd')
for mixed_tuple in zip(a_list, a_tuple):
    print(mixed_tuple)
```

This code prints out:

```
(1, 'a')
(2, 'b')
(3, 'c')
(4, 'd')
```

What `zip()` does is create a tuple with the first element of the first
iterable and the first element of the second iterable; then the second element
of the first iterable and the second element of the second iterable; and so
on. You can put as many iterables as you want in `zip()` and it will just
create larger tuples for each interaction.

## Interlude: Destructuring

One of the cool things in Python is "destructuring". Destructuring
(de-structuring or more like "breaking apart a structure") allows one to
extract elements from a iterable directly.

For example, if you have a tuple with two elements:

```python
a_tuple = (1, 2)
```

... you'd probably take every element of it in separate variables with
something like

```python
a = a_tuple[0]
b = a_tuple[1]
```

But with destructuring, you can do this in a single pass with

```python
(a, b) = a_tuple
```

This code and the one above it will do exactly the same thing.

But why destructuring is important if we are talking about iterating over
elements? 'Cause `for` also has the destructuring capabilities:

```python
a_list = [1, 2, 3, 4]
a_tuple = ('b', 'c', 'd', 'f')
a_string = 'aeio'

for (a_number, lowercase_char, uppercase_char) in zip(a_list, a_tuple, a_string):
    print(a_number)
    print(lowercase_char)
    print(uppercase_char)
    print()
```

{% note() %}
Remember that I said that strings are also iterables and each iteration would
return a character? That's it.
{% end %}

But what happens when one of the iterables is smaller than the other one?

```python
a_short_list = [1, 2]
a_long_list [10, 20, 30, 40, 50, 60, 70, 80, 90]
for (small, big) in zip(a_short_list, a_long_list):
    print(small, big)
```

That will print

```
1 10
2 20
```

`zip()` stops when the shortest iterable have no more elements. To go as far
as the longest iterable, you need `itertools.zip_longest()`.

## `itertools.zip_longest()`

`zip_longest()`, part of the `itertools` module, will transverse the iterables
till every one of them have no more elements. What happens with the shortest
of those is that its value will be replaced with `None`. Using our previous
example:

```python
import itertools

a_short_list = [1, 2]
a_long_list [10, 20, 30, 40, 50, 60, 70, 80, 90]
for (small, big) in itertools.zip_longest(a_short_list, a_long_list):
    print(small, big)
```

That will print:

```
1 10
2 20
None 30
None 40
None 50
None 60
None 70
None 80
None 90
```

## Careful with generators

One thing you must be careful when using `zip()` and `zip_longest()` are
generators. Why?  Because some of them have no end.

Let's take one example: `cycle()`. `cycle()`, also part of the itertools
module, is a generator that, on request, returns the next element of an
iterable but, as soon as this iterable is over, it starts over. For example
(and I'm tacking `zip()` around this just for the sake of staying on topic,
and you don't need to use `zip()` with `cycle()`):

```python
a_list = [10, 20, 30, 40, 50, 60, 70, 80, 90]
for (bullet, value) in zip(cycle(['-', '*', '.']), a_list):
    print(bullet, value)
```

That will produce:

```
- 10
* 20
. 30
- 40
* 50
. 60
- 70
* 80
. 90
```

What happened here is that `zip()` took the first value of the first iterable,
our `cycle(['-', '*', '.'])`, which was the first value of its iterable,
`'-'`, and the second value of the second iterable, `10`; next iteration, the
second value of `cycle()` was `'*'` and the second value of `a_list` was `20`;
third iteration, `cycle()` returned `'.'` and `a_list` returned `30`; now, on
the fourth iteration, `cycle()` was asked for a value and, with its iterable
exhausted, it returned to the first value, returning `'-'` again.

Ok, cool?

So, what's the problem with generators?

Some generators -- like `cycle()` above -- do not have an end. If you replace
`zip()` with `zip_longest()` on the code above, you'll see that the code will
never stop. It's not every generator the can produce values continuously,
though, so you can mess with them with no issue.

{% note() %}
It's not `zip_longest()` that may have an issue. You can put two `cycle()`s in
a `zip()` and it will keep producing tuples with no end.
{% end %}

All nice and dandy, but what if I need to show the index itself?

## `enumerate()` to the rescue!

Ok, so we talked about mixing more than one iterable, but what if we need the
position? What if we have a list of ordered results and we need to show the
position itself?

Again, you may be temped to use `range()`:

```python
winners = ['first place', 'second place', 'third place', 'fourth place']
for pos in range(len(winners)):
    print(pos + 1, winners[pos].capitalize())
```

That will print:

```
1 First place
2 Second place
3 Third place
4 Fourth place
```

One may also try to be clever and mix our newly found knowledge about `zip()`
and do:

```python
winners = ['first place', 'second place', 'third place', 'fourth place']
for (pos, name) in zip(range(len(winners)), winners):
    print(pos + 1, name.capitalize())
```

... which ,personally, looks even more cumbersome than the first option. But
Python have another generator called `enumerate()` that takes one single
iterable, but produces tuples with the index of it and its value:

```python
winners = ['first place', 'second place', 'third place', 'fourth place']
for (pos, name) in enumerate(winners):
    print(pos + 1, name.capitalize())
```

Even better, `enumerate()` have an option to define with will be the value of
the first element, so instead of that `pos + 1` in the `print()` statement, we
can replace the enumerate to `enumerate(winners, start=1)` and remove the
addition in `print()`.

## Conclusion

Iterables is one of the powerhouses of Python, as you may have noticed in the
beginning with the number of things that can be iterated over. Understanding
those will help you write better and more concise Python code, without losing
meaning.
