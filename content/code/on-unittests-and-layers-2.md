+++
title = "On Unit Tests and Layers, Part II"
date = 2017-09-15

[taxonomies]
tags = ["unit tests"]
+++

After coming with a discussion about unit tests and layers, I got a
bunch of other insights, specially from a video of Gary Bernhardt
about "Fast Test, Slow Test".

<!-- more -->

Just after posting about 
[who one could see the layers through unit testing](@/code/on-unittests-and-layers.md),
I finally watched a video of Gary
Bernhardt (of the "DestroyAllSoftware" fame) about "Fast Test, Slow Test":

{{ youtube(id="RAxiiRPHS9k") }}

Basically, what Gary is going after is saying "write tests for the layer ONLY,
so all your tests are fast". Ok, I can get behind it, in a way. Because layers
have their behaviour -- in a "mechanical" sense, since they don't require
human interaction, but behaviour nonetheless -- so you're testing behaviour.

But that also rises one question: *What are you testing?* Are you testing the
*component* or the *application*? What do you deliver, anyway? *Components* or
an *application*? How do you make sure you're delivering an application in the
proper way?

Testing layer behaviour also has a bad side effect: If you're application
doesn't need a certain part of your layer -- say, you wrote a validator in the
model layer, but the powers to be decided it wasn't required anymore --, how
do you make sure it will go away? Your tests will still test those validators
-- after all, you're testing your model layer -- and your coverage will still
point that that piece of code is needed and you'll end up with a bunch of dead
code that is kept alive only because the tests require them.

Also, because Gary points out that the "integration tests" are still required,
you'll end up with a lot more tests than necessary. Why not focus on the
behaviour your *application* should have instead of the behaviour your
*layers* have?

I'm not against layer testing per-se, I'm just against writing tests that do
not reflect the general expected behaviour of the application and duplicating
tests because you're testing layer after layer and then testing them all
together. You should test the *value* of your application, not its components.

On a side note, Gary still does the same mistake everyone does, calling the
"all layers" tests "system tests". That's wrong. Just because you're going
through different layers it doesn't mean it can't be a unit test. It depends
only on itself? Does it test behaviour? Congratulations, you have a unit test.
