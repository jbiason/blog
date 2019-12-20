+++
title = "Things I Learnt The Hard Way - Global Changes Must Be Discussed With The Whole Team First"
date = 2019-07-31

[taxonomies]
tags = ["books", "things i learnt", "team", "changes"]
+++

So you got tired of bad tests and decided it is a good idea to add some [fuzz
testing](https://en.wikipedia.org/wiki/Fuzzing) tool. Before you do add it in
the main branch, you _have_ to discuss it with your team.

<!-- more -->

It's mind-bogging that some people think something it's so good that they
don't need to discuss with the whole team about it; they simply do. They don't
seem to care that people have their workflows and changing something would
break them. But hey, I've seen it so many times it is not even fun.

And let me clear here: You need to discuss it with the _whole_ team, not just
some of it (excluding people on vacations, 'cause you don't want to call them
just to tell them something will change). Worse: Don't discuss only with those
that will agree with you; you may not have seen all the problems those changes
will inflict on the other devs workflows but, by bringing that with those that
may not agree with you, you may gain some more insights on what could go
wrong.

Also, focus on what would be the gains and the loses. "We'll get better tests,
but you'll have to take a bit more care on the way you write tests" is a good
explanation, specially if you show the changes people will have to do in
future tests. Also also, notice that I said _future_ tests: if you want to
implement something new, you _must_ be sure it won't require everyone getting
out of their way to make your idea work -- don't make people rewrite tests
'cause they will break; don't make the other devs reformat their code 'cause
you decided, alone, to add a linter to your CI with your own rules; don't make
people worry about unwritten tests 'cause you decided it would be a good idea
to add a code formatting tool and that would make your coverage tool think
they are changing some unrelated piece of code that wasn't untested before.

Don't be a jerk thinking you know more than your whole team.

{{ chapters(prev_chapter_link="/books/things-i-learnt/hero-projects", prev_chapter_title="Global Changes Must Be Discussed With The Whole Team First", next_chapter_link="/books/things-i-learnt/specialists", next_chapter_title="Companies Look For Specialists But Keep Generalists Longer") }}
