+++
title = "Modern Java in Action - Raoul-Gabriel Urma"
date = 2019-02-08

[taxonomies]
tags = ["books", "en-au", "review", "java", "java 8", "java 9", "raoul-gabriel urma"]
+++

Java 8 Lambdas in Action is a clearly-written guide to Java 8 lambdas and
functional programming in Java. It begins with a practical introduction to the
structure and benefits of lambda expressions in real-world Java code. The book
then introduces the Stream API and shows how it can make collections-related
code radically easier to understand and maintain. Along the way, you'll
discover new FP-oriented design patterns with Java 8 for code reuse, code
readability, exception handling, data manipulation, and concurrency. For
developers also exploring other functional languages on the JVM, the book
concludes with a quick survey of useful functional features in Scala and
Clojure.

<!-- more -->

{{ stars(stars=2) }}

To be short: It's a good book, but it is extremely (and unnecessary) verbose.

It covers the new stuff on Java 8 (like streams and lambdas) and some of Java 9
(like the Flow/reactive interface). It does a good job on Streams and Lambdas,
but seems to fall a bit short on the reactive interface, maybe 'cause it's just
an interface, although I found the examples a little bit missing in some
points, like showing the Three interfaces, Subscriber, Subscription and
Publisher, but showing examples without the Publisher. A bit worse (IMHO), is
that, in order to produce an example, instead of publishing some data, it shows
a generic publisher of sequential numbers, in which it calls the real
publisher.

Also, the authors seem a bit too enthusiastic about lambdas. Even when the code
becomes less readable -- specially in the Flow examples -- they still use
lambdas. They are so into it that the example of a `for` being converted to a
stream is shown at least 4 times.

There are too many "as follows"; there are too many "in the next section" just
before the next section; there is too much repetition that shouldn't be there.

Again, the content is good, but the text is terrible.
