+++
title = "Rust in Real Life"
date = 2022-07-26

[taxonomies]
tags = ["rust"]
+++

For a while, I've been talking about Rust, making presentations, going to
meetups...

But a few months back I had the opportunity to finally work in a real
project in Rust.

So, how was it?

<!-- more -->

## Cargo is magic

The first application I used Rust was a small part of a bigger project. I had
to capture the values coming in a websocket and store them in a database.

There were two options for languages straight away: Python and C. Python was
being used in other parts of the company, so it would have more eyes in case
something went wrong. C was used in another application of the same project, so
I could keep the project itself in a single language. Both languages had a
couple of problems: I wasn't sure if Python could handle the load of a
continuous stream of the websocket and I didn't want to write my own websocket
and JSON parser in C.

And that's why I picked Rust for this application: I had the performance of C
with a very good package manager, plus a thousand packages already available.

So Cargo was the thing that drove the inclusion of Rust in the project. And the
language proved quite capable, as the application kept running to the point we
forgot it was running.

## `.unwrap()` is the enemy

I point in my presentations how you can do use `.unwrap()` (and `.expect()`) to
avoid dealing with errors, and although that would close your application, you
have total control on *where* it can close itself (compared to a
NullPointerException or reading NULL values or not capturing the proper
exceptions). But, in the end, `.unwrap()` will hurt you. Badly.

That happened in the second application I wrote: The main part of the
application was reading a bunch of bytes, and the meaning of those bytes were
in the bits themselves, in a combination of bitmap and UTF-8-like numbers. But
it wasn't simply parsing that was involved: There was a socket to be read, and
the parsed data should be stored in a database, and there were usually problems
involved in it -- the socket may be closed on the server side, we could lose
connectivity, the parser could produce weird values in case of a missed bit,
which couldn't be stored in the database...

For all the possible problems (which are pretty clear, as `Result` is the base
for almost everything), and because I was in a hurry to deliver the
application, I did use a lot of `.expect()` around -- again, with the idea
that, if it crashes, at least I told it it could crash, and it would give me a
somewhat traceable message. The reality is that issues happened with such
frequency (specially the parser receiving weird bits that would produce weird
values) that the application would not run for very long.

The solution to this constant crashes was quite simple, although laborious:
replace every `.unwrap()` and `.expect()` with `if let Ok(_)` and `match`. That
gave me total control on how to deal with unexpected values/results. The result
was that the application run without stop for days, to the point that we,
again, forgot it was running -- except when the data changed and we needed to
update our filters.

## Cargo again

In this second application, there were a bunch of little finicky things in the
protocol that were really hard to grasp. Fortunately, we captured some packets
from the service, which allow us to test the parser locally. All I needed was
something to give me a harness to throw those bits and see how the code would
process them.

With C, this would probably mean building another executable for testing and
running it instead of the real executable (and, to be honest, that's what Rust
does) but Cargo hid all the complexities of getting this done. I just dropped a
`test.rs` into my modules, marked it as `#[cfg(test)]` (meaning, build this
only if the configuration is the test configuration), and `cargo test` would
build the code and run the tests.

The fact that I had a testing framework and a test runner just there was a huge
helper, specially when thing broke down.

## Should've `try`ed more

One of the side-effects of switching every `.unwrap()` and `.expect()` for some
explicit error management was the increase in indentation -- 'cause *all* I did
was do this replace, but I did not break things into smaller functions.

Rust have the `try` operator -- `?` -- but that requires that the function
using it should return a `Result`, which I kinda neglected in the first pass
'cause, well, the only exit on all functions was success, and failure meant
`panic!()` (due `.unwrap()`).

If I was using `Result` as return values from the start, I have the impression
that the code would not be a mess of 7-8 indentation levels. So, another thing
I would have "gained" if I hadn't used `.unwrap()`.

## Async doesn't make sense till it does

The third application in the project required a lot of I/O -- reading from
multiple databases, sending data through a socket, writing again in the
database... It seemed a perfect fit for an async experiment.

In the initial version I wrote, I used tasks (async functions) the same way I
did with threads. It initially produced a bunch of errors from the borrow
checker that I couldn't figure out why -- at this point, I could understand
exactly why the borrow checker complained about something in an application
using threads, but the errors were really confusing, to the point that I may
have mentioned that "async is unnatural for Rust". And, when I did manage to
avoid the borrow checker complaints, the performance was... abysmal. Something
like 0.8 records processed per second, which was extremely low for what we
expected.

Due this bad performance, I removed all the async things and used threads. That
was in my ballpark -- I knew what I did wrong when the borrow checker
complained -- and the performance did improve: Now it was processing 7 records
per second.

During the rewrite, I kept reading about async and how it works, till I came
with a mental model to work with async (more about this in a future post). I
did managed to take some time later to actually apply this mental model -- and
then the errors from the borrow checker made sense, and I felt productive
again. The result? 70 records per second, a whole 10x improvement from simple
threads.

## Conclusion

All that I learnt in a space of 6 months. I ended up switching jobs to a place
that doesn't have anything in Rust (yet 😈), and although the road for Rust is
a bit steep and with some tight corners, it is still worth going.

(And, as far as I know, all those applications are *still* running...)
