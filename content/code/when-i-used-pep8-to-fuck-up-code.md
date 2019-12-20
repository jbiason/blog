+++
title = "When I Used PEP8 To Fuck Up Code"
date = 2016-07-19

[taxonomies]
tags = ["python", "pep8", "readability"]
+++

We "inherited" some Python code recently. Although another team was working on
it, we now should support it and keep it going. The previous team at least
tried to use Pylint and follow PEP8. And I say "tried" because their
`pylintrc` has a couple of exceptions and their PEP8 extended the
maximum column to 100.

<!-- more -->

{% note () %}
Pylint exceptions are almost common case these days, specially in
a Django project. But plain, pure `pylintrc` exclusion without giving any
pointers on *why* you're adding that exception are dumb, IMHO. I had a
project were we decided to add pylint exceptions inside the code, but for
every exception there should be a comment preceeding it explaining the
reason for the exception ("the framework doesn't expose this directly",
"pylint can't see this variable, but it is there", "It's the common place
to name the variable this way" and so on).
{% end %}

Quick pause here 'cause I know a bunch of people will complain with a "But
monitors these days are very large and you don't need to focus on column 80;
we don't use CGA anymore, old person!". The thing about the maximum column at
80 is *not* about "being visible on every CGA" but actually a measure of
readability: If you speak shorter, concise sentences, people will get the idea
quickly; if you keep an stream of words non-stop without reaching a conclusion
and without any punctuation to keep the ideas flowing, you will end up with
something that it is easier to forget and which the central idea will be lost
(and I freaking hope you got what I just did). It's tiring to read a very long
sentence; it's easy to keep the context on a short sentence.

In the spirit of "proper" PEP8, I reformatted one of the failing tests
to follow the 80 column limit. And now the code looks like crap. And
I'll commit like that. It's not because I hate my coworkers, but to point out
that, because it's a pain to read, it means the structured of the code is too
complex. If someone comes and say "damn, this test is hard to read", I'll be
able to point that it is not the test that it is hard to read, but the code
that reached the point where its complexity is leaking to the test code; it is
now a good time to refactor this to simplify things and make them easier to
read.

{% note() %}
Actually, the reason for it to fail is too damn fun and worth a proper blog
post about it. Stay tunned!
{% end %}

Not that we can simply stop working and fix the damn architecture of it, but we
can at least keep this beast around till everybody gets pissed and realize it
*desperately needs* a refactor.

{% note() %}
Weird thing, people usually assume some countries are the center of bad code;
this baseline is coming from a "first world country" and, heck, it has one of
the worst designs I ever saw. I'll not name names here to protected the (maybe)
innocent. But in the second week of training, I realized this whole project
has, at least, 6 months of technical debt already.
{% end %}
