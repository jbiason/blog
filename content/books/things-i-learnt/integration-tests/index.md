+++
title = "Things I Learnt The Hard Way - Unit Tests Are Good, Integration Tests Are Gooder"
date = 2019-06-19

[taxonomies]
tags = ["book", "things i learnt", "unit tests", "integration tests"]
+++

The view of the whole is greater than the sum of its parts. And that includes
tests for the whole compared to tests of single things.

<!-- more -->

First, I just don't want to into a discussion about what's the "unit in a unit
test"[^1], so let's take the point that a unit test is a test that tests a
class/function, not the whole system from end to end, which would require data
flowing through several classes/functions.

There are several libraries/frameworks that actually split this in a way that
you can't test the whole.
[Spring](https://spring.io/)+[Mockito](https://site.mockito.org/) is one of
those combinations -- and one that I worked with. Due the bean container of
Java, the extensive use of Beans by Spring and the way Mockito interacts with
the container, it's pretty easy to write tests that involve only one class:
You can ask Mockito to mock every dependency injection (so it injects mocked
beans instead of the real ones) in one class and mock every injected class,
simply using annotations.

And this is cool and all and makes tests simple and fast. But the fact that we
are making sure each class does what it should do, it doesn't give a proper
view of the whole; you can't see if that collection of perfectly tested
classes actually solve the problem the system is responsible for solving.

Once, in C++, I wrote an alarm system
[daemon](https://en.wikipedia.org/wiki/Daemon_(computing)) for switches. There
were three different levels of things the alarm system should do, depending on
the incoming message from a service: It could only log the message of the
incoming error, it could log the error and send a SNMP message, or it could
log the error, send a SNMP message and turn a LED in the front panel on.
Because each piece had a well defined functionality, we broke the system in
three different parts: One for the log, one for the SNMP and one for the LED.
All tested, all pretty. But I still had a nagging feeling that something was
missing. That's when I wrote a test that would bring the daemon up, send some
alarms and see the results.

And, although each module was well tested, we still got one things we were
doing it wrong. If we never wrote an integration test, we would never catch
those.

Not only that, but because we wrote a test that interacted with the daemon, we
could get a better picture of its functionality and the test actually _made
sense_ -- as in, if you read the unit tests, they seemed disconnected from
what the daemon was expected to do, but the integration tests actually read
like "Here, let me show that we actually did what you asked". And yes, this
was akin to [Gherkin](/books/things-i-learnt/gherkin) tests, although I didn't
know Gherkin at the time -- and, better yet, we had tests that proved that we
were following the [spec](/books/things-i-learnt/spec-first).

Personally, I think over time integration tests become more important than
unit tests. The reason is that I personally have the feeling[^2] that unit
tests check if the classes/functions have _adherence_ to the underlying
_design_ -- Does your view can actually work without the controller? Is the
controller using something from the model or using things that should be in
the view? -- but adherence to the design gets better over time -- developers
start using the layout from previous examples, so they capture the design by
osmosis, while the big picture starts to get more and more complex, with lots
of moving parts.

[^1]: There is no "unit" in "unit tests". "Unit test" means the test _is_ a
  unit, indivisible and dependent only on itself.

[^2]: Again, it's pure feeling from my experience. I have no data to back that
  affirmation up, so take it with a grain of salt.

{{ chapters(prev_chapter_link="/books/things-i-learnt/users", prev_chapter_title="Think About The Users", next_chapter_title="Testing Every Function Creates Dead Code", next_chapter_link="/books/things-i-learnt/tests-dead-code") }}
