+++
title = "Things I Learnt The Hard Way - Beware of Interface Changes"
date = 2019-06-23

[taxonomies]
tags = ["en-au", "books", "things i learnt", "interfaces", "apis"]
+++

Interfaces and APIs is what you give away to others. If you keep changing them,
you'll make everyone's life a sad life.

<!-- more -->

When talking about [boolean
parameters](/books/things-i-learnt/boolean-parameters), I mentioned about
renaming the function. If you control the whole source where the function is
used, that's not issue, it's just a matter of search and replace.

But if that function was actually exposed in a library, you shouldn't change
function names in a whim. That will break a lot of other applications beyond
your control and make a lot of other people unhappy.

Remember, when you write [tests for APIs](/books/things-i-learnt/tests-apis),
you can see these kind of changes happening and you can see the kind of
changes you're doing on how they reflect externally.

You can create the new functions and mark the current one as deprecated,
either by documentation or by some code feature. Then, after a few released,
you can finally kill the original function.

(A dickish move you can do is to create the new functions, mark the current
function as deprecated and _add a sleep at the start of the function_, in a
way that people using the old function are forced to update.)

{{ chapters(prev_chapter_link="/books/things-i-learnt/boolean-parameters", prev_chapter_title="Don't Use Booleans As Parameters", next_chapter_link="/books/things-i-learnt/crash-it", next_chapter_title="It's Better To Let The Application Crash Than Do Nothing") }}
