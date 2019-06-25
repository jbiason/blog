+++
title = "Things I Learnt The Hard Way - If Your Data Has a Schema, Use a Structure"
date = 2019-06-25

[taxonomies]
tags = ["en-au", "books", "things i learnt", "data classes", "structs"]
+++

You may be tempted to use a list (or tuple, if your language allows) to keep
your data if it's simple -- like, say, only 2 fields. Don't.

<!-- more -->

Some languages allow unstructured data to be kept in the format of tuples:
They act like lists, but you can use to store heterogeneous data (which is a
cute way of "it stores fields of different types").

This languages also allow you to "destructurize" them, so you can extract
elements from them without directly accessing them by index.

For example, in Python, you can have a tuple with:

```python
a_tuple = ('A String', 1, 7.5)
```

And you can destructure it with

```python
some_string, an_integer, a_float = a_tuple
```

See? It's simple! You don't need to create a whole structure if you're just
passing a string, an integer and a float around.

Except, you do.

Tuples and destructuring should be used only when you need to pass data from
one function to another -- and barely that. When you have this tuple being
passed around, being destructured and created again -- say, you are adding one
value of the tuple to another value and producing a new tuple in the same
format -- then you have a structured data.

And when you have a structured data, you must use a data class or a struct (or
even
[NamedTuples](https://docs.python.org/3/library/collections.html?highlight=namedtuple#collections.namedtuple),
if you're using Python).

Although it may look way more simpler to keep destructuring and building the
tuple over and over, in the long run you'll end up with a mess 'cause a simple
change -- like adding a new field -- will require checking every destructuring
and every creation of the tuple to make sure if will stay in the same shape
every time.

So: You data has a schema? Use a Data Class or Class or Struct. Only if it is
schemaless, then you can use a tuple.

I've seen this used at least once. Sure, at the very start of the project, it
may seem easier to just store the data as a tuple and destructure it and build
it again when needed. There was even a whole module designed to receiving
tuples, destructure them and rebuild new ones (for example, a function that
would receive two tuples and compute the sum of the "value" field of each,
building a new tuple as a result). But because of this design, to add just a
new field, I had to change 14 files and do 168 changes around -- 'cause, sure,
there was a function to add two tuples, but there were points where you need
just one field, and there wasn't a function for it.

It would be easier to use if there were functions to extract each field, and
add two tuples, and what else was needed for managing the tuples, but then you
have to ask yourself: Why not use a class for that?

{{ chapters(prev_chapter_link="/books/things-i-learnt/data-types", prev_chapter_title="Types Say What Your Data Is", next_chapter_link="/books/things-i-learnt/outside-project", next_chapter_title="Don't Mess With Things Outside Your Project") }}
