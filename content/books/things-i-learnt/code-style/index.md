+++
title = "Things I Learnt The Hard Way - Code Style: Follow It"
date = 2019-07-16

[taxonomies]
tags = ["books", "things i learnt", "code style"]
+++

If your project have a defined code style, you must follow it. Sometimes it
may not be clear ("this struct/class should be singular or plural"?), but do
your best to follow it.

<!-- more -->

If your project doesn't have a style, maybe it's time to pick one. There are
well established styles for almost every language today, so you can start with
that. You can even make your changes, but you need to realize that since it's
been established for a while, a lot of other people are using that style and,
thus, if you keep as is, your code will mesh better with the rest of the
ecosystem.

And remember that even your stupid code is [part of the ecosystem of the
language](/books/things-i-learnt/languages-are-more) and the better you
interact with the ecosystem, the better citizen in the ecosystem you are.

**TIP**: If you don't have a code style yet, and you're using a language
that's derived from C or C++, use [K&R
Style](https://en.wikipedia.org/wiki/Indentation_style#K&R_style); if you're
working with Python, there is only one style:
[PEP8](https://www.python.org/dev/peps/pep-0008/).

{{ chapters(prev_chapter_link="/books/things-i-learnt/code-formatters", prev_chapter_title="Code Formatting Tools Are Ok, But No Silver Bullet", next_chapter_link="/books/things-i-learnt/google-code-style", next_chapter_title="... Unless That Code Style Is The Google Code Style") }}
