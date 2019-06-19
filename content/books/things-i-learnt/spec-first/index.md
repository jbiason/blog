+++
title = "Things I Learnt The Hard Way - Spec First, Then Code"
date = 2019-06-18

[taxonomies]
tags = ["en-au", "books", "things i learnt", "specs", "code"]
+++

"Without requirements or design, programming is the art of adding bugs to an
empty text file." -- Louis Srygley

<!-- more -->

If you don't know what you're trying to solve, you don't know what to code.

A lot of times we have this feeling of "let me jump straight to the code". But
without understanding what problem you're trying to solve, you'd end up
writing a bunch of things that doesn't solve anything -- or, at least,
anything that _should_ be solved.

So here is the point: Try to get a small spec on whatever you want to solve.
But be aware that even that spec may have to be thrown out, as the
understanding of the problem tend to grow as long as the project continue.

Yes, it's paradoxical: You need a spec to know what to code to avoid coding
the wrong solution, but the spec may be wrong, so you _end up_ solving the
wrong solution anyway. So what's the point? The point is, the spec reflects
the understanding of a problem _at a certain point_: All you (and your team)
know is _there_.

The times I stood longer looking at my own code wondering what to do next were
when we didn't have the next step defined: It was missing some point of the
solution or we didn't have the communication structures defined or something
of sorts. Usually, when that happened, I stumbled upon Twitter or Mastodon
instead of trying to solve the problem. So when you see yourself doing this
kind of stuff -- "I don't know what to do next, and I'm not sure if I'm done
with the current problem" -- then maybe it's time to stop and talk to other
people in the project to figure that out.

{{ chapters(prev_chapter_link="/books/things-i-learnt/disclaimer", prev_chapter_title="Disclaimer", next_chapter_link="/books/things-i-learnt/steps-as-comments", next_chapter_title="Write Steps as Comments") }}
