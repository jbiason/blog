+++
title = "Mastering Emacs, Mickey Petersen"
date = 2019-11-18

[taxonomies]
tags = ["books", "reviews", "emacs", "mickey petersen", "it"]
+++

[GoodReads summary](https://www.goodreads.com/book/show/25587882-mastering-emacs):
Learn Emacs from the ground up. In the Mastering Emacs ebook you will learn
the answers to all the concepts that take weeks, months or even years to truly
learn, all in one place.

<!-- more -->

{{ stars(stars=4) }}

Why is an avid VIM user -- to the point that I usually do some *gatekeeping* in
which is the true editor for real programmers [^1] -- reading a book about
Emacs?

Well, for one, I wanted to learn how to use Org-Mode better, but with my usual
EVIL bindings, its keybinds feel alien and did not make a lot of sense.

And, thus, I decided to read a book about Emacs, to gear me up for using Emacs
without EVIL and make a more smooth passage to Org-Mode.

In that, I guess I can say that the book helped me, although I'm pretty
confident that I'm going to use VIM/EVIL bindings from time to time -- muscle
memory is not that easy to change.

One thing that stuck with me after reading the book is the concept of "flow",
in which you start a sequence of commands all with the same modifiers (or, at
least, with a bigger set and then with a reduced set). For example, how you
can keep Ctrl+Alt pressed and execute a bunch of changes without ever removing
your hand from Ctrl+Alt, or maybe just dropping one of those two keys, but you
keep the modifiers up all the time through the transformation. And while this
sounds awesome, it also shows that some Emacs commands do not follow the flow
and make a big mess of "Ctrl+Alt+key, key, Alt+key" in sequence -- thus,
removing you from the "flow".

Even with that, I feel not everything was perfect:

- There is a push towards using the configuration buffer/tool inside Emacs,
  instead of showing the elisp command for that. I do understand that this
  makes the book lighter and removes a lot of redundant information (why
  describe how to set things up twice?) but with some things not being able to
  configure through the configuration tool and some not, it just looks...
  weird. And, to be honest, I'd prefer to see the elisp changes, 'cause one
  could expand it into "let me show you some changes you can make on your
  `init.el` to make this work" and, from there, you could expand to everything,
  including package management.
- Speaking of package management, I already have experience with use-package,
  which would download and enable packages, but there is no mention of it
  (maybe it is a recent addition?)
- Sometimes, there is the same mistake VIM books do: explaining some topic and
  going through it in a way to never come back. Although it does make sense
  sometimes, sometimes it does not: You can be talking about movement and,
  instead of explaining every single movement, you go to how to modify your
  code and then come back to movement to explain more complex things, 'cause
  they make more sense with text modification, making it easier to grasp the
  movement concepts than explaining it along several others (and, again,
  that's a mistake several VIM books do).
- As pointed, sometimes it shows how the flow can be broken, which would be
  better moved out of the way and kept at the very end of the book, which
  could be taken as being an example of the above point.

I could point that I'd like to have an EVIL topic, but the book starts saying
that it wouldn't touch that, so far point -- although I'd still prefer to have
some chapter about EVIL.

Also, I'd like to have a chapter about Org-Mode, but we can argue if that
makes sense to put along a "Mastering Emacs" topic or it should belong to some
other "Advanced" Emacs concepts.

In general, it's a good book about Emacs, specially pushing the concept of the
flow.

[^1]: Again, this is me playing with gatekeeping, a real programmer uses
  whatever editor fits their workflow better -- and that includes editors
  which do not fit my workflow.
