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

{{ chapters(prev_chapter_link="/books/things-i-learnt/data-types", prev_chapter_title="Types Say What Your Data Is", next_chapter_link="/books/things-i-learnt/languages-are-more", next_chapter_title="A Language Is Much More Than A Language") }}
