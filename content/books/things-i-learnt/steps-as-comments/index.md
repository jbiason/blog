+++
title = "Things I Learnt The Hard Way - Write Steps as Comments"
date = 2019-06-18

[taxonomies]
tags = ["en-au", "books", "things i learnt", "steps", "comments", "code"]
+++

Don't know how to solve your problem? Write the steps as comments in your
code.

<!-- more -->

There you are, looking at the blank file wondering how you're going to solve
that problem. Here is a tip:

Take the spec you (or someone else) wrote. Break each point into a series of
steps to reach the expected behaviour. You can even write on your natural
language, if you don't speak English.

Then fill the spaces between the comments with code.

For example, if you have a spec of "connect to server X and retrieve
everything there. Save the content in the database. Remember that server X API
allow you can pass an ID (the last ID seen) and you can use it to not retrieve
the same content again." Pretty simple, right?

Writing this as comments, pointing the steps you need to make, you may end up
with something like this:

```
// connect to server X
// retrieve posts
// send posts to the database
```

Ah, you forgot the part about the ID. No problem, you just have to add it in
the proper places -- for example, it doesn't make sense to connect to the
server before you have the last seen ID:

```
// open configuration file
// get value of the last seen ID; if it doesn't exist, it's empty.
// connect to server X
// retrieve posts starting at the last seen ID
// send posts to the database
// save the last seen ID in the configuration file
```

Now it is "easy"[^1]: You just add the code after each comment.

A better option is to change the comments into functions and, instead of
writing the code between the comments, you write the functionality in the
function themselves and keep a clean view of what your application does in the
main code.

[^1]: Yes, that was sarcastic.

{{ chapters(prev_chapter_link="/books/things-i-learnt/spec-first", prev_chapter_title="Specs First, Then Code", next_chapter_link="/books/things-i-learnt/gherkin", next_chapter_title="Gherkin Is Your Friend to Understand Expectations") }}
