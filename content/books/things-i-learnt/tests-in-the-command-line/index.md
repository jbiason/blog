+++
title = "Things I Learnt The Hard Way - Make Tests That You Know How To Run on the Command line"
date = 2019-06-19

[taxonomies]
tags = ["en-au", "book", "things i learnt", "tests", "command line"]
+++

You know that "Play" with a little something on your IDE that runs only the
tests? Do you know what it does?

<!-- more -->

A long time ago I read the story about a professor that taught his students to
code. He preferred to teach using an IDE, 'cause then "students have to just
press a button to run the tests".

I get the idea, but I hate the execution.

When we get into professional field, we start using things like [continuous
integration](https://en.wikipedia.org/wiki/Continuous_integration) which,
basically, is "run tests every time something changes" (it's a bit more than
that, but that's the basic idea).

Now, let me ask you this: Do you think the students of the professor above
would know how to add the command to run the tests in a continuous
integration system?

I know I'm being too picky (one could even call me "pricky" about this) but
the fact is that whatever we do today, at some point can be automated: our
tests can be run in an automated form, our deployment can be run in an
automated form, our validation can be run in an automated form and so on. If
you have no idea how those things "happen", you'll need the help of someone
else to actually build this kind of stuff, instead of having the knowledge
(well, half knowledge, the other half is the CI tool) with you all the time.

{{ chapters(prev_chapter_link="/books/things-i-learnt/tests-apis", prev_chapter_title="Tests Make Better APIs", next_chapter_link="/books/things-i-learnt/throw-away", next_chapter_title="Be Ready To Throw Your Code Away") }}
