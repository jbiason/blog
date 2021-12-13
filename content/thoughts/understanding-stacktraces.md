+++
title = "Understanding Stacktraces"
date = 2021-11-29
draft = true

[taxonomies]
tags = ["programming", "stack traces"]
+++

I've seen some people confused when their application crashes, spewing a bunch
of lines and they can't figure out what went wrong.

<!-- more -->

But let's start with something easier: What are stacktraces?

## The Turing Machine

To get what stacktraces are, let's start with the very beginning and talk about
Turing Machines.

Alan Turing, father of the computing, thought about having a long tape with
commands[^1] and a pointer that would move forwards or backwards according to
the command.

For example, imagine that you have the following sequence of commands:

- Take a piece of paper
- Fold it in half
- Unfold
- Move the bottom right corner so it touches the fold mark

... and so on (no, I'm not describing the whole process of making a paper
plane). Even if the actions are pretty simple, you can use something to point
which action you're taking so you know which one is the next one. Something
like:

- Take a piece of paper
- Fold it in half
- Unfold                       **<= I'm Here**
- Move the bottom right corner so it touches the fold mark

---

[^1]: Actually, the Turing Machine would compose a group of 0s and 1s to figure
    out a command, but let me simplify things a little bit.
