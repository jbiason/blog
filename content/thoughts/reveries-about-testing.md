+++
title = "Reveries About Testing"
date = 2020-01-13

[taxonomies]
tags = ["tests", "testing", "integration tests", "unit tests"]
+++

Today, a large number of developers use some testing methodology. But what are
tests? What are they for? What is the purpose of writing testes, anyway? Are
we testing the right things?

<!-- more -->

{% note() %}
This is a companion post for one my presentations, [Filosofando Sobre
Testes](https://presentations.juliobiason.me/filosofando-testes.html), which
is in Portuguese.
{% end %}

Before we start, let me give you some disclaimers:

1. **I'm non-orthodox about tests**. What I mean by that is that some of stuff
   I'll mention here are exactly the opposite of what everyone says and the
   opposite of the way people work with tests.

2. In no way, consider this a set of rules. What I really want is to stop
   people from writing tests without knowing why they are writing those tests.

3. You don't need to agree with anything here. Again, the idea is to sotp and
   think what is being tested before writing tests.

What I want to discuss:

1. TDD, Kent Beck Style;
2. "Fast Tests, Slow Tests";
3. The Explosion of Slow Tests;
4. Coverage;
5. Mocks.

## TDD, Kent Beck Style

What made me rethink the way I wrote tests was a video by Ian Cooper, called
["TDD, where it all go wrong"](https://vimeo.com/68375232). In this video,
Cooper points out that the Beck's book (which brought the whole TDD
revolution) says two things:

1. Tests should run in an isolated way, nothing more, nothing less;
2. Avoid testing implementation details, test behaviors.

The first point is what it means for a "unit test", meaning "run in
isolation", in the sense that the test does not depend on others. This way,
"unit tests" should be seen as "the test is a unit", not "testing units" --
there are no "units", the test itself is a unit that doesn't depend on
anything else.

The second point is that one should test behaviors, not the implementation.
This is a point that I see we fail a lot when we talk about testing every
class/function: What if the expected behavior is the combination of two
classes? Is it worth writing tests for both, if splitting the classes (or
functions) is just a matter of implementation/way to simplify the code?

Also, another question for writing tests for every function and every class:
What we have know an application are their input channels -- which could be a
button in a graphical interface, an option passed in the command line or a web
request -- and the output channels; that way, the behavior is "given that
input in the input channel, I want this in the output channel", and everything
in the middle is implementation. And, for that transformation of something in
the input channel to the output channel, I may need a combination of
classes/functions; if I test every class/function, am I really testing the
expected behavior or the implementation?

"But this looks like BDD!", you must be thinking. Cooper says this in the
video above: the idea of "test every class/function" became the norm, the
point of checking behavior had to be used somewhere else, what gave us ATDD
(Acceptance-Test Driven Development) and BDD (Behavior Driven Development).

An example of testing behaviors: In the Django subreddit, there was a
question: [Should I write unit tests for Django's built in types?](https://www.reddit.com/r/django/comments/5bearg/should_i_write_unit_tests_for_djangos_built_in/) 
The question is basically this: Django allows defining the database model, and
from that model create a form that I can put on my templates and validate the
incoming data; that way, if I defined that there is a field in my model called
"Year of Birth" -- which can only receive numbers -- and I create a form based
on the model, put it on my template, send the data back and Django will make
sure, from the type in the model, that the incoming request will have a number
in that field. Should I still write a test for that?

The answer, though, is in take a step back and do the following question: Why
the year is a number? Obviously, 'cause years are defined as numbers[^1] and
the behavior of the field was defined way before we added the field in the
model. Also, supposed that for some reason, I need to store the field as a
string[^2]; if the type changes, the behavior should also change? Probably
not.

When I ignored that the year should be a number 'cause "the framework will
take care of it", I ignored the expected behavior due the implemtantation.

And "test behaviors, not the implementation".

Non-factual, but an anecdote: In a project, we had an "alarm manager" where,
from an event, it should generate only a log entry, generate a log entry and
send a SNMP signal or, if the user set it, generate a log, send a SNMP signal
and turn on a LED in the front of the device. With that, we created a module
for the log, a module for sending SNMP signals and a module to turn on/off the
LEDs. Every module had tests, but we didn't feel comfortable with it yet.
That's when I suggested we write a test that would bring the service up and
send events to it, just like any other application in the system, and check
what would happen. That's when the tests finally made sense. (I'll still talk
about these tests in the coverage part of this post.)

## Fast Tests, Slow Tests

The counterpoint of the points above can be something similar to what Gary
Bernhardt says in his presentation [Fast Test, Slow
Test](https://www.youtube.com/watch?v=RAxiiRPHS9k). In it, Bernhardt mentions
that they changed the way the tests work, and that now they could run
hundreds of tests in less than a second (an example shows around 600 tests
being run in 1.5 seconds).

What Bernhardt suggest is to write tests that checks online the models, with
no connection to the database or the views; tests for controllers with no
connection to the models or views; and tests for the views without the
controllers.

Does that sound familiar (specially if you use a MVC framework, which puts
each of those layers in different classes)?

Still about those tests, Bernhardt points that those "quick runs" help the
developers to test their to test their changes quickly (does that still sound
familiar?) but those tests do not replace the "integration tests".

In that point, I have to ask: If the tests are written to check if a
controller can be run without being connected to the rest of the system, but
one still have to write the (so called) integration tests to verify that the
project is delivering whatever was promised it would deliver, what is really
being tested here? The impression I have from the type of test Bernhardt
proposes is more to check _architectural adherence_ than a quality test: Does
this controller follow the structure of not having any connections to the
database itself? Does this model has only functions related to the storage and
retrieval of data, without any logic? If that's it, what is the value for my
user if a controller doesn't access the database directly?

It's not that I don't believe those tests have no value, but they give the
impression that, in the long run, they tend to become structurally very
similar while the (so called) integration tests tend to give more returns to
the quality of the project: Tests that defined an input and an expected result
tend to make sure that, in the long run, the functionality of the project will
still be the same.

## The Explosion of Slow Tests

The first thing that may pop up with a point like the above is that
"integration tests are slow and that will make the tests slow and make
developers less productive."

Yes, integration tests are slow, specially 'cause there is a good leg of work
in creating the expected initial state, all the inputs as expected by the
I/O system (again, graphical interface, command line, web), run the whole
processing stack and verify the result. And yes, waiting all this time may end
up breaking the developer's flow.

On the other hand, when a developer is working with some input, if it is a new
functionality/expected behavior, then there should be a test for this
behavior; if there is a change in the expected behavior, there should be a
test for the old behavior that needs to be changed. Running _just_ this test is
enough? No, but it should give a very good indication if the functionality is
working as expected. After making sure the behavior is correct, the developer
may execute the suite of tests for the thing being changed and let everything
else to the CI.

For example, if I'm working in a new functionality to show an error message
when there is an invoice when the product is not in stock, I have to write a
test that creates the product, let it with no pieces in stock, make an invoice
and check for the error message. Once this test checks the behavior is
correct, I can run all the other invoice tests, and then let the CI validate
that I didn't break anything else else in the stock management module or even
the customer module (for some reason).

And plugging with the first point, in order to do all the checks, I'd probably
need lots of functions/classes and test every single one of them will not make
sure the expected behavior is correct, but I'll get back to this later in the
coverage part.

I have the impression that we don't use this kind of stuff due two different
problems: the first is that testing tools have a very bad interface for
running suite of tests (for example, running all the invoice tests and _only_
the invoice tests); the second is that developers are lazy, and it's a lot
easier to run all tests than picking a single suite (not to mention organizing
said tests in suites to be run that way).

## Coverage

---

[^1]: Unless you want to use roman numerals, but anyway...
