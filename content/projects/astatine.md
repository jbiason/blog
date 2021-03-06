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
# A parent note

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

Another option for the title: Top level notes can have just one line, which is
the title for the thread. All child notes could have a versioning-like scheme
for them, like

```
Single line note  (becomes single-line-note.md)
|-- note content (becomes single-line-note-1.md)
| |-- another note content (becomes single-line-note-1-1.md)
| \-- more content (becomes single-line-content-1-2.md)
\-- more content (becomes single-line-note-2.md)
```

This can be done 'cause the note we would add a follow up already have a list
of children, so it's just a matter of adding "-1" if the note has no children
yet, or "last id + 1" otherwise.

There should be an index of sorts, with all the notes in order of insertion
(most recent to the oldest), just to speed up loading. This "index" would be
read as paging, so if we want Page 10, we would probably need

## Web

One nice thing to have, which could replace the GUI, is to have a Web
interface. This would allow using outside our device (as long as it have
internet access) and to make notes public or private.

If we do this, there should be two indexes files: One for everything and one
for only public notes. When the user is logged in (and since notes are
personal, only one user would be accepted), the system loads notes from the all
notes index; if it is not, only the public notes index is read.

---

[^1]: Note that there aren't titles in the GUI mock up 'cause the Mockup is
    older than the idea of using Markdown files, and I want to keep some
    "history" of the project there.
