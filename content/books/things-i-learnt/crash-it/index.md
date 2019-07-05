+++
title = "Things I Learnt The Hard Way - It's Better To Let The Application Crash Than Do Nothing"
date = 2019-06-24

[taxonomies]
tags = ["en-au", "books", "things i learnt", "exceptions", "error handling"]
+++

Although that sounds weird, it's better to not add any error handling than
silently capturing errors and doing nothing.

<!-- more -->

For example, a (sadly common) example of Java code:

```java
try {
  something_that_can_raise_exception()
} catch (Exception ex) {
  System.out.println(ex);
}
```

This does nothing to deal with the exception -- besides printing it, that is.

The example may be a bit bad, 'cause Java forces capturing exceptions on
functions that throw exceptions and it forces functions to mark themselves as
throwing exceptions if there a `throw` in them.

But Python doesn't have this restriction and people _still_ try to capture
exceptions for doing absolutely nothing -- and, worse, just keep the execution
going.

If the language allows it, you should let the application crash due the lack
of error handling -- as long as you don't have any idea on how to handle it.
Then, when they crash, you can think of a way to deal with it, instead of
silently capturing it and doing nothing.

Also, keep in mind to not go forth and capture _every_ exception/error in a
single take -- like the example above, which will capture every exception, or
like `except Exception` in Python. This last example actually happened to me
when another developer added this "broad except"[^1] in a network code and, at
some point, the code would get into the capture all the time. We checked every
cable, every connection, every interface, till I noticed there was a syntax
error in the code. In Python, syntax errors raise exceptions and, because we
had a "capture all exceptions", we lost some pretty good time looking for the
problem in the wrong place.

[^1]: As called by Pylint.

{{ chapters(prev_chapter_link="/books/things-i-learnt/interface-changes", prev_chapter_title="Beware of Interface Changes", next_chapter_link="/books/things-i-learnt/handle-it", next_chapter_title="If You Know How To Handle It, Handle It") }}
