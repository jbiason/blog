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

{{ chapters(prev_chapter_link="/books/things-i-learnt/interface-changes", prev_chapter_title="Beware of Interface Changes", next_chapter_link="/books/things-i-learnt/handle-it", next_chapter_title="If You Know How To Handle It, Handle It") }}
