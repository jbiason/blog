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
