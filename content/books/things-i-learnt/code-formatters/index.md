+++
title = "Things I Learnt The Hard Way - Code Formatting Tools Are Ok, But No Silver Bullet"
date = 2019-07-16

[taxonomies]
tags = ["en-au", "books", "things i learnt", "code formatting", "code style"]
+++

One thing a team may decide to fix the continuous flux of code style comments
in a code review is to use a code formatting tool to auto-format the code.
That's ok, but they should never rely on it.

<!-- more -->

Now yeah, that kinda solves the problem, but there is one small problem:
we, humans, are not as flexible to read code as computers are; what is
readable by a computer may not be readable by a human. Surely they try to
create some heuristics on what is good for human reading, but that doesn't mean
it gets right.

Also, unless you start from scratch to use the auto-formatting tool or do a
change in all files in one single go, you should never assume it will do a
good job.

I've seen tools like this implemented in a commit hook, in a way that the tool
would reformat the code just before adding it to the repository. The biggest
problem is that, in that team, we didn't run the auto-formatting tool in the
whole project before hand, and we also added a coverage tool (that checked the
coverage on the changed parts of the file) without every running the coverage
tool on everything. The result is that, suddenly, a lot of commits got refused
because the auto-formatting tool was changing lines that the developer didn't
change (it changed old code) and suddenly the coverage tool noted the missed
tests and decided it was no good.

So good, punctual changes were suddenly being blocked 'cause instead of doing
the whole thing in a single shot, people decided it was a good idea to let the
code evolve till everything fixed itself.

On top of that, some people who were neither in the mood to actually add the
tests or worried about style found a way to do the commits _without running
the hook_, so they basically skipped the whole "let's improve our code" and
let fuck all.

So, it's ok if you run the auto-formatting tool for yourself, but you need to
have the maturity and responsibility to watch yourself and be willing to fix
and take responsibility for other people's code when the formatter changes
their code.

{{ chapters(prev_chapter_link="/books/things-i-learnt/code-review-styles", prev_chapter_title="Code Reviews Are Not For Style") }}
