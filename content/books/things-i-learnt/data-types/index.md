+++
title = "Things I Learnt The Hard Way - Types Say What You Data Is"
date = 2019-06-24

[taxonomies]
tags = ["en-au", "books", "things i learnt", "types"]
+++

Memory is just a sequence of bytes; bytes are just numbers from 0 to 255; what
those numbers mean is described on the language type system.

<!-- more -->

For example, in C, a `char` type of value 65 is most probably the letter "A",
which an `int` of value is 65 is the number 65.

Remember this when dealing with your data.

And it doesn't matter of your language of choice uses dynamic typing or static
typing. The same still applies.

One classic example of misusing types is adding booleans. Booleans are either
`true` or `false`, but because most languages follow C, which doesn't have a
boolean type and uses compiler pre-processors to define `TRUE` as an integer
with the value `1` and `FALSE` with another integer with the value `0`. Newer
languages were build on top of what older developers knew, and so, a bunch of
those languages also assumed using an integer under booleans was a good idea.
And even today, with modern languages, people rely on those old methods.

Let me repeat that: You're adding booleans and expecting a number -- only
because in the old times there wasn't boolean types.

No, you're counting the number of elements in the list 'cause that would see
the whole list. You're not even filtering the false values over and counting
the resulting list size. You're jumping the underlying type to get a bit of
performance out.

Fortunately, some new languages are using booleans as a complete different
type and wouldn't allow this kind of stuff.

{{ chapters(prev_chapter_link="/books/things-i-learnt/handle-it", prev_chapter_title="If You Know How To Handle It, Handle It", next_chapter_link="/books/things-i-learnt/use-structures", next_chapter_title="If Your Data Has a Schema, Use a Structure") }}
