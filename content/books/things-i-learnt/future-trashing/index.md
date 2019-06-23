+++
title = "Things I Learnt The Hard Way - Future Thinking is Future Trashing"
date = 2019-06-21

[taxonomies]
tags = ["en-au", "books", "things i learnt", "design", "solution"]
+++

When developers try to solve a problem, they sometimes try to find a way that
will solve all the problems, including the ones that may appear in the future.

<!-- more -->

Trying to solve the problems that will appear in the future comes with a hefty
tax: future problems future will never come -- and, believe me, they _never_
come -- and you'll end up either having to maintain a huge behemoth of code
that will never be fully used or you'll end up rewriting the whole thing
'cause there is a shitton of unused stuff.

Solve the problem you have right now. Then solve the next one. And the next
one. At one point, you'll realize there is a pattern emerging from those
solutions and _then_ you'll find your "solve everything". This pattern is the
_abstraction_ you're looking for and _then_ you'll be able to solve it in a
simple way.

{{ chapters(prev_chapter_link="/books/things-i-learnt/throw-away", prev_chapter_title="Be Ready To Throw Your Code Away", next_chapter_link="/books/things-i-learnt/boolean-parameters", next_chapter_title="Don't Use Booleans As Parameters") }}
