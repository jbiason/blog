+++
title = "Self-Healing Microservices"
date = 2020-01-03

[taxonomies]
tags = ["microservices", "healing", "artifacts"]
+++

All the [previous](@/code/microservices-artifact-input-state.md)
[discussions](@/code/microservices-artifact-ejection.md) I bought about
microservices was just a prelude to something I still don't have a fixed
solution: how do microservices "heal" themselves in case of missing data?

<!-- more -->

Quick recap before jumping into the problem: Microservices produce artifacts;
artifacts are either send downstream through some message broker to other
microservices or kept in the same microservice for future requests;
microservices can listen to more than one data input to build their artifact.

Previously I mentioned an example of a score microservice that produces an
artifact with the current game score for each team and the names of the
players that scored. This microservice could listen to:

1. The teams queue: this may be needed so we can show the team name or its
   abbreviation in the score request; once a team appears in the championship,
   the microservice adds it to its state for future reference[^1].
2. The players queue: same as above, so the microservice can return the player
   name, nickname, shirt number or something player related if the player
   scores; again, it keeps listening to the player queue and stores the
   players in its state.
3. The match queue: if a match will happen, it has to have a score, probably
   starting at 0 with no players in the goal list; this is just to avoid any
   issues with the services requesting scores of matches that didn't start
   or haven't had any goals yet; in any case, the artifact will be ready to be
   retrieved.
4. The narration queue: by listening to the narration queue, the score
   microservice will detect any goals, update its state and generate the new
   artifact.

The keyword to take from the above list is "could": Depending on the way the
microservice _and_ the messages are built, it may not be necessary to have all
this.

## Using full-blown messages

Let's start with the easiest way to avoid listening to all those queues:
Full-blown messages.

In a full-blown message, all the related data is sent along with the main
information.  Using the previous example, the service could listen to just the
match and narration queue, but expect that the "NewMatch" message will contain
the names of the teams, their abbreviation, logo, probably some id and so on;
the same for the "NewNarration" message: it will contain the player name,
nickname, shirt name, player id and so on.

The problem with full-blown messages is that they tend to become bigger and
bigger: As more microservices are plugged in the system, more fields may be
required -- and dropped by services that don't need those fields.

The pro side of full-blown messages is that a microservice will always have
all the information necessary, while keep the number of listening queues low.
This would also help if you just add a new service in the pool: if it starts
with a blank state, it will be able to build all the state from scratch,
'cause all the information is _already there_.

## Listen to base queues, request the rest

Almost like the solution before, the service would listen to the narrations
and matches, but once it detects a missing information (for example, the
narration event says player with ID, but this ID doesn't exist in its state),
the service would request the more "stale" information (players, teams and
products are not added all the time, for example) for some other service and
fill the lacking information in its state.

This means that this microservice now, instead of knowing only about queues,
now has to have information about other services (the ones that process and
store the "stale" data) and their interfaces -- and, in general, it would also
require some service discovery in the system. Those  microservices would be
the "two faced" type of microservice, which receives information, store in the
state, build the artifact but also has an interface for it to be retrieved
instead of simply receiving, processing and passing it along. Caching would
also be advised here, so one service can't flood the other requesting the same
data over and over -- and updates from time to time would make sense in some
situations.

The messages are shorter now ('cause you receive only the team/player ID
instead of everything) and retrieval of information happen when necessary, but
where you reduce the number of listeners, you increase the number of requests.
As will full-blown messages, a new service can easily build its own state from
scratch without any issues -- it will do a lot of requests, but it will,
eventually, have all the necessary information.

## Listen to all

This is exactly same solution as presented in the example above: the
microservice keeps listening to the queues of all related events and build the
state with them.

One problem with this solution: since the queues are asynchronous,
there could be a problem with the ordering of the data, with goals coming
before players (for different reasons). In this case... what would the service
do? Reject the goal in the hopes the player will appear, to avoid any
inconsistencies, and that the message broker requeue the event?

One solution would have services that, along with this one, listen to one
specific data: the score microservice listens to all four, but one
microservice listens only to the player queue. This service would
process things way faster than the score, and serve as sort of "fallback" in
case some data is missing, kinda like the solution above. This will reduce the
traffic in the network, but it'd create have duplicate data in different
services -- although that last point shouldn't be a problem in the first
place.

New services will find it problematic, 'cause although they are receiving the
main data, they are were not alive when the more "stale" data was processed;
they will need to either communicate with other services to get this
information, or someone
will have to manually duplicate the sources.

## Single queue

I just describe solutions in which every data has its own queue, but what if
we put _all_ the events in the same queue? This way, order is assured (players
will be queue before the goals, and the services will process players before
they even see there is a goal).

This reduces the number of listeners, but it requires some good
message design, specially in statically typed languages, which usually require
a well-defined structure for serialization and deseralization. 

But it solves almost everything else: there is no issue with the processing
order, the number of listeners is low and the messages are small. But it will
also make new services suffer from the lack of stale data, forcing them to
communicate with other services or to have the data manually copied when they
are brought up.

# The best one?

Honestly, I have no idea. I'm siding with "Full-blown messages" simply 'cause
it simplifies the structure of the services, even knowing that network is not
free; if I used some non-statically typed language, I'd probably side with the
single queue one. But, again, I don't think there is any "one size fits all".

Probably there are more architectural options for this, and those are the ones
I can remember discussing with my coworkers.

[^1]: It's worth noting that the microservice may simply drop some of the
  information. For example, if the artifact produced only requires the
  abbreviated name, it full name may be completely dropped from the state.
