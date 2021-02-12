+++
title = "Hadoop in Practice - Alex Holmes"
date = 2018-02-16
updated = 2021-02-12

[taxonomies]
tags = ["books", "alex holmes", "reviews", "ti", "hadoop", "big data", 
"stars:1", "published:2012"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/13496907-hadoop-in-practice):
Hadoop in Practice collects nearly 100 Hadoop examples and presents them in a
problem/solution format. Each technique addresses a specific task you'll face,
like querying big data using Pig or writing a log file loader. You'll explore
each problem step by step, learning both how to build and deploy that specific
solution along with the thinking that went into its design. As you work
through the tasks, you'll find yourself growing more comfortable with Hadoop
and at home in the world of big data.

<!-- more -->

{{ stars(stars=1) }}

First thing: This is not about how to deal with Hadoop in a real environment;
this a cookbook of recipes for working with Hadoop, some of them that you
won't ever use.

Second: The book uses a structure of
"Explanation/Problem/Solution/Discussion". While the formula usually works,
here is simply to add more words, because "Problem" is tailored exclusively to
pair with the "Explanation". Not only that but "Solution" is basically a
rehearsal of the "Explanation". Something like "Hadoop comes with it's own
class for dealing with X file format; Problem: You have files in the X format
and want to process them in Hadoop; Solution: Use the classes in Hadoop". This
basically throw the whole structure under a bus.

Third: There is plenty of code examples, and most are terrible. I don't mean
"The code doesn't compile" or "It doesn't follow any good practices". I mean
it uses some cutesy arrows to point to some pieces of code, which means it's
an image instead of a real code, which means you can't copy'n'paste if needed.
Also, those arrows could be easily be converted to comments, except most
comments would fall into the "i = i + 1; // increments i" category -- useless
comments pointing to obvious things. If it would tell you *why* you're
incrementing "i" instead of what it's doing, it would at least be interesting.

There may be something useful there if you have a specific problem with
Hadoop. But if you have a single, specific problem, you'd Google it instead of
buying a book with a bunch of other solutions that doesn't affect you.
