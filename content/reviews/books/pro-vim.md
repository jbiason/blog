+++
title = "Pro Vim - Mark McDonnell"
date = 2019-09-04

[taxonomies]
tags = ["books", "reviews", "vim", "mark mcdonnell"]
+++

[GoodReads link](https://www.goodreads.com/book/show/23717582-pro-vim): (No
summary exists).

<!-- more -->

{{ stars(stars=2) }}

First, the disclaimers: I'm a VIM user since early 2000; I wrote a "Using VIM"
book-of-sorts (in Portuguese); this book is, at the time of this review, 5
years old.

The book intro said it was called "Pro" 'cause there was no middle ground for
VIM: when you start learning VIM, you have to go all the way to pro.

So, is it a book aimed for beginners? Maybe. VIM has a very steep learning
curve, but things can be smoothed out by explaining things in steps; because
VIM uses composable commands, you can explain movement -- say, "w" moves the
cursor to "next Word", "e" moves the cursor to the end of the word and so on
-- and then explain that you can modify the text using a verb and a movement
-- "d" is delete and "dw" means "delete word". But the book decides to jump
around and, while explaining movement, jumps into the modification verbs
without explaining verbs before: There you are, leisurely reading about moving
the cursor around and suddenly a "c2w" appears, with no explanation of what
the "c" or "2" does. It works, but I have the feeling that it more confusing
to dump things straight away than explaining step by step and how things
connect.

Is it a book aimed for people who already know VIM? Maybe not. Surely there
are a few things one can still learn about VIM years after using it, but after
20 years, I guess I read everything VIM can do at this point. But, again,
maybe you don't have 20 years of VIM and there are things you still don't
know.

Does it show ways to make you more productive in VIM? I'm not sure. I mean,
the whole book is based on the author's workflow -- a workflow that is only
slightly exposed -- and if you don't have the same workflow... Maybe it won't
fit at all on yours, 'cause it focus on the workflow and not on how certain
movements/commands can improve yours.

Is this book up-to-date? In the VIM commands part, yes. In the plug-ins... not
so much. VIM got a bunch of new releases recently (say, last year) and, thus,
a lot has changed in the plug-in area. Surely Fugitive (which the author
decided it should be called "fugative", for some reason) is still the most
feature-complete Git plugin, but everything else was already replaced (and
yes, that book-of-sorts I wrote also suffers from this problem).

Why Tmux is there? Well, VIM mixes well with Tmux, but I have to ask
<i>why</i> it is there. Why there isn't a section for rxvt, for example? Or
Gnome-Terminal? Doesn't VIM mixes well with those too? (My guess is, again,
that the book focus a lot on the author's workflow and not how things in the
workflow improved things, so because the author feels Tmux improved his
workflow, we must talk about Tmux). There is also the problem that the author
recommends using his configuration, so a lot of keybinds are not the default
ones, and one starting from scratch may not understand why things aren't
working.

Again, the book didn't age well. Plugins are out of date, there should be a
serious editorial work on it -- one chapter has paragraphs with garbled
content, which is completely unintelligible -- there is no "Style Conventions"
for things, so keystrokes will appear in one style in one chapter and in a
different style in the next. And some things are shown in one chapter and only
explained in the next, which makes me think the order was changed after the
chapters were written.

In general, it may be OK if you are starting with VIM, but that's that.
