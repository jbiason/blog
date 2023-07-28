+++
title = "The Problem With Gradual Typing Examples"
date = 2023-07-12
draft = true

[taxonomies]
tags = ["programming languages", "typing", "static typing", "progressive typing"]
+++

[Gradual Typing](https://en.wikipedia.org/wiki/Gradual_typing) offers the mixed
results of static typing and dynamic typing: You can let the
compiler/interpreter fight with the types in the runtime when you don't specify
them, but you can say the type of a variable and the compiler/interpreter will
pick incompatible type operations before it runs.

But the examples I've seen always pull things in, in my option, the wrong way.

<!-- more -->

The general example of a bad thing for gradual typing is this type of code:

```
def add(a, b):
    return a + b
```

The issue is that there are multiple values that can be added. If we consider
just the primitive types of Python, we would get something like:

```
from typing import Union

CanAdd = Union[str, float, int]

def add(a: CanAdd, b: CanAdd) -> CanAdd:
    return a + b
```

This code obviously breaks on other things can be added. For example, you can
create an class, override its `add`/`+` operator and, thus, objects of said
class can be added. But because our just-primitives types doesn't list our new
class, the compiler/interpreter would never accept a call of `add()` with those
objects.

(There is another issue, sometimes cited, sometimes don't, about the fact that
there is nothing saying that the type of `b` must be the same type of `a` and
thus one could add an integer to a string, which is... wrong.)

But I have a question:

**Is that a real world kind of function?**

Oh, don't get me wrong: Simpler functions, with just as few lines is quite
normal. Something that would be *real*[^1] would be something like:

```
def item_total(qty: int, price: float) -> float:
    return qty * price
```

I guess this is more common than `add()`, because it is an operation that
happens most of the time. And this would get the case of

```
def receive_api_request(json_data):
    ...
    for item in json_data['items']:
        total += item_total(item['price'], item['qty'])
```

If you don't type check, this would produce exactly the same results. But the
code is wrong, and if someone do a small change in `item_total()`, you'd end up
with a strange thing in which only this call produces the wrong results, while
all other interfaces would (probably) produce the correct result.

{% note() %}
Surely there are issues, nonetheless. Python, which I used in this example,
would still not accept anything that could be automatically coerced to int,
even if such interface doesn't exist, although they are working on support
types with "protocols".
{% end %}

---

[^1]: For different values of "real".
