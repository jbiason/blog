+++
title = "Things I Learnt The Hard Way - Understand And Stay Away From Cargo Cult"
date = 2019-06-25

[taxonomies]
tags = ["en-au", "books", "things i learnt", "cargo cult"]
+++

"[Cargo cult](https://en.wikipedia.org/wiki/Cargo_cult)" is a type of cult
which appeared in the Melanesia, in which the natives would build their copy
of an airplane (no motor, 'cause they didn't have the knowledge to build one
-- or even knew what went inside the airplane) in the hopes they would get the
same results as a real airplane.

<!-- more -->

In I.T., a "cargo cult" is the expectation that if you use the same tools as
some big players, you'd end up getting the same results.

One example: Netflix runs a large fleet of microservices daily; they use
Spring Cloud; if we use Spring Cloud, we can also run a large fleet of
microservices.

Although it may sound correct in a first glance, things are not like that.
There is much more to the Netflix fleet than just Spring Cloud.

Sometimes, cargo cult can appear in a form of "fanaticism" about celebrities:
[Fowler](https://en.wikipedia.org/wiki/Martin_Fowler_(software_engineer)) said
such and such pattern works this way and that's exactly what we should do.
Just because Fowler is well know software engineer and architect and do have
some very clever ideas, picking them and running exactly the way he described
may do more harm than good -- basically, 'cause you'd end up applying a
design pattern without worrying about solving your problem in the first place.

Another example: "ProductX is sponsored by BigCompany, so it's good". It may
be, but the fact that BigCompany is being ProductX doesn't immediately makes
ProductX good, or even if it fits your solution. And there is much more
[behind a product](/books/things-i-learnt/languages-are-more) than just its
development.

{{ chapters(prev_chapter_link="/books/things-i-learnt/languages-are-more", prev_chapter_title="A Language Is Much More Than A Language") }}
