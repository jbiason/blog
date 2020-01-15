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

Against what most people claim, I do believe that you can reach 100% coverage
pretty easily: You just need to delete code.

The idea is quite simple, actually: If your tests check the system behavior,
and I'm proving that all tests pass, everything that doesn't have coverage
point to code that isn't necessary and, thus, can be deleted.

It is not every code that can be removed. In the alarm manager example, even
when our "unit tests" cover all functionalities of each module, we got a block
in the "integration tests" that didn't have any coverage. This block was
responsible for checking the input of a module (for example, it won't allow
sending a SNMP message without a text). But, when we checked the code, we
realized that the base module (the one calling the others) was already doing
that validation and that this check was unnecessary. This lead into the
discussion of which test (and code block) should be removed. But we did have a
piece of "dead code" that was being marked as "alive" because we had unit
tests for both blocks.

A more practical example. Imagine there is a class that keeps customer data in
a web shop[^3]:

```python
class Client:
    def __init__(self, name):
        self.name = name
```

After awhile, comes a new requirement: A certain "Dewey" keeps creating
accounts non-stop, without doing any purchases, just to put trash in the
database; we need to block any new customers that make their name as just one
name.

Then, thinking about SOLID[^4], the developer changes teh code to this:

```python
def _multiple_names(name):
    split_names = name.split(' ')
    return len(split_names) > 1

def _validate_name(name):
    if not _multiple_names(name):
        raise Exception("Invalid name")
    return name

class Client:
    def __init__(self, name):
        self.name = _validate_name(name)
```

Now, when there is any service trying to create a new customer, the name is
validated against a certain rules and one of those is that the name must have
multiple names[^5].

New funcionality, new tests, right?

```python
import pytest

def test_single_name():
	"""'Cher' não tem multiplos nomes."""
    assert not _multiple_names('Cher')

def test_multiple_name():
	"""'Julio Biason' tem múltiplos nomes."""
    assert _multiple_names('Julio Biason')

def test_valid_name():
	"""'Julio Biason' é um nome válido."""
    _validate_name('Julio Biason')

def test_invalid_name():
	"""'Cher' não é um nome válido e por isso levanta uma exceção."""
    with pytest.raises(Exception):
        _validate_name('Cher')

def test_client_error():
	"""Se tentar criar uma conta com 'Cher', deve dar erro."""
    with pytest.raises(Exception):
        Client(name='Cher')

def test_client():
	"""Uma conta com nome 'Julio Biason' deve funcionar."""
    Client(name='Julio Biason')
```

Running the tests:

```
$ pytest --cov=client client.py
==== test session starts ====
plugins: cov-2.4.0
collected 6 items

client.py ......

---- coverage: platform linux, python 3.4.3-final-0 ----
Name        Stmts   Miss  Cover
-------------------------------
client.py      25      0   100%

==== 6 passed in 0.11 seconds ====
```

100% coverage and new functionality done! The developer give themselves some
pats in the back and go home.

But, in the middle of the night, one of the managers who is also a friend of
Björk, gets a call from her telling that she tried to buy something and just
got an error message. The developer gets in the office next morning, sees the
manager email complaining about their famous friend being blocked and goes
into fixing the code:

```python
class Client:
    def __init__(self, name):
        self.name = name
```

There, no more validation[^6] e now Björk can buy whatever she wants. But
running the tests:

```
==== FAILURES ====
____ test_client_error ____

    def test_client_error():
        with pytest.raises(Exception):
>           Client(name='Cher')
E           Failed: DID NOT RAISE <class 'Exception'>

client.py:37: Failed
==== 1 failed, 5 passed in 0.63 seconds ====
```

Oh, sure! Cher is now a valid name and that behavior being tested is invalid.
We need to change the test to accept Cher:

```python
def test_client_error():
	"""Se tentar criar uma conta com 'Cher', deve funcionar."""
	Client(name='Cher')
```

And running the tests once again:

```
$ pytest --cov=client  client.py
==== test session starts ====
rootdir: /home/jbiason/unitt, inifile:
plugins: cov-2.4.0
collected 6 items

client.py ......

---- coverage: platform linux, python 3.4.3-final-0 ----
Name        Stmts   Miss  Cover
-------------------------------
client.py      24      0   100%

==== 6 passed in 0.12 seconds ====
```

Wonderful! Everything is working with the expected behaviors and we still have
100% coverage.

But can you spot the problem in the code?

The problem is now that `_multiple_names` is not being used anywhere, but it
is shown as "alive" 'cause there is a lost test that keeps saying that the
code is being used. If we had started with just the behavior tests --
using just the system inputs and outputs -- right out of the bat we would see
that the function is not used anymore -- and if we need it in the future...
well, that's what version control systems are for.

Although this looks like a silly example, there are some cases in which the
processing flow can be changed by the environment itself. For example, in
Django, you can add "middleware" classes, which are capable of intercepting
Requests or Responses and change their result. The most common example of
middleware is the Authentication, which adds the logged user information in
the Request; but those changes can be more deep, like changing some form
information. In those cases, the input (or the output, or both) is changed
and writing tests that ignore the middleware will not be a correct
representation of the input (or output, or both) of the system. And there we
can ask if the test is valid 'cause it is using a state that should not exist
in the normal use of the system.

## Mocks

Some time ago, I used to say that mocks should be used for things external to
the system. But I realized that definition is not quite correct -- there are
external things that shouldn't be mocked -- and that a better definition for
what should be mocked is "anything that you have no control".

For example, if you're writing a system that uses IP geolocation using an
external service, you probably will mock the call for that service, as it is
out of your control. But a call to a database, when you're using a
system/framework that abstracts all the calls for the database (like Django
does), then the database, even being an external resource, is still under your
control and, thus, shouldn't be mocked -- but since the system/framework
offers a database abstraction, using any database shouldn't affect the
results.

Another example are microservices. Even microservices inside the same company
or steam are external and out of control of the project and, thus, should be
mocked. "But they are from the same team!" Yes, but they are not part of the
same project and a) the idea behind microservices is to uncouple those
services and/or b) are in different directory trees. One of the advantages of
microservices from the same team is that the expected contract from one is
know by the team and that could be easily mocked (the team knows that, calling
a service with X inputs, it should receive an Y response -- or error).

# Conclusion

Again, the idea is not to rewrite every test that you have 'cause "the right
way is my way". On the other hand, I see a lot of tests being written in any
way, just using the context of "one test for each function/class" and, in some
cases, that doesn't make any sense and should get a little more thinking. By
exposing those "impure thoughts" about tests, I hope that would make people
rethink the way they are writing their tests

---

[^1]: Unless you want to use roman numerals, but anyway...

[^2]: The reason for being changed to a string can be anything: due some
  security plugin, 'cause we are using a database that doesn't work properly
  with integers, 'cause we are plugging this system with a legacy one...

[^3]: A class that keeps customer information should be way more complex that
  this, but let's keep it simple just for this example.

[^4]: No, that's not really SOLID, but that's keep it simple again for this
  example.

[^5]: Someone will send me the "Fallacies Developers Believe About User Names"
  links for this, right?

[^6]: Sure, I should change just `_validate_name`, but this way it makes it
  even more clear what the problem is.
