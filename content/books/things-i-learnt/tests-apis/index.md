+++
title = "Things I Learnt The Hard Way - Tests Make Better APIs"
date = 2019-06-19

[taxonomies]
tags = ["en-au", "book", "things i learnt", "unit tests", "layers", "apis"]
+++

Testing things in isolation may give a better view of your APIs.

<!-- more -->

When I spoke about [integration
tests](/books/things-i-learnt/integration-tests) you may end up with the
impression that I don't like unit tests[^1].

Actually, I think they provide some good intrinsic values.

For example, as mentioned before, they can provide a better look at the
adherence to the design.

But, at the same time, they give a better view of your internal -- and even
external -- APIs.

For example, you're writing the tests for the view layer -- 'cause, you know,
we write everything in layers; layers on top of layers -- and you're noticing
that you have to keep a lot of data (state) around to be able to make the
calls to the controller. That's a sign that you may have to take a better look
at the controller API.

Not only that, but take, for example, the fact that you're working on a
library -- which will be called by someone else -- and you're writing tests
for the most external layer, the layer that will be exposed by the library.
And, again, you're noticing that you have to keep a lot of context around,
lots of variables, variables coming from different places and similar calls
using parameters in different ways. Your tests will look like a mess, don't
they? That's because the API _is_ a mess.

Unit testing your layers makes you the _user_ of that layer API, and then you
can see how much one would suffer -- or, hopefully, enjoy -- using that.

[^1]: Again, let's ignore for a second that there are no "unit" in "unit
  tests"...

{{ chapters(prev_chapter_link="/books/things-i-learnt/integration-tests", prev_chapter_title="Unit Tests Are Good, Integration Tests Are Gooder", next_chapter_link="/books/things-i-learnt/tests-in-the-command-line", next_chapter_title="Make Tests That You Know How To Run on the Command line") }}
