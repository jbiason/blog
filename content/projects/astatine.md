+++
title = "Nice Troubled Astatine"
date = 2022-08-03

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
