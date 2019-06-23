+++
title = "Things I Learnt The Hard Way - Testing Every Function Creates Dead Code"
date = 2019-06-21

[taxonomies]
tags = ["en-au", "books", "things i learnt", "unit tests", "dead code"]
+++

If you write a test for every single function on your system, and your system
keeps changing, how will you know when a function is not necessary anymore?

<!-- more -->

Writing a test for every single function on your system may come from the
"100% Coverage Syndrome", which afflicts some managers, thinking that the only
way to be completely sure your system is "bug free" is to write tests for
every single piece of code, till you reach the magical "100% coverage" in all
the tests.

I do believe you can reach 100% coverage, as long as you're willing to
_delete_ your code.

Cue the universal grasps here.

But how do you know which pieces of code can be deleted?

When I mentioned [integration
tests](/books/things-i-learnt/integration-tests), I mentioned how much more
sense it made to me reading them instead of the "unit" tests, because they
were describing exactly how the system would operate in normal conditions. If
you write tests the go through the system, doing normal operations, and you
can get tests for all the normal cases -- and some "abnormal", like when
things go wrong -- then you know that, if you run those tests and they mark
some lines as "not tested", it's because you don't need them.

"But Julio, you're forgetting the error control!" I do agree, specially when
you're talking with project owners or some other expert, that people will
forget to tell you what to do in case of things going wrong -- say, someone
entering a name in the age field -- but _you_ can see those and _you_ know
that you need error control so _you_ can add the error control and describe
the situation where that error control would trigger.

If, on the other hand, you write a test for every function, when you do a
short/simple check, you'll find that the function is still being used in the
system -- by the tests, not actually, "value to the user" code. Sure, you can
use your IDE to go back and forth between code and test and see if it points a
use beyond the test, but it won't do it for yourself.

There is one other weird thing about trying to write integration tests for
error controls: Sometimes, you can't reach the control. It's true! I did wrote
control checks for every function once but, when running in the integration
tests, there was no way to produce an input at the input layer of the system
that would reach the error control in that function -- mostly 'cause the
other functions, which would run before the one I was trying to test, would
catch the error before it. If that's a design problem or not -- it probably
was -- it's a different discussion, but the fact is that that function didn't
need error control.

{{ chapters(prev_chapter_link="/books/things-i-learnt/integration-tests", prev_chapter_title="Unit Tests Are Good, Integration Tests Are Gooder", next_chapter_title="Tests Make Better APIs", next_chapter_link="/books/things-i-learnt/tests-apis") }}
