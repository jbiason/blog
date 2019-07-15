+++
title = "Things I Learnt The Hard Way - Logs Are For Events, Not User Interface"
date = 2019-07-15

[taxonomies]
tags = ["en-au", "books", "things i learnt", "monitoring"]
+++

On a previous life, to understand how a system behaved, I added a ton of
metrics: how fast things were going in, how fast things were going out, how
many things were in the middle, how many the job processed... Not doing it so
makes me feel... naked.

<!-- more -->

Monitoring your project performance give you a really good view of how a
system is behaving. Is the speed going down? Is the system taking longer to
process an input? Are no inputs being processed?

If you have this kind of information, you can check what is going on in the
system and understand why. Is it normal? Did a change around the system (the
other system that produces the input, the system that consumes in the output)
affected the results?

If you're not measuring, you'll have no idea.

Also, "If you can not measure it, you can not improve it", as Lord Kevin said.

{{ chapters(prev_chapter_link="/books/things-i-learnt/log-events", prev_chapter_title="Logs Are For Events, Not User Interface", next_chapter_link="/books/things-i-learnt/languages-are-more", next_chapter_title="A Language Is Much More Than A Language") }}
