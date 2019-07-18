+++
title = "Things I Learnt The Hard Way - Units Makes Things Clear"
date = 2019-07-17

[taxonomies]
tags = ["en-au", "books", "things i learnt", "units", "explicit"]
+++

You know what's one of the worst function names ever? `sleep()`.

Sleep for how long? It is seconds or milliseconds?

<!-- more -->

Now let me ask you this: Would it clearer if the function was called
`sleepForMs()`? Would you understand that the function would make the
application sleep for a number of milliseconds?

What about `sleepForSecs()`? Do you understand that this will force your
application to sleep for a number of seconds?

What if, instead of using the function name, you could use `sleep("10s")`? Does
it make clear that you want it to sleep for 10 seconds?

That's why adding units to the function or parameters make sense. It removes
the ambiguity of what it means and doesn't rely on some specialized IDE/Editor
that display the parameter names.

{{ chapters(prev_chapter_link="/books/things-i-learnt/optimization", prev_chapter_title="Optimization Is For Compilers", next_chapter_link="/books/things-i-learnt/run-locally", next_chapter_title="If It Doesn't Run On Your Computer, You Have A Problem") }}
