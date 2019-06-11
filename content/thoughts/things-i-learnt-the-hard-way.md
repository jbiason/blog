+++
title = "Thing I Learnt The Hard Way (in 30 Years of Software Development)
date = 2019-06-10

[taxonomies]
tags = ["en-au", "programming", "work"]
+++

This is a cynical, clinical collection of things I learnt in 30 years working
with sofware development.

Again, some things are really cynical, others are long observations on
different jobs. 

<!-- more -->

## Software Development

### Learn to monitor

On a previous life, to understand how a system behaved, I added a ton of
metrics: how fast things were going in, how fast things were going out, how
many things were in the middle, how many the job processed...

It gives a really good view of how a system is behaving. Is the speed going
down? If it is, I can check what is going into the system to understand why. Is
it normal going down at some point?

Thing is, after this, it is really weird trying to figure out how "healthy" a
system without any monitoring is after that. Checking a system health with just
"Is it answering requests" doesn't fly anymore.

Adding monitoring early will help you understand how your system behaves.

### Unit tests are good, integration tests are gooder

On my current job, we do test modules and classes only (for example, we write
tests for the view layer only). It gives us some idea if things are going right
or not, but they lack a view of how the whole is going on -- a thing
integration tests, which tests how the system as a whole behaves -- do better.

### Tests make better APIs

We code in layers: There is the storage layer, which should make our data
permanent; there is a processing layer, which should do some transformation on
the data stored; there is a view layer, which has information on how the data
must be present; and so on.

As I mentioned, integration tests feel better, but testing layers by themselves
can give you a better view on how their API looks like. Then you can have a
better look on how to call things: Is the API too complex? Do you have to keep
to much data around to be able to make a single call?

### Future thinking is future trashing

When developers try to solve a problem, they sometimes try to find a way that
will solve all the problems, including the ones that may appear in the future.

But here is the thing: The problems from the future will never come and you'll
end up either having to maintain a huge behemot of code that will never be
fully used or you'll end up rewriting the whole thing 'cause there is a shitton
of unused stuff.

Solve the problem you have right now. Then solve the next one. And the next
one. At one point, you'll realize there is a pattern emerging from those
solutions and _then_ you'll find your "solve everything".

### Documentation is a love letter to your future self

We all know writing the damn docs for functions and classes and modules is a
pain in the backside. But realizing what you were thinking when you wrote the
function will save your butt in the future.

### The function documentation is its contract

When you start the code by writing the documentation, you're actually making a
contract (probably with your future self): I'm saying this function does _this_
and _this_ is what it does.

If later you find out that the code doesn't match the documentation, you have a
code problem, not a documentation problem.

## On a Team

### Code reviews are not fot style

Take your time on code reviews to point architectural or design problems, not
code style problems. Nobody really likes the person whose code reviews are only
"you left blanks in this line" or "missing space before parenthesis" and such.

Now, if you _do_ find architectural or design problems, _then_ you can add your
code style problems.

### Code formatting tools are ok, but they are no silver bullet

One thing a team may be tempted to do to avoid discussing style in code reviews
is to use a code formatting tool to auto-format code before commiting.

Now yeah, that kinda solves the problem, but there is one small problem:
we, humans, are not as flexibile to read code as computers are; what is
readable by a computer may not be readable by a human. Surely they try to
create some heristics on what is good for human reading, but that doesn't mean
it gets right.

If you _do_ use a code formatting tool, use it to find out where it changes the
code the most; you probably need to simplify that part of the code to avoid it
messing so much.
