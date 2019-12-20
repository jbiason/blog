+++
title = "Things I Learnt The Hard Way (in 30 Years of Software Development)"
date = 2019-06-10

[taxonomies]
tags = ["programming", "work"]
+++

This is a cynical, clinical collection of things I learnt in 30 years working
with software development.

Again, some things are really cynical, others are long observations on
different jobs.

<!-- more -->

## Software Development

### Spec first, then code

If you don't know what you're trying to solve, you don't know what to code.

Write something specifying how the application works before writing any code.

"Without requirements or design, programming is the art of adding bugs to an
empty text file." -- Louis Srygley

Sometimes, even an "elevator pitch" -- up to two paragraphs that describe what
the application does -- is enough.

The times I stood longer looking at my own code wondering what to do next were
when we didn't have the next step defined. It is a good sign that it's time to
stop and discuss it with your coworkers -- or maybe rethink the solution.

### Write steps as comments

If you have no idea how to start, describe the flow of the application in high
level, pure English/your language first. Then fill the spaces between comments
with the code.

Better yet: think of every comment as a function, then write the function that
does exactly that.

### Gherkin is your friend to understand expectations

Gherkin is a test description format which points "Given that the system is in
a certain state, When something happens, then this is expected". Even if
you don't use any testing tool that reads Gherkin, it will give you a good
understanding of what it is expected from the app.

### Unit tests are good, integration tests are gooder

On my current job, we do test modules and classes only (for example, we write
tests for the view layer only, then tests for the controller layer only, and so
on). It gives us some idea if things are going right or not, but they lack a
view of how the whole is going on -- a thing integration tests, which tests how
the system as a whole behaves -- do better.

### Tests make better APIs

We code in layers: There is the storage layer, which should make our data
permanent; there is a processing layer, which should do some transformation on
the data stored; there is a view layer, which has information on how the data
must be present; and so on.

As I mentioned, integration tests feel better, but testing layers by themselves
can give you a better view on how their API looks like. Then you can have a
better look on how to call things: Is the API too complex? Do you have to keep
to much data around to be able to make a single call?

### Make tests that you know how to run on the command line

Not that command lines are important for any projects, but when you know the
command to run the tests, you know how to automate the execution of the tests,
which you then can use in a continuous integration tool.

### Be ready to throw your code away

A lot of people, when they start with TDD, get annoyed when you say that you
may have to rewrite a lot of stuff, including whatever your already wrote.

TDD was _designed_ to throw code away: The more you learn about your problem,
the more you understand that, whatever you wrote, won't solve the problem in
the long run.

You shouldn't worry about this. Your code is not a wall: if you have to throw
it always, it is not wasted material. Surely it means your time writing code
was lost, but you got a better understanding about the problem now.

### Good languages come with integrated tests

You can be sure that if a language brings a testing framework -- even minimal
-- in its standard library, the ecosystem around it will have better tests
than a language that doesn't carry a testing framework, no matter how good the
external testing frameworks for the language are.

### Future thinking is future trashing

When developers try to solve a problem, they sometimes try to find a way that
will solve all the problems, including the ones that may appear in the future.

But here is the thing: The problems from the future will never come and you'll
end up either having to maintain a huge behemoth of code that will never be
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

### If a function description includes an "and", it's wrong

Functions should do one thing and one thing only. When you're writing the
function documentation and find that you added an "and", it means the function
is doing more than one thing. Break that function into two and remove the
"and".

### Don't use Booleans as parameters

When you're designing a function, you may be tempted to add a flag. Don't do
this.

Here, let me show you an example: Suppose you have a messaging system and you
have a function that returns all the messages to an user, called
`getUserMessages`. But there is a case where you need to return a summary of
each message (say, the first paragraph) or the full message. So you add a
flag/Boolean parameter called `retrieveFullMessage`.

Again, don't do that.

'Cause anyone reading your code will see `getUserMessage(userId, true)` and
wonder what the heck that `true` means.

You can either rename the function to `getUserMessageSummaries` and have
another `getUserMessagesFull` or something around those lines, but each
function just call the original `getUserMessage` with true or false -- but the
interface to the outside of your class/module will still be clear.

But _don't_ add flags/Boolean parameters to your functions.

### Beware of interface changes

In the point above, I mentioned about renaming the function. If you control
the whole source where the function is used, that's not issue, it's just a
matter of search and replace.

But if that function is actually exposed by a library, you shouldn't change
function names in a whim. That will break a lot of other applications beyond
your control and make a lot of other people unhappy.

You can create the new functions and mark the current one as deprecated,
either by documentation or by some code feature. Then, after a few released,
you can finally kill the original function.

(A dickish move you can do is to create the new functions, mark the current
function as deprecated and _add a sleep at the start of the function_, in a
way that people using the old function are forced to update.)

### Good languages come with integrated documentation

If the language comes with its own way of documenting
functions/classes/modules/whatever and it comes even with the simplest doc
generator, you can be sure that all the language
functions/classes/modules/libraries/frameworks will have a good documentation
(not great, but at least good).

Languages that do not have integrated documentation will, most of the time,
have a bad documentation.

### A language is much more than a language

A programming language is that thing that you write and make things "go". But
it has much more beyond special words: It has a build system, it has a
dependency control system, it has a way of making tools/libraries/frameworks
interact, it has a community, it has a way of dealing with people.

Don't pick languages just 'cause they easier to use. Always remember that you
may approve the syntax of a language for being that easy, but you're also
enabling the way maintainers deal with the community by choosing that language.

### Sometimes, it's better to let the application crash than do nothing

Although that sounds weird, it's better to not add any error handling than
silently capturing errors and doing nothing.

A sadly common pattern in Java is

```java
try {
  something_that_can_raise_exception()
} catch (Exception ex) {
  System.out.println(ex);
}
```

This does nothing to deal with the exception -- besides printing it, that is.

If you don't know how to handle it, let it happen,so you can figure out _when_
it will happen.

### If you know how to handle the issue, handle it

Counter-point to the previous point: If you know when something will raise an
exception/error/result and you know how to handle it, handle it. Show an error
message, try to save the data somewhere else, capture the user input in a log
file to later processing, but _handle_ it.

### Types say what you data is

Memory is just a sequence of bytes; bytes are just numbers from 0 to 255; what
those numbers mean is described on the language type system.

For example, in C, a `char` type of value 65 is most probably the letter "A",
which an `int` of value is 65 is the number 65.

Remember this when dealing with your data.

This is what most people get wrong about adding booleans to check the number
of True values. Here, let me show you an example of JavaScript that I saw
recently:

```javascript
console.log(true+true === 2);
> true
console.log(true === 1);
> false
```

### If your data has a schema, use a structure to keep it

You may be tempted to use a list (or tuple, if your language allows) to keep
your data if it's simple -- like, say, only 2 fields.

But if you data has a schema -- it has a fixed format -- you should _always_
use some structure to keep it, but it a `struct` or a `class`.

### Understand and stay way of cargo cult

"Cargo cult" is the idea that, if someone else did, so can we. Most of the
time, cargo cult is simply an "easy way out" of a problem: Why would we think
about how to properly store our users if X did that?

"If BigCompany stores data like this, so can we".

"If BigCompany is behind this, this is good."

### "Right tool for the job" is just to push an agenda

"Right tool for the job" should be an expression that meant that there is a
right and a wrong tool to do something -- e.g., using a certain
language/framework instead of the current language/framework.

But every time I heard someone mention it, they were trying to push their
favourite language/framework instead of, say, the right language/framework.

### "The right tool" is more obvious than you think

Maybe you're in a project that needs to process some text. Maybe you're
tempted to say "Let's use Perl" 'cause you know that Perl is very strong in
processing text.

What you're missing: You're working on a C shop. Everybody knows C, not Perl.

Sure, if it is a small, "on the corner" kind of project, it's fine to be in
Perl; if it is important for the company, it's better that if it is a C
project.

PS: Your hero project (more about it later in this doc) may fail due this.

### Don't mess with things outside your project

Sometimes people are tempted to, instead of using the proper extension tools,
change external libraries/frameworks -- for example, making changes directly
into WordPress or Django.

This is an easy way to make the project unmaintainable really really fast. As
soon as a new version is released, you'll have to keep up your changes in sync
with the main project and, pretty soon, you'll find that the changes don't
apply anymore and you'll leave the external project in an old version, full of
security bugs.

### Data flows beat patterns

(This is personal opinion) When you understand how the data must flow in your
code, you'll end up with better code than if you applied a bunch of design
patterns.

### Design patterns are used to describe solutions, not to find them

(Again, personal opinion) Most of the time I saw design patterns being
applied, they were applied as a way to find a solution, so you end up twisting
a solution -- and, sometimes, the problem it self -- to fit the pattern.

First, solve your problem; find a good solution; then you can check the
patterns to know how you name that solution.

I saw this happens _a lot_: We have this problem; a design pattern gets close
to the proper solution; let's use the design pattern; now we need to add a lot
of things around the proper solution to make it fit the pattern.

### Learn the basics functional programming

You don't need to go deep into "what is a monad" and "is this a functor". But
remember to not keep changing your data all the time, create a new element
with the new values (treat your data as immutable) and make functions/classes
that don't keep some internal state (pure functions/classes) if possible.

### Cognitive Cost is the readability killer

"[Cognitive dissonance](https://en.wikipedia.org/wiki/Cognitive_dissonance)" 
is a fancy way of saying "I need to remember two (or more) different things at
the same time to understand this." Keeping those different things in your head
creates a cost and it keeps accumulating the more indirect the things are
('cause you'll have to keep all those in your head).

For example, adding booleans to count the number of True values is a mild
cognitive dissonance; if you're reading a piece of code and see a `sum()`
function, which you know makes the sum of all numbers in a list, you'd expect
the list to be composed of numbers, but I've seen people using `sum()` to
count number of True values in a list of booleans, which is confusing as heck.

### The Magical Number Seven, Plus or Minus Two

"[The magical number](https://en.wikipedia.org/wiki/The_Magical_Number_Seven,_Plus_or_Minus_Two)" 
is a psychology article about the number of things one can keep in their mind
at the same time.

If you have a function, that calls a function, that calls a function, that
calls a function, that calls a function, that calls function, you may be sure
it will be a hell to read later.

Think more about: I'll get the result of this function, then pass it to the
second function, get its result, pass to the third an so on.

But:

1. Today, psychologists talk more about the magical number FOUR, not seven.
2. Think function composition (as in "I'll call that function, then that
   function, then that function..."), not function calling (as in "That
   function will call that function, that will call that function...").

### Shortcuts are nice, but only in the short run

A lot of languages/libraries/frameworks add a way to make things shorter,
reducing the number of things you need to type.

But, later, that will bite you and you'll have to remove the shortcut and do
the long things.

So learn what the shortcut does before using it.

You don't need to write things the hard way first and then clean up using the
shortcuts: All you need to do is what the shortcut does in the background, so
you at least have knowledge of what can go wrong using it, or how to replace
it with the non-shortcut version.

### Resist the temptation of "easy"

Sure that IDE will help you with a ton of autocomplete stuff and let you
easily build your project, but do you understand what's going on?

Do you understand how your build system works? If you had to run it without
the IDE, would you know how?

Can you remember your function names without autocomplete? Isn't there a way
to break/rename things to make them easier to understand?

Be curious about what goes behind the curtains.

### **ALWAYS** use timezones with your dates

When dealing with dates, always **always** add the timezone with it. There
will be _always_ a problem with your computer timezone and the production
server timezone (or one of the instances timezones) and you'll lose a lot of
time trying to debug what the heck the interface is showing the wrong time.

### **ALWAYS** use UTF-8

The same problem you'll have with dates, you'll have with character encoding.
So always convert your strings to UTF8; save them in the database as UTF8;
return UTF8 on your APIs.

(You may convert to any other encoding, but UTF8 won the encoding wars, so it
is easier to keep it this way.)

### Start stupid

One way to get away from the IDE is to "start stupid": Just get the compiler
and get an editor (ANY editor) with code highlight and do your thing: Code,
build it, run it.

No, it's not easy. But when you jump into some IDE, you'll think of buttons of
simply "Yeah, it runs that" (which is exactly what IDEs do, by the way.)

### Logs are for events, not user interface

For a long time, I used logs to show the user whatever was happening --
'cause, you know, it's a lot easier to use a single thing instead of two.

Use the standard output to inform the user of events, standard err to inform
the user about errors but use logs to capture something that you can later
process easily.

Think about logs of something you'll have to parse to extract some information
at that time, not user interface; it doesn't have to be human-readable.

### Debuggers are over-rated

I heard a lot of people complaining that code editors that don't come with
debugging are terrible, exactly because they don't come with debugging.

But when your code is in production, you _can't_ run your favorite debugger.
Heck, you can't even run your favourite IDE. But logging... Logging runs
everywhere. You may not have the information you want at the time of the crash
(different logging levels, for example) but you _can_ enable logging to figure
out something later.

(Not saying debuggers are bad, they just not as helpful as most people would
think.)

### Always use a Version Control System

"This is my stupid application that I just want to learn something" is not
even a good excuse to not use a version control system.

If you start using a VCS right from the start, it will be easier to roll back
when you do something stupid.

### One commit per change

I've seen people writing commit messages like "Fixes issues #1, #2 and #3".
Unless all those issues are duplicates -- in which two of those should be
already closed -- they should be 3 commits, not one.

Try to keep a change in a single commit (and by change I don't mean "one file
change"; if a change requires changes in three files, you should commit those
three files together. Think "if I revert this back, what must go away?")

### "git add -p" is your friend when you overchange

(Git topic only) Git allows merging a file partially with "-p". This allows
you to pick only the related changes and leave the other behind -- probably
for a new commit.

### Organize projects by data/type, not functionality

Most projects keep an organization like:

```
.
+-- IncomingModels
|   +-- DataTypeInterface
|   +-- DataType1
|   +-- DataType2
|   +-- DataType3
+-- Filters
|   +-- FilterInterface
|   +-- FilterValidDataType2
+-- Processors
|   +-- ProcessorInterface
|   +-- ConvertDataType1ToDto1
|   +-- ConvertDataType2ToDto2
+-- OutgoingModels
    +-- DtoInterface
    +-- Dto1
	+-- Dto2
```

in other words, they keep data organized by functionality (all the incoming
models are in the same directory/package, all the filters are in the same
directory/package and so on).

This is fine and works. But when you organize by data, it'll make a lot easier
to split your project in smaller projects -- 'cause, at some point, you may
want to do almost the same thing as you're doing right now, but with small
differences.

```
.
+-- Base
|   +-- IncomingModels
|   |   +-- DataTypeInterface
|   +-- Filters
|   |   +-- FilterInterface
|   +-- Processors
|   |   +-- ProcessorInterface
|   +-- OutgoingModels
|       +-- DtoInterface
+-- Data1
|   +-- IncomingModels
|   |   +-- DataType1
|   +-- Processors
|   |   +-- ConvertDataType1ToDto1
|   +-- OutgoingModels
|       +-- Dto1
...
```

Now you can make a module that deals _only_ with Data1, another that works
only with Data2 and so on. And then you can break them into isolated modules.

And then when you have another project that also have Data1 but also deals
with Data3, you can reuse most of the stuff in the Data1 module.

### Create libraries

I've seen a lot of projects that either make a mega repository with different
projects or keep different branches that instead of just being a temporary
environment for later joining the main development area, are just to keep that
small, different thing going (picking the point above about modularization,
imagine that instead of building a new project that reuse the Data1 type, I
have a branch that has a completely different main function and the Data3
type).

Why not split the common parts into libraries and require it in different
projects?

The reason is, most of the time, 'cause people don't know how to either
create libraries or they worry how they are goint to "publish" those libraries
into the dependency sources without giving it around (so maybe it's a good
idea to also understand how your project management tool retrieves
dependencies, so you can create your own dependency repository).

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

### The config file is friend

Imagine you wrote a function that you have to pass a value for it to start
processing (say, a twitter user account id). But then you have to do that with
two values and you just call the function again with the other value.

It makes more sense to use a config file and just run the application twice
with two different config files.

### Command line options are weird, but helpful

If you move things to config files, you could also help your users by adding
an option to select the config file and expose it.

There are libraries to handling command line options for every language today,
which will help you into building a good command line and giving your users a
standard interface for everything.

### Not just function composition, but application composition

Unix came with the idea of "applications that do one thing and do it well".

Now, I said you could use one application with two config files, but what if
you need the result of both applications?

That's when you can write an application that reads the results of the first
one with both config files) and turn into a single result.

### Even for app composition, start stupid

Application composition may lead to microservices -- which is good -- but
microservices require some ideas about how applications "talk" between them
over the wire (protocols and such).

You don't need to start with that. Both applications can write and read from
files, which is way easier.

Worry about talking over the wire later, when you understand how networks
work.

### Optimization is for compilers

Let's say you need more performance. You may be tempted to look at your code
and thing "where I can squeeze a little bit more performance here" or "How can
I remove a few cycles here to get more speed".

Well, guess what? Compilers _know_ how to do that. Smarted compilers can even
delete your code 'cause it will always generate the same result.

What you need to do is think a better _design_ for your code, not how to
improve the current code.

Code is humans to read. _ALWAYS_. Optimization is what compilers do. So find a
smarted way to explain what you're trying to do (in code) instead of using
shorter words.

### By lazy (evaluated)

A long time ago, a small language made the rounds by not evaluating
expressions when they appeared, but when they were needed.

Lisp did this a long time ago, and now most languages are getting it too.

For example, Python have the `yield` statement, which will stop the execution
of the current function and return the value immediately, `yield`ing a new
value only when the function is called again. If you chain functions that keep
`yield`ing results, you won't need as much memory as functions that keep
returning lists.

## On a Team/Work

### Code reviews are not for style

Take your time on code reviews to point architectural or design problems, not
code style problems. Nobody really likes the person whose code reviews are only
"you left blanks in this line" or "missing space before parenthesis" and such.

Now, if you _do_ find architectural or design problems, _then_ you can add your
code style problems.

### Code formatting tools are ok, but they are no silver bullet

One thing a team may be tempted to do to avoid discussing style in code reviews
is to use a code formatting tool to auto-format code before committing.

Now yeah, that kinda solves the problem, but there is one small problem:
we, humans, are not as flexible to read code as computers are; what is
readable by a computer may not be readable by a human. Surely they try to
create some heuristics on what is good for human reading, but that doesn't mean
it gets right.

If you _do_ use a code formatting tool, use it to find out where it changes the
code the most; you probably need to simplify that part of the code to avoid it
messing so much.

### Code style: Follow it

If your project have a defined code style, you must follow it. Sometimes it
may not be clear ("this struct/class should be singular or plural"?), but do
your best to follow it.

### ... unless that code style is the Google Code style

(Totally personal opinion, feel free to disagree) Every freaking time Google
comes with their own coding style, it's a garbage fire. The community came
with a better style way before and Google seem to come with a style with high
contrasting parts just to call it theirs.

### There is only one coding style for C/C++: K&R

(Totally personal opinion again) Every other coding style is _WRONG_. :)

### There is only one coding style for Python: PEP8

The community (most of it) writes code in PEP8. Follow it and your code
smoothly integrate with the rest of the ecosystem.

### Explicit is better than implicit

You know what's one of the worst function names ever? `sleep()`.

Sleep for how long? It is seconds or milliseconds?

Be explicit with what you use; `sleepForSecs` and `sleepForMs` are not
perfect, but are better than `sleep`.

(Think about this when you're writing your app command line interface or its
config file.)

(I could throw the whole "Zen of Python" here, but I'm trying to focus on
personal, direct experience.)

### Companies look for specialists but keep generalists longer

If you know a lot about one single language, it may make it easier to get a
job, but in the long run, language usage dies and you'll need to find
something else. Knowing a bit about a lot of other languages helps in the long
run, not to mention that may help you think of better solutions.

"A language that doesn't affect the way you think about programming, is not
worth knowing." -- Alan Perlis

For a long time, I kept a simple programming rule: The language I'm playing at
home should not be the same language I'm using at work. This allowed me to
learn new things that later I applied in the work codebase.

I learnt how generics work in Java by writing Rust code; I understood how
Spring does dependency injection by reading how to do it in C++.

### Think of the users

Think how the data you're collecting from your users will be used -- this is
more prevalent on these days, where "privacy" is a premium.

If you capture any used data, remember to protect it against unauthorized use.

### The best secure way to deal with user data is not to capture it

You can be sure that, at some point, the data will leak, either by some
security flaw or human interference.

If you don't capture any user data -- or store it in anonymized way -- you
won't have any problems.

### Keep a record of "stupid errors that took me more than 1 hour to solve"

I tried but never managed to create a list of stupid errors I kept finding
that took more than 1 hour to solve it, which were simply "forgot to add
dependency" or "add annotation", mostly because there was more than once that
I kept fighting some stupid error for more than 1 hour.

But you should try to keep a list of stupid errors that took you 1 hour to
solve, 'cause later you can use it to not stay more than 1 hour to solve some
stupid error.

### If it doesn't run on your computer, you have a problem

I've seen a lot of systems that would never run on a isolated computer, like
the developer tool, 'cause the system requires running on a specialized
environment.

This is something that really kills productivity.

If your system will run on a specialized environment -- and I'm including "the
cloud" here -- look for something that can abstract whatever you're using. For
example, if you're using AWS SQS, which is a queue, look for a library that
can abstract the way a queue works so you can also run with RabbitMQ, which
can be easily run on your own computer.

If you're using a very specialized thing, you may have to write the
abstraction yourself, isolating it from the main system, so you can develop
the main product in peace.

## Personal

### When it's time to stop, it's time to stop

Learn when you can't code anymore. Learn when you can't process things anymore.
Don't push beyond that, it will just make things worse in the future.

I tried to keep coding once when I had a migraine (not strong, but not mild).
Next day, when I was better, I had to rewrite most of the stuff I did, 'cause
it was all shit.

### Code of conduct protect _you_, not _them_

When you're beginning with any language/library/framework, check their CoC;
they will protect _you_ from being harassed for not immediately getting what
is going on instead of blocking you from telling them what you think.

I'm mentioning this 'cause a lot of people complain about CoC, but they
forget that they allow them to join in any project without being called
"freaking noob" or "just go read the docs before annoying us".

Also, remember that most people that are against CoCs are the ones that want
to be able to call names on everyone.

### Learn to say no

Sometimes, you'll have to say no: No, I can't do it; no, it can't be made in
this time; no, I don't feel capable of doing this; no, I don't feel
comfortable writing this.

Once I had to say to our CTO: "Ok, I'll do it, but I want to note that I don't
agree with what we are doing." In the end, the app was barred exactly because
the thing we were doing.

### You're responsible for the use of your code

This is hard. Very very hard. It's the difference between "freedom" and
"responsibility".

There is nothing wrong in writing, for example, a software to capture people's
faces and detect their ethnicity, but you have to think about what that will
be used on.

### Don't tell "It's done" when it's not

You are tired of running the same thing over and over again. You kinda
remember that something weird may happen, but because you're tired, you tell
everyone that "It's finished".

Don't do that.

Someone will try that weird case on the first run and immediately tell you
that it is _not_ working.

### You'll learn about yourself the hard way

We get frustrated with code that doesn't compile. We get angry with customers
asking things back and forth.

And we lash out on other when that happens.

And that will get you in trouble.

It happens.

### People get pissed/annoyed about code/architecture because they care

You'll find yourself in the other side of the coin: You'll describe some
solution and people will seem annoyed/pissed about some solution.

When people care about a product/code, they do that.

"Yeah, you don't like that hushed solution 'cause you care" was one of the
nicest things someone told about myself.

### Learn from your troubles

You'll get annoyed, pissed, frustrated, and angry. You'll get you in trouble.
You'll see people getting in trouble because of this kind of stuff.

You must learn about it. Don't ignore it.

One thing I learnt the hard way was that I get really aggressive when I'm
frustrated. Now, when I notice I start to get frustrated, I ask help from
someone else. It's really therapeutic to see that someone else also struggles
with your problem, and that's not just you.

### Pay attention on how people react to you

I have a "angry man resting face" kind of face.

Sometimes I'll ask things and people will move a bit back -- like I'm telling
them their solution is wrong.

That's when I have to add "I'm not saying it's wrong, I'm just confused".

That _may_ help you to not get in trouble.

### Learn to recognize toxic people; stay away from them

You'll find people that, even if they don't small talk you, they will bad
mouth everything else -- even some other people -- openly.

Stay away from those people.

You have no idea how that kind of attitude will drive you down.

### Beware of micro-aggressions

"Micro-aggressions" are aggressive comments in small doses. Like someone that
keeps calling you "_that_ person" or seemingly innocuous comments about your
position in some policy.

Those are hard to fight, 'cause PR won't listen to you saying that they are
attacking you. Also, they are hard to detect, 'cause they seem small enough,
but they do pile up and you'll blow your anger all at once.

Better just stay away and avoid contact as possible.

### No, I don't think they are "fixable"

(Personal opinion) Someone could say "Hey, maybe if you spoke to that person,
they would stop".

Personally, I don't think they would. This kind of stuff is going for so long
to them that it feels natural and, most of the time, you're the wrong one (for
not seeing that they are joking, for example, in true "Schrödinger's asshole"
style.)

### Toxic/micro-aggressors are only fixable if they are _YOU_

Unless it's you realizing you're acting like a toxic person or micro-attacking
someone, and realize that you're actually doing more harm than good being that
way, there is no way to fix those traits (again, personal opinion).

...mostly 'cause hearing from someone else may feel "_they_ are the ones
against me!" to them.

### Hero Projects: You'll have to do it someday

An "hero project" is a project/spec change/framework that you personally think
will solve a group of problems in your project. It could be a different
architecture, a new framework or even a new language.

That means you'll spent your free time to write something that is already
being worked/exists just to prove a point.

Sometimes it proves you where wrong.

(But you got something from it, nonetheless.)

### Don't confuse "hero project" with "hero syndrome"

I have seen this at least two times: Someone claims things don't work when
they aren't around or that they don't need help.

This is "hero syndrome", the idea that that person is the only one capable of
solving all the problems.

Don't be that person.

### Learn when to quit

You tell your boss that you didn't finish on time because something weird
happened and he lashed out at you.

One of your coworkers is constantly micro-attacking you.

Another one is the guy that keeps doing stupid pranks, saying bullshit and
small talking other groups all the time.

A third is always complaining that when he's not around, things don't work.

It's time to start sending your resume around, no matter how good the pay is
or how awesome the project is.

... unless you want to be a constantly pissed off, annoyed person when you're
in the forties.

### I.T. world is a very small egg

We have a expression here: "The world of _something_ is a small egg", which
means that you don't live in a large world; the world is small.

I.T. world is really small.

The person you work with today will find you again in 15 years after you both
changed 3 or 4 jobs already.

And you'll meet a lot of other I.T. people in the way.

And they will talk about themselves.

And whatever you say/do will be talked around, which one person will hear and
pass along another company, which will pass along other people, which will
pass the story along to another company and, suddenly, when you realized,
nobody will hire you locally 'cause everybody knows that time when you fucked
up a project or punched a colleague in the face.

### Paper notes are actually helpful

I tried to become "paperless" many times. At some point, I did keep the papers
away, but in the very end, it really do help to have a small notebook and a
pen right next to you write that damn URL you need to send the data.

### Trello is cool and all, but Post-its are nicer

Nothing says "I'm really busy, but organized" like having a bunch of post-its
on your desk.

### Blogging about your stupid solution is still better than being quiet

You may feel "I'm not start enough to talk about this" or "This must be so
stupid I shouldn't talk about it".

Create a blog. Post about your stupid solutions. They are still smarter than
someone else's solution.

Also, come back later and fight your own solutions with better ones.

Show your growth.

On top of that, they help you keep small notes or things you need to do.

### ... but turn off the comments

One thing about posting your stupid solution is that it will attract people
who just want to mess with you. "This is stupid", for example. "Your dumb" may
someone say, unaware of who's actually dumb.

Turn it off. Don't let those people stop you.

### Post your stupid solution online

Don't keep a Github only for those "cool, almost perfect" projects. You're
free to show that, at some point, you were a beginner.

You can always come back and improve your code.

(Or don't: I still have a public repo of my first Python project that looks
like I just translated Java into Python, without the Pythonic part.)

### Keep a list of "Things I Don't Know"

Richard Feymann, famous physicist, kept a notebook with the title "Things I
Don't Know".

When you find something that seems cool and you'd like to know more, create a
file/note/whatever with it in the title. Then make notes about what you
find/figure out.

--- 

**Changelog**:

* 2019-06-12:
	* Renamed "Cognitive Dissonance" to "Cognitive Cost", as pointed by 
	  [hellomudder](https://old.reddit.com/user/hellomudder).
	* As reminded by [DeviceMan](https://old.reddit.com/user/DevIceMan),
	  I added the "throw away your code" point.
	* Remember something about debuggers, which would make some people very
	  very angry.
* 2019-06-13:
	* Clarified the point about choosing a language a bit more.
	* Added a point to use functional programming.
	* Added a point about use structures to well-defined data.
	* Added a point about using abstractions to run the system on your
		computer.
	* Added a point about quitting your job.
	* Added a point about messing with external libraries.
	* Added a point about work relationships.
	* Added a point about tests and CI.
	* Added a point about project organization.
	* Added a point about modularization.
	* Added a point about libraries.
	* Clarified a bit about why generalists win in the end.
	* Added a point about comments in blogs.
	* Added a point about flags in functions.
	* Added a point about API evolution.
	* Added a point about dates.
* 2019-06-14:
	* Added a point about optimization.
	* Added a point about lazy evaluation.
