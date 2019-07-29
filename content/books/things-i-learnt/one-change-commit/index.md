+++
title = "Things I Learnt The Hard Way - One Commit Per Change"
date = 2019-07-09

[taxonomies]
tags = ["en-au", "books", "things i learnt", "source control", "commits"]
+++

When working with source control tools, keep one change per commit. Avoid
bundling more than one change in a single commit just to "save time".

<!-- more -->

I've seen my fair share of commits with messages like "Fix issues #1, #2 
and #3". This is not something you should do. One commit for fixing issue #1,
another for #2 and yet another for #3.

Just note that I said "one commit per change", not "one commit per file".
Sometimes, to make a single change, you may need to change more than one file
-- it may point that you have a coupling problem, but that's a different
issue. You could, for example, make one commit which adds a new field in model
without adding a change in the controller to load this field; after all, the
controller won't (or, at least, shouldn't) break due the added field, and the
model won't break (or, at least, shouldn't) break because the controller is
not touching the field[^1].

When making a commit, think this: "In case something goes wrong, can I undo
this commit without breaking other stuff?" Commit history is stacked, so
obviously you'd have to undo the commits on top of that one. And that's
alright.

**BONUS TIP**! If you're using `git`, you can use `git add -p` in case you
"overchange". It will allow you to pick parts of a file, instead of adding all
the changes in the file before committing.

[^1]: Ok, it _may_ have some issues if the field can't be null, but you get
  what I meant, right?

{{ chapters(prev_chapter_link="/books/things-i-learnt/always-vcs", prev_chapter_title="Always Use A Version Control System", next_chapter_link="/books/things-i-learnr/gerrit", next_chapter_title="Gerrit Is A Mistake") }}
