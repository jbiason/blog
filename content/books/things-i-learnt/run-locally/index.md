+++
title = "Things I Learnt The Hard Way - If It Doesn't Run On Your Computer, You Have A Problem"
date = 2019-07-18

[taxonomies]
tags = ["en-au", "books", "things i learnt", "local run", "cloud"]
+++

I've seen a lot of systems that would never run on a isolated computer, like
the developer tool, 'cause the system requires running on a specialized
environment. Those things are wrong.

<!-- more -->

Requiring a specialized environment absolutely kills productivity.

If your system will run on a specialized environment -- and I'm including "the
cloud" here -- look for something that can abstract whatever you're using. For
example, if you're using AWS SQS, which is a queue, look for a library that
can abstract the way a queue works so you can also run with RabbitMQ, which
can be easily run on your own computer.

If you're using a very specialized thing, you may have to write the
abstraction yourself, isolating it from the main system, so you can develop
the main product in peace.

One of the most productivity killer environment I worked require running the
project on a customized Apache installation, running the client specialized
framework. The whole problem is that the client refused to allow us to not use
it or install on our local machines (mostly 'cause the install of said
framework was really complex). In other for us to work and see things working,
we had to use a VPN to the client computers, develop things there and manually
forcing things to reload. No only we had absolutely nothing to do when the VPN
was down ('cause it require out company infrastructure working hand-in-hand
with the client infrastructure and the internet provider infrastructure, which
is absolutely impossible), the flow was really cumbersome.

If we had the chance to not use it and run all the development and tests on
our own computers, I have the feeling we could deliver the product 2-3 months
earlier.

{{ chapters(prev_chapter_link="/books/things-i-learnt/units", prev_chapter_title="Units Makes Things Clear", next_chapter_link="/books/things-i-learnt/config-file", next_chapter_title="The Config File Is Friend") }}
