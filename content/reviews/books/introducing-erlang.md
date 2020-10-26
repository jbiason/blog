+++
title = "Introducing Erlang: Getting Started in Functional Programming - Simon St. Laurent"
date = 2020-08-05
updated = 2020-10-26

[taxonomies]
tags = ["books", "reviews", "simon st laurent", "erlang", "it", 
"2020 challenge", "2 stars"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/15811999-introducing-erlang):
If you’re new to Erlang, its functional style can seem difficult, but with
help from this hands-on introduction, you’ll scale the learning curve and
discover how enjoyable, powerful, and fun this language can be.

<!-- more -->

{{ stars(stars=2) }}

Again, an "Introducing" book that one shouldn't expect some deep explanations,
but heck, this felt shallower than [Introducing
Elixir](@/reviews/books/introducing-elixir.md).

It follows the same path of the "Introducing Elixir" (or maybe it is the other
way around, but hey, that's the order I read both), by creating a "what speed
will something crash if dropped in different planets" library and exploring
changes.

But the biggest drawback is that the book sticks too much into the Erlang
Shell and absolutely nothing (besides "here is one thing you can search for")
outside it. I mean, sure, the language may be nice and fun and all that, but
what's the point if the build tool is a pain and dependency resolution is
inexistent -- and I'm not saying Erlang suffers from that, 'cause as a
learning path, the book says _nothing_ about those things.

For seeing how the language looks like, it's a good book. For something more
_real_... far away from it.

## Highlights

>  go to the command line and type erl 

*Note*: `erl` is the Erlang Shell.

>  3> 2#1010111. 

*Note*: Binary notation.

>  4> 16#cafe 

*Note*: Hex notation.

>  FallVelocity = fun(Distance) -> math:sqrt(2 * 9.8 * Distance) end.

*Note*: `fun` creates an anonymous function; it is then associated with the
name `FallVelocity` (all variables need to start with an upcase letter).

>  -module(drop).<br>
>  -export([fall_velocity/1, mps_to_mph/1, mps_to_kph/1]).<br><br>
>  fall_velocity(Distance) -> math:sqrt(2 * 9.8 * Distance). <br>
>  mps_to_mph(Mps) -> 2.23693629 * Mps.<br>
>  mps_to_kph(Mps) -> 3.6 * Mps.

>  -module(combined).<br>
>  -export([height_to_mph/1]).<br>
>  -import(drop, [fall_velocity/1]).<br>
>  -import(convert, [mps_to_mph/1]).<br>
>  height_to_mph(Meters) -> mps_to_mph(fall_velocity(Meters)). 

>  In Erlang, greater-than-or-equal-to is written as >=, and
>  less-than-or-equal-to as =<. Don’t make them look like arrows. 

>  try <br>
>    math:sqrt(2 * Gravity * Distance) <br>
>  catch <br>
>    error:Error -> {error, Error} end.

>  Creating a map requires a different syntax presenting keys and values:<br>
>  1> Planemos = #{ earth => 9.8, moon => 1.6, mars => 3.71 }.<br>
>  #{earth => 9.8,mars => 3.71,moon => 1.6} 
