+++
title = "Microservices: Artifact = Input + State"
date = 2019-12-26

[taxonomies]
tags = ["microservices", "artifacts", "state"]
+++

Designing microservices is a bit complicated because you have to think about
different things when deciding which "domain" it will occupy. A recent
discussion with coworkers about our current microservices design led me to
rethink how to think about microservices.

<!-- more -->

This may sound a bit weird for those already working with microservices -- or
that managed to build a good view of the building of microservices -- but when
the word "artifact" popped up in a discussion, it "clicked" with a bunch of
other stuff I had in mind about the topic.

One fact that kept confusing me was that a lot of literature about
microservices talk about "domain separation" and how to figure out each
domain. Now, although there are a few tricks -- like "if it is a noun, it is a
domain" -- not everything is clear cut. Some domains are actually subdomains
of a larger domain, so you keep wondering if you should split those or keep
them into a single microservice, since splitting them would, invariably,
making the microservices coupled (something you want to avoid when building
microservices).

And that's where "artifact" felt into place. For a while, I had the impression
that microservices had to be built "backwards", in the sense that first you
have to think in what you _need_ and then check what you _have_ -- in other
words, you have to think on your outputs before checking your inputs. And an
"artifact" is, in the end, just the output of the microservice.

In our case, we are dealing with games. Each game has a narration, it has an
score, it has statistics and it has a roster. Even if it falls into the "it's
a noun!" rule, it actually resembles the required output of our system: we
have a request that gets the current narration of a game (which can be polled
from time to time or -- as we are currently working on -- pushed towards
clients); one request returns the match score (which, again, can be polled or
pushed); one request retrieves the match statistics, which is not frequently
updated or displayed, so it doesn't need constant updates; and so on. Each one
of those is a different microservice, because each one of those is a different
artifact.

Just to be clear: our artifacts are kept in a Firestore database, which our
clients query directly, most of the time receiving the real time notifications
for changes. But another way to keep those artifacts is to have separate
services, which the clients would query -- which is really akin to what CQRS
describes (well, that is, if your microservice receive commands to change the
data, that is; I won't claim them to be CQRS if your microservices are dealing
with events directly.)

Alright, if those are artifacts, where does "state" gets into this? The state
is the amount of information a microservice has to keep in order to build the
artifact. For example, in the narration, each time a new narration comes in,
it has to be added to a game list of narrations in order to produce the
narration of the whole match. The state can also help this microservice into
dropping duplicate narrations.

One "nice" effect of the state is that you can, in theory at least, be able to
recognize that even with an input, if there was no change in the state, there
should be no change in the artifact and, thus, no output is necessary.

Another thing to keep in mind about the state is that you don't need to keep
it in memory; you can use any kind of storage: keep the narrations in a
database, keep it on a disk, keep in memory as a cache, or all the above. You
pick whatever it is _easier_ to manipulate said state to produce the artifact.
The thing to keep in mind is "If this microservice crashes, will it be able to
rebuild its previous state when it restarts?"

And, finally, the inputs. Those may sound a bit obvious at first (is your
microservice generating data out of thin air?), but keep in mind is that one
input can be be the source of more than one microservice. For example, a
narration may be consumed by the narration microservice to produce the whole
game narration, but it may also be consumed by the score microservice,
listening to goal narrations to update its state (if the narration is not a
goal, there is no change in score, there is no change in the state and there
is no artifact generation).

Returning to artifacts, do not worry if more than one microservice doing
almost the same thing, but generating a complete different artifact. As an
example, imagine that you want to use push notifications to report new goals.
Although this is very close to the score microservice, it produces a different
artifact (the push notification vs the update score request) and, by this,
should be a complete different microservice. It may even sound wasteful (doing
the same thing twice), but it would decouple things if you need some other
information in the score (say, adding the name of the players who did the
goals) or if you change the artifact consumer (say, you change from an in-hour
implementation of pushing to Apple and Google to using a service for this,
like Azure).

This change in the my way of thinking about microservices design help me
rethink the way we are building our microservices at work, and it is also
helping me rethink some things on a personal project (which I hope to finish
and show it next year).


