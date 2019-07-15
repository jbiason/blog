+++
title = "Things I Learnt The Hard Way - Optimization Is For Compilers"
date = 2019-07-15

[taxonomies]
tags = ["en-au", "books", "things i learnt", "optimization"]
+++

Let say you need more performance on your application. You may be tempted to
look at your code and think "How can I keep this same logic and still remove a
few cycles, so things seem to go faster?" Well, if you want performance, you
need to change your logic.

<!-- more -->

But before jumping into the code, you may have to check your compiler options.
Maybe you're not generating the optimized version. Maybe there is an option
that you don't use that you can remove from the compilation.

'Cause "optimization" is what a compiler is for. They _know_ where they can
extract most of the underlying architecture, and people have been finding ways
to make the compiled code more performance for decades. Heck, compilers can
even _delete_ parts of your code 'cause they can "see" that a piece of code
will always produce the same result and, thus, isn't necessary and they will
just put the same result where that piece of code was.

What you need to do is to think about a better _design_ for your code, not how
to improve the current code. And trying to trick the compiler by [messing with
the types](/books/things-i-learnt/data-types), although may produce faster
code, will really screw you in the future -- specially cause maintenance and
code understanding will take long and figuring out what went wrong will always
be harder.

Code is written for humans to read. _ALWAYS_. Optimization is what compilers
do. So find a smarter way to explain what you're trying to do instead of using
shorter words or messing with that your code is saying.

{{ chapters(prev_chapter_link="/books/things-i-learnt/use-utf8", prev_chapter_title="Always Use UTF-8 For Your Strings", next_chapter_link="/books/things-i-learnt/config-file", next_chapter_title="The Config File Is Friend") }}

