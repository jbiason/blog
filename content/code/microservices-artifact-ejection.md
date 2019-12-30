+++
title = "Microservices: Artifact Ejection"
date = 2019-12-30

[taxonomies]
tags = ["microservices", "artifacts", "connection", "ejection"]
+++

As I was discussing about [artifacts in
microservices](@/code/microservices-artifact-input-state.md), I guess I forgot to
discuss some important point: How those artifacts are "ejected" from the
microservice?

<!-- more -->

"Ejected", in this case, means "pass it to the next necessary stage", which
can mean a lot of stuff (sometimes, more than one). Also, I needed some catchy
word for it 'cause simply "produces" isn't that fashionable.

For example, if your microservice is producing intermediate data -- say, it
connects to an external service and retrieves information, which is then
processed by different microservices -- then you probably want to use a
message broker as the ejection route for the artifact. Using a message broker
will allow another services to keep listening to the creation of those
artifacts and do their thing -- producing new artifacts.

Another possibility is that this microservice is the end of the production
line and, thus, it just keeps the artifact in order to by consumed in a
non-asynchronous way. For example, the microservice may produce elements that
are later requested by a web request, so what its needs is to produce said
artifact and keep it around, responding requests later.

This, again, is akin to the way CQRS (command-query response segregation)
works: You have one side of your microservice receiving data and processing
its artifact, and another that allows querying the artifacts.

You can even do both: When the artifact is produced, the microservice ejects
it through a message broker to be processed by other microservices and still
stores it internally to be queried. 

There is even the possibility of the query part be just another microservice:
It gets the artifact from another microservice and stores it, with no
processing (if you don't count as "saves in a permanent storage" a
processing). This is interesting 'cause the "query" part of the microservice
is just another microservice, instead of being some sort of specialized
microservice that produces, ejects and stores artifacts.

When I mentioned we saved our artifacts in Firebase, we are basically building
this split microservice: While we have microservices that produce the
artifacts, the "storage and query" part is giving to Firebase -- but you can
consider this as any other service.

(This whole post is just to give some pointers on what I want to discuss next,
which are some thoughts about self-healing microservices -- and what I meant
by that.)
