+++
title = "Things I Learnt The Hard Way - Always Use UTF-8 For Your Strings"
date = 2019-07-01

[taxonomies]
tags = ["books", "things i learnt", "utf-8"]
+++

Long gone are the days where [ASCII](https://en.wikipedia.org/wiki/ASCII) was
enough for everyone. Long gone are the days where you can deal with strings
with no "weird" or "funny" characters.

<!-- more -->

I became a developer in a time when the only encoding we had was ASCII. You
could encode all strings in sequences of bytes, 'cause all characters you
could use where encoded from 1 to 255 (well, from 32 [space] to 93 [close
brackets] and you still have a few latin-accented characters in some higher
positions, although not all accents where there).

Today, accepting characters beyond that is not the exception, but the norm. To
cope with all that, we have things like
[Unicode](https://en.wikipedia.org/wiki/Unicode) and
[uTF-8](https://en.wikipedia.org/wiki/UTF-8) for encoding that in reasonable
memory space (UTF-16 is also a good option here, but that would depend on your
language).

So, as much as you to make your system simple, you will have to keep the
internal representation of your strings in UTF-8/UTF-16. You may not receive
the data as UTF-8/UTF-16, but you'll have to encode it and keep transmitting
it around as UTF-8/UTF-16 till you have to display it, at which point you'll
convert from UTF-8/UTF-16 to whatever your display supports (maybe it even
supports displaying in UTF-8/UTF-16, so you're good already).

Today, I believe most languages do support UTF-8, which is great. You
may still have problems with inputs coming from other systems that are not
UTF-8 (old Windows versions, for example), but that's fairly easy to convert
-- the hard part is figuring out the input _encoding_, though. Also, most
developers tend to ignore this and assume the input is in ASCII, or ignore the
input encoding and get a bunch of weird characters on their printing,
'cause they completely ignored the conversion on the output point. That's why
I'm repeating the mantra of UTF-8: To remind you to always capture your input,
encode it in UTF-8 and _then_ convert in the output.

One thing to keep in mind is that UTF-8 is not a "cost free" encoding as
ASCII: While in ASCII to move to the 10th character, you'd just jump 10 bytes
from the start of the string, with UTF-8 you can't, due some characters being
encoded as two or more bytes (you should read the Wikipedia page; the encoding
is pretty simple and makes a lot of sense) and, due this, you can't simply
jump 10 characters 'cause you may end up in second byte that represents a
single character. Walking through the whole string would require traversing
the string character by character, instead of simply jumping straight to the
proper position. But that's a price worth paying, in the long run.

{{ chapters(prev_chapter_link="/books/things-i-learnt/use-timezones", prev_chapter_title="Always Use Timezones With Your Dates", next_chapter_link="/books/things-i-learnt/optimization", next_chapter_title="Optimization Is For Compilers") }}
