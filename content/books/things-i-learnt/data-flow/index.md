+++
title = "Things I Learnt The Hard Way - Thinking Data Flow Beats Patterns"
date = 2019-06-26

[taxonomies]
tags = ["en-au", "books", "things i learnt", "data flow", "design patterns"]
+++

When you're trying to find a solution to your problem, think on the way the
data will flow through your code.

<!-- more -->

Instead of focusing on design patterns, a better way is to think the way the
data will flow -- and be transformed -- on your code.

For example, the user will input a number. You'll get this number and find the
respective record on the database. This is a transformation -- no, it's not
"I'll get the number and receive a complete different thing based upon it",
you're actually transforming the number into a record, using the database as a
transformation.

(Yes, I know, it's not that clear at the first glance, but you have to think
that they are the same data with different representations.)

Most of the time I did that, I managed to come with more clear design for my
applications. I didn't even think about how many functions/classes it would be
needed to do these kind of transformations, that was something I came up
_after_ I could see the data flow.

In a way, this way of thinking gets things more clear 'cause you have a list
of steps of transformations you need to do, so you can write them one after
another, which prevents a lot of bad code in the future.

{{ chapters(prev_chapter_link="/books/things-i-learnt/patterns-not-solutions", prev_chapter_title="Design Patters Are Used to Name Solution, Not Find Them", next_chapter_link="/books/things-i-learnt/magical-number-seven", next_chapter_title="The Magic Number Seven, Plus Or Minus Two") }}
