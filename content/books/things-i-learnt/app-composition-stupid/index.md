+++
title = "Things I Learnt The Hard Way - Even for Application Composition, Start Stupid"
date = 2019-07-15

[taxonomies]
tags = ["en-au", "books", "things i learnt", "composition", "microservices"]
+++

Application composition may lead to microservices -- which is good -- but
microservices require some ideas about how applications "talk" between them
over the wire (protocols and such) which you don't need to start with.

<!-- more -->

Again, because you just want to simplify your work, you can make the
applications use files directly: Have your first application generate two
files and the second application receive the file names from [the command
line](/books/things-i-learnt/command-line-options). There, simple and stupid,
and works.

You can even make the first application, instead of generating a file, just
send its result on the standard output, and have the second application
receive the data from the standard input -- both of which are managed as
files, anyway. Then, with a bit of magic, you can put everything together
without wasting space.

Worry about talking over the wire later, when you understand how networks
work.

{{ chapters(prev_chapter_link="/books/things-i-learnt/application-composition", prev_chapter_title="Not Just Function Composition, But Application Composition", next_chapter_link="/books/things-i-learnt/log-events", next_chapter_title="Logs Are For Events, Not User Interface") }}
