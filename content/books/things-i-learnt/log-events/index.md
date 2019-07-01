+++
title = "Things I Learnt The Hard Way - Logs Are For Events, Not User Interface"
date = 2019-07-01

[taxonomies]
tags = ["en-au", "books", "things i learnt", "logs", "ui"]
+++

Two things in one: First of all, when using logging, use it to log events, not
for user interfaces; second, log _events_ in a machine readable way, not
necessarily an human readable format.

<!-- more -->

For a long time, I used logs to show to the user what was happening. Nothing
could be the idea of displaying errors, general information and, if the user
requested, the internals of whatever is going on in one simple way. I mean,
yeah, let me add the errors, the info messages and the debug messages and let
the user decide what they want to see.

But that's not what logs are targeted for -- and now I'm having to rethink
most of the stuff I already wrote.

Use the standard output to inform the user what's going on, in a human
readable format; use the standard err to inform the user when things go wrong;
but use the logs to capture something that you'll have to process later, so
you should probably use a format that it is easier to parse, even if it is not
so friendly.

As an example, let's say you're connecting to a server. You could use the
standard output to say "Connecting to server", to give the user a feedback
about what's going on; at the same time, you could log "CONNECTION
[SERVER]", with the IP/Name of the server you're connecting. Surely, the
"CONNECTION" word is not that friendly to the user, but if you had to parse
the line, it would be really easy, wouldn't it?

Another example: If your application is adding a record to the database, there
is nothing wrong logging "ADDING_RECORD: field=value; field=value;
field=value" 'cause, in case something goes wrong while saving the record, you
could have the values to try to figure out why it failed -- surely, logging
why it failed also helps, but you know what I mean. This is an example of
something that makes complete sense in logs, but not in user interfaces.

{{ chapters(prev_chapter_link="/books/things-i-learnt/start-stupid", prev_chapter_title="Start Stupid", next_chapter_link="/books/things-i-learnt/languages-are-more", next_chapter_title="A Language Is Much More Than A Language") }}
