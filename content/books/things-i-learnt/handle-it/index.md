+++
title = "Things I Learnt The Hard Way - If You Know How To Handle It, Handle It"
date = 2019-06-24

[taxonomies]
tags = ["en-au", "books", "things i learnt", "exceptions", "error handling"]
+++

If you know an error can occur, then you should handle it properly, instead of
ignoring it.

<!-- more -->

This is the opposite point of [let it crash](/books/things-i-learnt/crash-it):
You're writing some code that you _know_ it can crash in a certain way, what
should you do? Well, the answer is simple: _handle_ it, not _ignore_ it.

If we go back to the fact that Java will describe every single exception that
can be thrown by a function, you should handle each exception, no excuses.

If you're using Python, then you should capture the exceptions you know how to
handle, no exceptions -- and tying with the previous point, if you don't know
how to handle them, you should not capture them in the first place.

But, no matter what language you're using, if you know an error/exception can
occur, _deal with it_. If you have to save the save the content of the user
somewhere else, log it to be reprocessed later or even just show an error
message, do it.

{{ chapters(prev_chapter_link="/books/things-i-learnt/crash-it", prev_chapter_title="It's Better To Let The Application Crash Than Do Nothing", next_chapter_link="/books/things-i-learnt/languages-are-more", next_chapter_title="A Language Is Much More Than A Language") }}
