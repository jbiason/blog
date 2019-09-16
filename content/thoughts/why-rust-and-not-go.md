+++
title = "Why Rust and not Go"
date = 2019-09-16

[taxonomies]
tags = ["go", "rust", "programming languages", "nitpick"]
+++

{% note() %}
This is a rebuttal to [Why Go and not
Rust?](https://kristoff.it/blog/why-go-and-not-rust/).
{% end %}

# HUGE DISCLAIMER

Before jumping into the discussion, let me put this first: I do write code in
Rust (not professionally), I've not written something in Go yet but I keep
reading about the language and its ecosystem. I also follow the Rust as a
language and its ecosystem.

Second, another thing you must know about me: I've been a developer
professionally for about 30 years (its no hyperbole here: I did start
professionally writing code when I was 12 and didn't leave the field yet).
I've written code that run in about 15 different languages, so I have strong
opinions about coding after suffering with those languages.

Third, I do believe languages do not exist in a vacuum: Besides the language,
you have libraries and frameworks; besides the languages and the frameworks,
there is dependency control; besides dependency control, there is a community.

Fourth, if that's not really clear so far, all this is a matter of opinion --
even the original post is, although it doesn't say so.

Fifth, yes, I did take things out of order, mostly 'cause I thought some
points are scattered around the original text that are complementary.

That being said...

## The Nitpicking

(Those are points that just brushed me in the wrong way, but they are not
major points and you can really skip this if you don't want to read a bunch of
complains.)

> Go is fast, but Rust is faster.

C is even faster. So what?

> Go has an efficient garbage collector, but Rust has static memory management.

And so does C and C++. So what?

> Go has interfaces, but Rust has traits and other zero-cost abstractions

Well, Go doesn't have interfaces _per-se_. Their interface is akin to Python
"if it has an `open()`, `read()` and `fseek()`, then it's a File-like object",
as far as I know. Python even changed that from the "it looks like a
file-like" to using the double-dunder functions to fit the interface ("if it
has a `__len__()` method, it is an object with a size").

> Go has great support for HTTP and related protocols and it doesn't take long
> to write a satisfactory web service.

More satisfactory than [Flask](https://palletsprojects.com/p/flask/), in which
you can create a service (a very dumb one, in that) with only 5 lines of code?
Does it? Or is it a _personal opinion_?

Honestly, I haven't seen -- even with Rust -- something as dead simple as
Flask, so there we have it. If you need performance, one could use
[Sanic](https://github.com/huge-success/sanic), which is a uvloop powered
server with a syntax that is pretty close to Flask.

So, when you say "great support" and "satisfactory" is that a _fact_ or an
_opinion_?

Obviously it is an opinion, as much as me saying Flask/Sanic can beat anything
Go has, and neither of those are valid for anything. Beauty is in the eye of
the beholder.

(But if I'm nitpicking, I can throw whatever language I want here.)

>  The creators of Go like to call it a “boring” language.

Weirdly enough, I heard the same thing about Rust. So which one is the
"boriest" of them all?

This kind of call is akin to the PyPy devs saying that "PyPy is 300% faster
than CPython -- for tests written specifically to prove that PyPy is 300% faster
than CPython". The same thing can be said here: Go/Rust devs call their
language boring 'cause they want to prove their language is boring. Neither is
true -- and, weirdly enough, _both_ are true.

One could even claim that Python is more boring that Go.

> do more with less” has proven to be very successful.

Wait, are you _really_ quoting Dennis Ritchie, in which he was defending C? C
has less than Go or Rust, so maybe we should jump back to C? Is that what you
mean?

> In truth, none of these things alone is particularly impressive, but they do
> describe the mindset that Go wants to impose. Many don’t like it but, in my
> opinion, it’s a killer feature for some types of development, like
> enterprise software.

Ok, so if we point that Rust does exactly what you're saying and _better_
("enforce" vs "you need to run something, otherwise nothing changes), then
Rust kills Go in enterprise software, right?

> Enterprise software always has a big scope.

Yes, and that's why we break this scope -- and some domains and everything
else -- into smaller parts that connect to each other. Those are called
"microservices" and one thing is that you can write them in whatever

(I'll make this point again later, but it is weird how the author says one can
spin a Go app really fast, but then comes with the sort of points that make
sense only for monoliths, and I'm not sure which is the real point being
pointed in these cases.)

> To unravel complex domains you need a well-structured process.

(And then he jumps into discussing about domains and expects and stakeholders)
You know what you're talking about? A DSL. You want a DSL to is close to the
experts about their domain, you want a DSL so stakeholders can understand
what's going on above the code.

You want Racket. I've seen things close to this in Rust using macros (which is
witchcraft to me) but I'll refrain from saying "Rust has it, and better".

## The Freaking Cargo Cult

> Go was created at Google to solve Google problems

This is something that we, developers, who love and hate _any_ language need
to discuss. And it comes in this other point:

> As I already mentioned, Go was created to solve Google problems, and Google
> problems are definitely enterprise-scale problems.

You know who has Google problems? GOOGLE! You know who else has Google
problems? NO ONE!

No one is a huge search engine that lives into capturing peoples data to
provide relevant ads (and, sometimes, search results, and shopping lists and
whatever).

It's the same bullshit people claiming "Netflix has 600+ microservices using
Spring, so we should use Spring for our microservices", 'cause you won't have
600+ microservices, and most probably none of them are related to providing
video streaming.

It's the same bullshit people claiming "Amazon deploys a microservice every 11
seconds, so we must use microservices too!" 'cause, again, you're not a huge
cloud provider with two or three different versions of the same solution.

This "Cargo Cult": The idea that if we do the same thing someone else did and
it worked, it will work for us too. Enterprises everywhere run Java, for huge
scales -- AWS is the first that comes to mind -- but you're not claiming Java
can solve "enterprise-scale" problems, are you? The point that you're trying
to make here is "worked for Google, will work for you", which is plain wrong.

And it doesn't even involve Go or Rust. You're trying to make a point by
saying "They use" and that's not a point. _At all_.

# The Plain Wrong

> Go is also strict about things that other languages are usually more lax about.

Guess you never saw the borrow checker. Or the fact that Rust doesn't allow
passing an u32 (unsigned int of 32 bits) as a parameter that requires an u64,
even if the later is larger than the former. There is no implicit conversion
in Rust and a Rust dev must explicit convert from one type to the other.

Also, since you're talking about "strictness", let me ask you this: Have the
Go code devs fixes this?

```
result, err := some_function()
return result
```

What is there to fix? THE FREAKING ERROR TREATMENT, THAT IS! You can't call a
language strict if, in 2019, it let this kind of stuff slip by. We learnt, in
those last years, that the "not-happy" path happens more often than the happy
path. And ignoring such errors is the major cause of headaches we get, and
that's why we have those stupid "restart job at midnight" cronjobs. We can't
live with that anymore and unless we are willing to deal with those thorns,
we'll be stuck in time.

I can also bring the borrow checker back into this: You see, we don't talk
about processor speed anymore these days, we talk about cores. The future (and
the present) are multi-thread. I won't deny that launching a concurrent,
multi-threaded service in Go is a lot simpler than Rust, but Go doesn't have
any validation about the memory usage; it won't prevent you from doing
something like sending a structure over a channel and changing that structure
_in the same thread_. So, while Go makes it easier, Rust makes sure you're not
shooting yourself in the foot in the long run -- which would require the
cronjobs.

> Go doesn’t want unused variables or imports

Neither does Rust -- it throws a large, explicative warning right in the
middle of your screen -- , so what's the point of this here?

> files belonging to different packages in the same directory

Hey, do you know that, in Rust, directories _are_ packages, and so you _can't_
put files of different packages in the different directories? In this case,
Rust seem more strict than Go, doesn't it?

> Go also doesn’t want any “fingerprints” in the code, so it enforces a
> single, universal style via `go fmt`.

It doesn't _enforce_ if you have to run this. Rust also have a `rustfmt`, if
that's your point but, besides that, the Rust compiler will complain about
things that are not following the coding style. Try to name a variable in
camelCase and see what the rust compiler will say.

Besides `rustfmt`, Python has Black (which I hate, but still); before Black,
Python have flake8 and pylint, both which would "enforce" the Python style. So
this is, again, a moot point.

> The toolchain is very often lousy and/or dated.

You mean, projects don't have [rustup](https://rustup.rs/), the way Rust has?
Crazy!

Or even the backwards compatibility, like when Rust changed from the 2015
edition to 2018, but you could select which edition (compiler version, AST,
and so on) your project would use?

> The Go compiler is fast.

Ah crap, not that shit again.

The whole point is "compiler is fast, tests run faster". Well, what if I said
the compiler would catch bugs _before_ the tests? That would be even faster,
'cause then you can focus your tests on system behaviour, which is way more
important than function behaviour or class/structure/module behaviour.

We are, once again, discussing [Fast Test, Slow
Test](https://www.youtube.com/watch?v=RAxiiRPHS9k), aren't we? Let me write a
test for every single function, every single class and oh, look how fast they
run! Then we put the "integration tests" in the CI and everybody is happy.

Except you wrote tests twice when the only tests that matter are the ones that
check the system behaviours.

> With Go, it’s easier as a junior developer to be more productive

[Citation needed]. I know this is pretty close a nitpick and I can understand
where this is going, but my guess is that, in the long run, when juniors
understand why certain features don't compile, they can be more productive
'cause errors in their code will be caught way earlier in compilation (see
point below about types).

Also, feel free to call [Citation needed] about my point here too, 'cause we
both know we are both pulling data from our asses.

# The Somewhat Right

> There are a lot of junior developers

Yes, there are. Also, they are, sadly, not getting that many jobs, 'cause as
this point, nobody is hiring juniors.

> This pushes further down technological concerns such as efficiency, and even
> correctness. Don’t get me wrong, the business does care about correctness,
> but they have a different definition for it. When you’re thinking about
> algorithmic correctness, they are thinking about a reconciliation
> back-office for the operations team they keep in a country where labor is
> cheap.

Wait, it is technological but not technological? I know, this should be in the
nitpick section, but there is another important point here.

Thing is, business people do not care about reconciliation; they worry about
deliveries and cheap labor _and that is_. Are they delivering? Are they cheap?
Good, case closed. We don't care if there is a problem that will appear in 10
months or if they connection is slow between services; it works right now and we
saved money right now, so the math is solid.

On the other hand, if we are talking about "technological efficiency", you've
already said Rust is faster than Go, so it's more efficient (for the level of
efficient I want to use to prove that Rust is better than Go -- and I'm being
sarcastic here); if we are talking about "technological correctness", we can
go down the rabbit hole of Rust types and that, although not close to Haskell
types, it forces a good bunch of correctness in your processes. And nothing
about Go types (and their correctness) is ever mentioned; wanna guess why?

> Software projects quickly become huge and complex for all the wrong reasons.

I have to agree with this. Yes, software grows beyond maintainability and
domains change.

On the other hand, we keep pushing microservices in those larger contexts,
specially to avoid being stuck in certain domains, 'cause you can just
rewrite services (yes, you can) or you break code into different services so
they don't go being the maintainability barrier.

(Deep down, this point annoys the heck out of me: The post starts talking how
easy it is to spin a new service in Go, which I can't deny compared to Rust,
but I can argue against Python, and then comes this point that is, in reality
talking about monoliths. So, which is which? Is Go good for solving monoliths
or is Go good for spinning smaller services? Are you trying to say it's good
for everything?)

> Go is much easier to learn than Java or C#.

Says who? I mean, I don't want to bring the "That's, like, your opinion, man"
card again, but I guess one could find a lot more resources about Java or C#
than Go.

What about Rust? I give that the language is not that easy to pick, but every
working group on the Rust community writes their own book, so one could bring
those juniors devs into reading the books they will need to use.

> The Go community regards as anti-patterns many abstractions regularly
> employed by Java / C#

And I guess Java and C# regards Go abstraction as anti-patterns too, so what's
the point? Any language that has different ways to express abstractions
different than other languages will call the other language abstractions
"anti-patterns".

Rust will call some Java patterns anti-patterns too and I have to, once again,
ask "So what?"

> Go is faster than Java

[For a very small
margin](https://benchmarksgame-team.pages.debian.net/benchmarksgame/fastest/go.html).

But I have to pull the ["moving
goalpost"](https://en.wikipedia.org/wiki/Moving_the_goalposts) card in the
blog post here: "Go is simple so that all of this can hold true when
confronting the average Go program with the average Java / C# program." So now
we are comparing the "average" Go vs the "average" Java/C#. Except whatever is
an "average" Go/Java/C# program is never defined, so we can keep pulling data
from our asses.

# The Things We Don't Talk About

There is one important piece that is never discussed: Ecosystem.

And no, ecosystem is not simply the number of libraries and packages in the
package manager; it is way beyond that: It's about its community and the way
the management deals with it.

And we have to talk about `go dep`.

`go dep`, the Go dependency tool, is a replacement of the dependency tool
created by the community, `godep`, after a whole years with said community
asking for a decent dependency tool, specially compared to the `vendor`
solution. So, without every inquiring the community, the Go core devs decided
they know better, made a tool and gave a big "screw you" to the community.

Not only that, but just recently the same tool decided to [make the tool call
home](https://codeengineered.com/blog/2019/go-mod-proxy-psa/) by adding a
proxy on the call of every package, _including your private ones_. Why? No
real explanation. It simply does.

Not only the situation of the core Go devs going against the wishes of the
community, there was even some whisper about forking Go into a community
version, so it could run with a code group that would actually _listen_ to the
community.

And Go is just one year older than Rust. And nobody is saying "Let's fork
Rust" -- even if you count [without boats](https://twitter.com/withoutboats/)
comments about a simpler version of Rust, in which he was talking about
_another language_ that would borrow some stuff from Rust, the same way Rust
borrowed some stuff from OCaml and other ML languages.

[Cargo](https://doc.rust-lang.org/cargo/) is the Rust counterpart of `go dep`.
Cargo was born in the Rust infancy and it is evolving along the Rust compiler.
All discussions about it [are done in the
open](https://github.com/rust-lang/cargo/issues/) with the community input.
Rust itself goes [through the same
motions](https://github.com/rust-lang/rust/issues) -- and that could be the
reason async/await is almost a whole year in the cooking, with discussions
about its syntax going through iterations over the issue list.

# You Have To Have a Posture

Maybe the `go dep` discussion wasn't a big deal for you. Maybe Rust/Cargo
discussions in the open (and taking longer than they needed) is a big turn off
for you.

But let me ask you this: Which one of those models follow an open source
development model?

I understand what Mike Hoye, from Mozilla, meant when he said "I think that
openness as a practice – not just code you can fork but the transparency and
accessibility of the development process." 

So take a step back and re-read the last point again. Which one of those are
really an open project?

# In Closing

I have to call the original post completely baloney, mostly 'cause I want this
post to end in a lighter mood. I mean, there is a huge confusion of saying "Go
is better than Java/C#" while what we are talking about is "Go vs Rust". The
whole "Let me take a huge turn here, saying Go is better than Java/C# only to,
in the end, say that Go is for Java and Rust is for C++, but I'll never
compare Java vs C++ to actually make a point about Go vs Rust with their
comparative other languages".

And then, when we pick the points in which the author goes straight for the
"Go vs Rust" discussion, all the points are wrong.

So what is actually the point? That Go is better than Java and Rust is better
than C++ and, thus, Go is better than Rust? 'Cause if that was it, it failed
completely.

I won't say Go is a bad language, but Go is not a better language than Rust,
specially if we consider the future, in which more cores will be available
(considering the current trends) and more threaded applications will be
necessary. It still doesn't make Rust a better language than Go (or
vice-versa), although Go seriously need to go back to the basics of error
control and memory protection if it wants to be a language for the future.

But Go is badly _managed_ and that makes it a bad option for anyone writing
something serious. 

What do I meant by "badly managed"? Well, as you can see, the core devs don't
seem to listen the community on the big issues (there was a discussion about a
`Try` operator, which would be a minor change, compared to the dependency
control, which the community said no and was never implemented, but still,
minor). The `go dep` was a complete "ignore whatever the community built,
'cause we know better" and the Google proxy in it is simple a PSA, not a
"let's ask the community what they think about it before doing it so" are two
signs that they don't care about what the community wants and that means they
can pivot the language in a way that the community _doesn't_ want and there
would be nothing one could do.

That's not how open source projects should move about.

You may not care about this "open source" thingy, and that's ok. You may
believe that the core team knows better how Go should be used than the
developers writing code in Go, and that's ok. But if you're an open source
proponent, evangelist or admirer, there is absolutely no reason to defend Go
on _any_ accounts.
