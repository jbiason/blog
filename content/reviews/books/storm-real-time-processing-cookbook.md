+++
title = "Storm Real-Time Processing Cookbook - Quinton Anderson"
date = 2017-07-30

[taxonomies]
tags = ["books", "quinton anderson", "reviews", "it", "storm", 
"stream processing", "big data", "2 stars"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/18430542-storm-real-time-processing-cookbook):
A Cookbook with plenty of practical recipes for different uses of Storm.If you
are a Java developer with basic knowledge of real-time processing and would
like to learn Storm to process unbounded streams of data in real time, then
this book is for you.

<!-- more -->

{{ stars(stars=2) }}

The book presents a couple of problems and how to solve them in Storm. Or, at
least, that's the premise.

The whole problem is that the problem is described in very high level, like
"process the logs". While this sounds alright, the book never goes to explain
*how* the logs are store, they format and so on. So you have a solution for a
very high level which you have no idea how good the solution could be because
you have no idea how the data exists. It simply does and the Storm topology
process it and that's it.

Another problem is that, because all solutions are written in Java and Java is
too damn verbose, instead of showing the whole code, the book goes into "Go to
the file X, use the IDE to automatically add the imports and add this
function." You never get a clear picture of how a complete bolt looks like.
