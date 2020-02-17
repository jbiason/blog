+++
title = "Microservices: Where Is the Source of Truth?"
date = 2020-02-17

[taxonomies]
tags = ["microservices", "state", "source of truth"]
+++

When we are talking about a system, there is one point that we need to discuss
where the "Source of Truth" of it is. In Monoliths, the source of truth is the
storage itself. But where does it sit in a system that is composed by multiple
parts?

<!-- more -->

Just to be clear here: What I mean by "source of truth" is whatever you can
use to check if the system is producing the correct values. For example, in a
pipeline to count how much users transfer in a CDN, the source of truth could
be the logs (you can read the logs and check if the service responsible for
summing the results is correct); in an e-commerce site, we could assume the
source of truth to be the items in every invoice for the total revenue (if you
sum all the items quantities by their prices, you'll get the revenue back).

One important factor of a source of truth is that not only you can use it to
check if your services are correct, but you can also re-apply its content back
to the system to rebuild artifacts.

But here is a problem: If your system is distributed and [each microservice is
building a different artifact](@./microservices-artifact-input-state.md), where
is the source of truth?

Previously, I mentioned that microservices could keep an state in order to
produce the artifact. That could be the source of truth for that microservice,
as long as it doesn't delete old data -- in which case, how would you rebuild
old artifacts if you can't return the state to an old... state?

Another solution is to make the insertion microservice (the one that captures
data from an external source) to build this source of truth; in case of the
need to rebuild the data, you can just add an API in that microservice for it
to republish data related to a certain object, which will go down the pipeline
and every microservice will rebuild their artifacts.

And, finally, if you build an event source pipeline correctly, you can build a
single service that will listed to _every_ event and keep a global event
source, which you can again expose an API to replay all events of an object.

{% note() %}
.. although I have a feeling that certain events should be changed; for example,
if you make the event source replay everything related to an invoice -- in
order to reproduce the complete invoice artifact -- you may have to replay a
"create user" event, which won't make sense 'cause the object already exists,
and it shouldn't create a new user with the same information.

Either that, or you could make the invoice service request the costumer
service the data if it doesn't have it already.
{% end %}

Anyway, one recommendation that I have is to always build something that can
keep track of your data, in case you need to rebuild your artifacts and your
state removes old data (which is perfectly normal, I must add).
