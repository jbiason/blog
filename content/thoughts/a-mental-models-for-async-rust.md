+++
title = "A Mental Model for Async Rust"
date = 2022-07-29
draft = true

[taxonomies]
tags = ["rust", "async"]
+++

When I tried to do async Rust, I got a bunch of errors from the borrow checker
that, to me, it didn't make sense -- and wouldn't be an issue if I was using
threads.

It took me awhile to figure out a mental model for doing it right.

<!-- more -->

## A problem with naming

I think my initial problem started with naming. The concept of async/await is
quite recent, but for a long time we've been talking about "greenthreads" and
"light-weight threads" -- "threads" that are managed by the application and not
the OS. While there are some differences between greenthreads and async things, 
the naming stuck with me (and I *think* I saw some posts linking the two).

Still on naming, [Tokio](https://tokio.rs/), the most popular async framework
in Rust, uses `task::spawn` to spawn a new task, which is pretty close to the
thread call, `thread::spawn` -- and both return a structure called 
`JoinHandle` -- so this mixture of "tasks/greenthreads are threads" got pretty
ingrained to me.

{% note() %}
Yeah, yeah, other languages avoid this by using their own words, but my contact
with async was with Rust, so...
{% end %}

## A problem with structure

So you get this "async is thread" mentality due aproximation. And then you try
to build something async using the same model.

For example, a producer/consumer in Rust would be something like:

```rust
use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();
    let self_tx = tx.clone();

    let consumer = thread::spawn(move || {
        while let Ok(msg) = rx.recv() {
            println!("Message: {}", msg);

            if msg > 1000 {
                // actually, we just need to drop self_tx, otherwise the consumer will keep waiting
                // for inputs from it, even when tx was already dropped when the producer ended.
                // the problem with a direct drop is that rustc can't see that it won't be used
                // anymore.
                break;
            } else if msg % 2 == 0 {
                if self_tx.send(msg * 2).is_err() {
                    println!("Failed to push new value to consumer");
                    break;
                };
            }
        }
    });

    let producer = thread::spawn(move || {
        for i in 1..12 {
            if tx.send(i).is_err() {
                println!("Failed to send {}, ending producer", i);
                break;
            }
        }
        // tx.send(0);
    });

    producer.join().unwrap();
    consumer.join().unwrap();
}
```

(Yeah, I did all in a single file. Sue me.)

Quick explanation: Here, there are two threads, one for the producer and one
for the consumer; the MPSC (Multiple Producer, Single Consumer) channel is the
communication channel between those two. With the exception that it has only
one consumer, it is pretty close to the way I learnt producer/consumer
architecture at uni (not in Rust, but C, using mutexes).

## Where it falls apart

Now, the first thing one would do, knowing about "greenthreads" and
`tokio::spawn` is just to replace `thread::spawn` for the Tokio API and think
it is done.

And that's where my initial mental model broke down.

'Cause, you see, async is not the threads; **async is the channel**. And by
that I mean that each task is put in a queue (the event loop queue) and then
processed. Instead of just having data (in our example, an integer), it has
data and code; the code is the task and the data is whatever Rust moves into
the task.

## I saw multitasking correctly

One thing I believe I did right was to "mentalize" the way the event loop works
akin to Windows 3.11, which was really prone to become completely unresponsive
from time to time. The reason for that is that the event loop keeps running
things till someone says "Ok, I give up my time and someone else can run their
stuff" -- a.k.a. "cooperative multitasking".

Async works akin to cooperative multitasking, but instead of having the
developer add a bunch of "event loop, you can run something else" statements,
this is done in I/O layer, for one simple reason: Your code would, normally,
block on those, and the event loop will take care of running this in a
non-blocking fashion.

## 
