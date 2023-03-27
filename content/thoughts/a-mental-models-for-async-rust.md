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

## But first...

Before jumping into the model, I need to throw some other concepts that lead to
this model. It may seem a bit not related to async, but it will make sense in
the end (I hope 🙂).

### What's a mental model?

First of all, why do we need a mental model for something like that?

We'll, mental models help us put some "concretiveness" into some abstraction.
If we try to help ourselves trying to make some abstraction more concrete with
the wrong mental mental, the wrong result will come up.

And, in this case, I *did* start with the wrong mental model, try to create
something concrete with the async abstraction and end with the poor results.

### Windows 3 and Cooperative multitasking

People may not remember, but there was a magical time on the old DOS days when
you could not only have a graphical interface, but you could ALSO run more than
one application at the same time. 

That was done in a "shell" called... Windows.

But Windows 3 was not like Windows today. Today, Windows is a full OS, and it
makes every process "compete" against each other to have some time running. The
OS let an application run for some time, pauses it, unpauses another, let it
run for some time, pauses, switches to another, and so on[^1].

But Windows 3 had a different method to give time to different applications:
Instead of the OS saying "your time is over" the application itself must say
"Hey OS, if there is another process that wants to run, I yield my own
execution".

Besides the application saying that they allow another application to run, the
OS have some control points for them to yield control, like in the I/O calls.
While one application is waiting for a read or write to complete, either on
disk or socket, the OS would take care of when the operation completed and then
return control to the application.

### `epoll()`

`epoll()` is a little syscall that I had the chance to work with. In my case, I
had a networked application that could receive calls from two different
sources.

In blocking calls, the application would either wait for one or the other, but
waiting for one would make the other not happen (e.g., if the application would
block waiting for the first socket to receive some data and the second actually
did receive, nothing would happen, 'cause the whole application would still
wait for the first to actually send something). So, non-blocking receive was
necessary, but then you'd basically stay in a busy loop doing "Hey, socket 1,
do you have something? No, ok. Hey socket 2, do you have something? No, ok.
Hey, socket 1, do you have something?" and so on.

`epoll()`, on the other hand, let you throw a bunch of file description (which
can be used to identify files or sockets) and the kernel will wake your
application when *any* of them got some data. Now the application won't be
pushing the CPU usage too high 'cause it won't be doing anything till something
happens.

### "Greenthreads"

I think my initial problem started with naming. The concept of async/await
constructs is quite recent, but for a long time we've been talking about
"greenthreads" and "light-weight threads" -- "threads" that are managed by the
application and not the OS. While there are some differences between
greenthreads and async things, the naming stuck with me (and I *think* I saw
some posts linking the two).

### Rust and threads

Let's talk about Rust memory model for a second here. Rust emphasises memory
protection by giving regions of memory to owners; a region can only be owner by
one and only one owner and when the owner goes away, the memory is freed.
Nothing fancy.

This is particularly awesome when you're dealing with multi-threaded code, as a
region of memory can only belong to a price of code in one thread and other
threads can't mess with it. I think the greatest analogy for this behavior is
the explanation Miko Matsakis, which explained this using gifts:

Imagine you have a gift. You want to give it to someone, but while it is in
your hands, you can unwrap, replace the bow and paper, anything. But once you
*give* it to someone else's, that's their gift; it is up to them to unwrap,
replace bow and paper and whatnot.

The process of writing code in Rust with that control is sometimes annoying
when you're dealing with code that is not multi-threaded, but when you think
"What would happen if I run this in a separate thread?", then all the complains
make sense. You can even understand that the Rust compiler will not complain
when you end your main code in a loop or a `.join()`.

## A problem with naming

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

So you get this "async is thread" mentality due approximation. And then you try
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

One thing I believe I did right was to "metallize" the way the event loop works
akin to Windows 3.11, which was really prone to become completely unresponsive
from time to time. The reason for that is that the event loop keeps running
things till someone says "Ok, I give up my time and someone else can run their
stuff" -- a.k.a. "cooperative multitasking".

Async works akin to cooperative multitasking, but instead of having the
developer add a bunch of "event loop, you can run something else" statements,
this is done in I/O layer, for one simple reason: Your code would, normally,
block on those, and the event loop will take care of running this in a
non-blocking fashion.

## So, what the model, anyway?

You see, seeing task as threads is not the right thing to do. The way that made
everything make sense was to see tasks as **the elements being added to the
MPSC channel**.

--

[^1]: I'm purposely ignoring the fact that the OS may not unpause some
  application if it is waiting for a file to be read or some data appear in the
  networking, just for the sake of making things easier to explain.
