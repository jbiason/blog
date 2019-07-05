+++
title = "Things I Learnt The Hard Way - Documentation Is a Love Letter To Your Future Self"
date = 2019-06-21

[taxonomies]
tags = ["en-au", "books", "things i learnt", "documentation"]
+++

We all know writing the damn docs for functions and classes and modules is a
pain in the backside. But realizing what you were thinking when you wrote the
function will save your butt in the future.

<!-- more -->

When I say that it will save your butt, I don't mean the documentation will
tell you something like "Here are the lotto numbers in 2027"[^1] or "If John
complains about your future code review, here is some shit he did in the
past".

I mean, it will explain how the _flow_ of your code is expected to do. Imaging
this: pick your code and replace every function call to its documentation. Can
you understand what it is expected by reading that? If you can,
congratulations, you won't have a problem in the future; if you can't... well,
I have some bad news for you...

One point that may come here is "Code is its own documentation" or
"self-documenting code". I do understand, and yes, simpler functions may make
the documentation redundant (for example, if you notice that you need a
function that multiplies two numbers -- and only do that -- giving it a
description of "Multiples two numbers" may look redundant), but you have to
ask yourself _why_ you needed such simple function. _Why_ it exists? _Where_
it sits in the general data flow?

That's the things you need to document.

[^1]: Please, don't make me revise this in 2027... :(

{{ chapters(prev_chapter_link="/books/things-i-learnt/languages-tests", prev_chapter_title="Good Languages Come With Tests", next_chapter_link="/books/things-i-learnt/document-is-contract", next_chapter_title="The Function Documentation Is Its Contract") }}
