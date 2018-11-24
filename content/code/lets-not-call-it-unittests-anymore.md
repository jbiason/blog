+++

title = "Let's Not Call It \"Unit Tests\" Anymore"
date = 2018-05-09

category = "thoughts"

[taxonomies]
tags = ["unit tests", "en-au"]

+++
I keep seeing people call tests "integration tests", while they are perfect
unit tests. So maybe what we call "unit tests" shouldn't be called unit
tests.

<!-- more -->

For example, one thing I always mention is that your tests should reflect your
requirements for the product and nothing more. And a lot of people think this
is counter productive.

Another thing is that I keep pointing over and over again that the definition
of "unit test" is a test that doesn't depend on anything else (like any other
test); if it starts from an empty plate, creates the whole environment
required for the functionality to be tested, runs something and checks the
result, it *is* a unit test.

But here is the kicker: A lot of people will say that if you test your class
or function, then it is a unit test; if you test the whole thing, like a black
box, it's an integration test.

Hold on a sec. If I'm testing the whole pipeline of functions and classes,
believing they build a black box of sorts -- something I have no idea how it's
built inside or how many functions are called or *how* those functions are
called and *designed* -- so it is an integration test; but if the test also
builds the whole environment and doesn't require anything else to check its
results, it is **also** a unit test.

So far, I hope you're following where I'm going. 'Cause I'm going to take
another detour -- it's quick, I promise.

Remember the first that I mentioned that I believe that tests should reflect
the requirements of the product? That's basically "When the user types its
birth day, we should display their age" and "If the user does not have the
required license for a product in their account, the action should not be
displayed". This is usually where people fall back to BDD and write tests in
Gherkin and such.

And that's the first thing people will complain: If the code is a mess and
completely messes with all the layers and it's not extensible and such problem
and such problem *but it follows the requirements*, then it's ok?

And the answer is "yes" -- or, at least, I truly believe it is "yes".

Heck, you're giving value to your users, why isn't that valid?

"It *is* valid, but it shouldn't be just that."

Ok, here is where the two roads join:

If you write a test that checks the product requirement, it doesn't depend on
anything else and proves that your changes add value to the product... then
why write tests for the classes and functions and everything else?

No, seriously. There *is* an answer, but you'll let you think a bit about
this.

Seriously, *why* you're checking a single class when it, alone, provides no
final value to the product, as it requires coordinated work with other classes
and functions to actually provide something useful?

The answer for this is kinda hidden in a problem I pointed before: "the code
is a mess and completely messes with all the layers and it's not extensible and
such problem and such problem". How do you prevent your code to become a mess,
to make it still be extensible and not throwing things in the wrong place?

You write *well defined layers* and make sure those boundaries are respected.
You break things apart to make sure expected *internal behaviors* are
followed.

You're still not providing product value, but you're checking if your
perceptions of a good design are being followed. This is why
you don't test every single function and class, unless every single function
and class follows your design; you usually don't need to test your `util`
class/module because it's just something you do to be DRY and that's
not part of your design.

You may write tests to check if your model/repository layer is doing it's work
of hiding the implementation of the storage; you may write tests to your
controller classes/functions to make sure you're trying to add display filters
on it because that's the view job and you're not trying to go directly into
the file system to retrieve data because that's the model layer job; and so
on.

So... It's more like a *developer tests*, isn't it?

I mean, it's not related (at least, not directly related) to the product
value; it's directly related to the *code* value *developers* perceive in
their design.

And heck, it should be as much as a unit test like the integration tests are.
