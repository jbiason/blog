+++
title = "Nice Troubled Astatine"
date = 2022-08-03
update = 2023-07-27

[taxonomies]
tags = ["projects", "personal", "notes", "note taking", "microblog", "twitter"]
+++

Note Taking Application

<!-- more -->

A (I hope) novel idea about note taking apps: Instead of keeping the notes and
having either links or tags to link different content, each note is short and
you can create a thread of notes, somewhat similar to the way microblogging
tools like Twitter and Mastodon work.

Still thinking on storage. Initially, it feels like using SQLite would suffice,
but I'd prefer some text format for not "locking" the content into a single
thing.

Text Storage could be a couple of Markdown with special links, but that means
that building a whole graph of connected notes (all the threads in your notes)
would take a massive time, since every note would have to be scanned and marked
as a parent or child of another (also, a child note could appear before a
parent, and we would need to take that in care). Another solution would use a
hidden file for the index: all notes are markdown (with or without the special
links) but a single file contains the whole note structure. This could create
an issue when the user manually changes a note.

## Ideas for a GUI

### Insert note

```
+-------------------------------------------------+
| +---------------------------------------------+ |
| | New note:                                   | |
| | [                                         ] | |
| | [                                         ] | |
| |                               [ + Add new ] | |
| +---------------------------------------------+ |
|                                                 |
| +---------------------------------------------+ |
| | This is a note                              | |
| | 2022-08-03 15:53  [ Delete ] [ + Followup ] | |
| +---------------------------------------------+ |
|                                                 |
| +---------------------------------------------| |
| | Another note, not necessarily a follow up   | |
| | of the one above.                           | |
| | 2022-08-03 15:50  [ Delete ] [ + Followup ] | |
| +---------------------------------------------+ |
+-------------------------------------------------+
```

### Map view

```
              +-------------------------+
             -| A follow up of "A note" |
+---------+ / +-------------------------+
| A note  |-
+---------+ \ +-------------------+   +------------------------+
             -| Another follow up |---| Follow up of "Another" |
              +-------------------+   +------------------------+
```

## Storage

Since we are keeping things in Markdown, it seems it would be good to have a
proper format that could also be read as a normal markdown.

```
# Note title

This is a note
---
2022-08-23 15:53
[parent-note-id](parent note)
Children:
  - [child1](Child 1)
  - [child2](Child 2)
```

```
# A note

This note has no parent and no children.

---
2023-07-27 14:46
```

```
# A prent note

This note has no parent, only children.

---
2022-08-23 15:53
Children:
  - [child1](Child 1)
  - [child2](Child 2)
```

The "note title" would also be the filename, *sluggered* (if that's even a
word). Also note that the GUI design does not have title, but those are
interesting 'cause that would produce the proper filename[^1].

There should be an index of sorts, with all the notes in order of insertion
(most recent to the oldest), just to speed up loading. This "index" would be
read as paging, so if we want Page 10, we would probably need

---

[^1]: Note that there aren't titles in the GUI mock up 'cause the Mockup is
    older than the idea of using Markdown files, and I want to keep some
    "history" of the project there.
