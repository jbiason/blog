+++
title = "Microservices: Chassis"
date = 2020-04-17

[taxonomies]
tags = ["microservices", "chassis", "frameworks", "languages"]
+++

The chassis for a microservices fleet is defined as the libraries and
frameworks that one should use when creating a new microservice.

<!-- more -->

The "chassis" is actually a [known
pattern](https://microservices.io/patterns/microservice-chassis.html), but the
literature points it as a decision about the libraries and frameworks that
should be used when creating microservices.

For example, if you're working with Java, you'd probably pick something like
Spring Boot as a chassis for your microservices, in a way that anyone creating
a new microservice already have the library (and local knowledge) on how to
build it.

And, for each language, you need to pick a different chassis -- you can't use
Spring Boot with Python, for example.

You may have noticed that "but" in the second paragraph. Personally, I think
the choice of chassis go way beyond just creating a microservices.

## Shared Knowledge

One of the major factors of using chassis for your microservices is the shared
knowledge between teams. Teams that are using the same chassis can exchange
solutions on how to solve some problems, how to make processing faster, new
releases information and so on.

Even if the teams will never touch each other's code, the simply fact that
they can share these information between them is a huge boom.

And even for teams using different languages is a major point: One team can
point that their framework allows them to do things in a more simpler way that
can be researched by some other team, using a complete different framework, in
a complete different language, on how to build the same stuff.

## Applying a Common View

While the pattern describes only frameworks and libraries, the choices of
surrounding services also makes part of the chassis, in my opinion.

For example, the teams pick Kafka as a messaging broker between services --
which would allow any team, on any framework, on any language, to use the same
service for exchanging messages -- allowing any team that has a need
for a message broker can use the same install (but using different
topics) and reduce maintenance costs. But what happens when one team decides
to use Kafka as a database and put a retention to "forever"? That would
utterly confused everyone else.  "Why is this topic getting bigger and
bigger?" Worse, without a well described DevOps documentation, someone may see
that growing topic, check it out, see that is has no retention policy and add
one based on the other projects.

Another example: For highly relational data, there is a PostgreSQL
installation for everyone. Each team have their own database and users. But
one team, which got responsible for two microservices, have one with data
which is relational and another that basically requires a key-value store.
Instead of asking for key-value store, they decide to create a database with a
single table, with a key field and a large text field for storing JSONs.
This, again, breaks the defined chassis, as one would expect PostgreSQL to be
the relational database and not as a key-value store.

## Conclusion

Chassis are good for microservices development due their quick development
start up and shared knowledge, but they go way beyond just frameworks and
libraries: They related to everything around the services and the way they are
viewed by each microservice.
