+++
title = "Microservices In Action - Morgan Bruce"
date = 2019-08-13

[taxonomies]
tags = ["books", "reviews", "microservices", "morgan bruce", "it", "2 stars"]
+++

[GoodReads summary](https://www.goodreads.com/book/show/36579817-microservices-in-action):
Microservices in Action is a practical book about building and deploying
microservice-based applications. Written for developers and architects with a
solid grasp of service-oriented development, it tackles the challenge of
putting microservices into production. You'll begin with an in-depth overview
of microservice design principles, building on your knowledge of traditional
systems. Then, you'll start creating a reliable road to production. You'll
explore examples using Kubernetes, Docker, and Google Container Engine as you
learn to build clusters and maintain them after deployment. Throughout this
rich, experience-driven book, you'll move through real-world use cases
including a continuous delivery pipeline, production monitoring, and practical
techniques for scaling and maintaining a healthy system.

<!-- more -->

{{ stars(stars=2) }}

For an "In Action" title, there is very little "Action" going on. Not that the
book lacks information: There is plenty of theoretical information, although a
lot is hidden in "cohesive" adjectives: "If you do this, the service will not
be cohesive", "doing so will make it more cohesive"... and what the author
means by "cohesive" is never explained -- I'd ask the author to replace every
reference to cohesive with a proper explanation.

Also, there are a lot of images. Not that images by themselves is bad, but when
they are used for the obvious, it really irks me -- specially 'cause I read
those books on a "black background with white letters" and images do not fit
that properly, using a white background that usually just hurts my eyes. And by
"used for the obvious", there are images follow the description of "A and B
communicate with C" and a large image showing `A --> C <-- B`; was that really
necessary?

The intro says the code is in Python, and that was something that I'd really
like to see. There is very little code in this book and the parts shown are
basically "look at this library" instead of focusing on what it really does; a
library for retrying is nice and all, but would it be so hard to write the
code, even if that code would be somewhat longer, to show the point you're
trying to make instead of being just an example of a library?

Speaking of code, there is also a long discussion about deploying
microservices, which is a good thing, but the author decided that it would use
Google Cloud Platform and every single explanation focuses more on how to
deploy on GCP instead of actually discussing deployment. 
