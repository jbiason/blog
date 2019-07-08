+++
title = "Things I Learnt The Hard Way - Good Languages Come With Integrated Documentation"
date = 2019-06-23

[taxonomies]
tags = ["en-au", "books", "things i learnt", "languages", "documentation"]
+++

If you're worried about learning some new programming language, you can bet
the one with a better documentation is the one that is _born_ with a document
processor.

Same goes for the frameworks/libraries of that language.

<!-- more -->

The answer for that is the same as [languages that come with
tests](languages-tests): because the programming language standard library
comes with a documentation generator or even because documentation is bundled
in the language itself, it reduces the friction needed to start writing the
documentation.

Python is a curious case that it came with a simple documentation generator
(PyDoc) and a bundled documentation format (DocStrings). Nowadays, almost
nobody is using the default documentation generator anymore, but because the
documentation format is still there and is still supported by the language
(documentation appears as a property of every function, class and module),
other tools took the post of default documentation generator, but the
documentation format is still heavy used.

Also, the opposite seems almost always true: If the language doesn't come with
integrated documentation, there is a very good chance that the documentation
or the language or frameworks and libraries will be bad. Or, in the very
least, every library will pick its own format, every framework will pick its
own format and they will never match the language format, and you'll end up
with a mess of a documentation to decipher.

{{ chapters(prev_chapter_link="/books/things-i-learnt/document-and", prev_chapter_title="If A Function Description Includes An And, It's Wrong", next_chapter_link="/books/things-i-learnt/always-vcs", next_chapter_title="Always Use A Version Control System") }}
