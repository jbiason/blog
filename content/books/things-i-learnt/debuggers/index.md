+++
title = "Things I Learnt The Hard Way - Debuggers Are Overrated"
date = 2019-07-08

[taxonomies]
tags = ["en-au", "books", "things i learnt", "debuggers", "debugging"]
+++

I heard a lot of people complaining that code editors are bad 'cause it's hard
to attach a debugger. I'd claim that this vision is wrong.

<!-- more -->

But let's take a thing out of the way beforehand: I'm not saying debuggers are
_bad_ you should never use them. Debuggers have their use, but every time I
had to use one, it was because there was something missing.

Most recently, using a framework in Java, I had problems with my code. I'd
expect it [to crash](/books/things-i-learnt/crash-it) 'cause I didn't handle
things. What actually happened is that the framework silently hid the error
and restarted the processing. To find out what was happening, I had to attach
a debugger and see what was wrong with the data; otherwise, I'd have no idea
about what's wrong.

Was a debugger necessary there? I don't think so. If the framework actually
displayed the error (crashed, put a wall of text on the logs, whatever), I
wouldn't need to use a debugger. But, because something was missing, I did,
in fact, was _forced_ to use a debugger.

Besides this, in the long run, you'd end up with problems in locations that
you can't attach a debugger -- for example, your production environment. You
_could_ but you _shouldn't_ do this. On the other hand, if you [log
events](/books/things-i-learnt/log-events), then you can see what was going
on, without a debugger.

Again, I'm not taking the merits of debuggers, but in the long run, they are
mostly useless and actually point missing surrounding support to actually
understand what's going on.

{{ chapters(prev_chapter_link="/books/things-i-learnt/understand-shortcuts", prev_chapter_title="Shortcuts Are Nice, But Only In The Short Run", next_chapter_link="/books/things-i-learnt/users", next_chapter_title="Think About The Users") }}
