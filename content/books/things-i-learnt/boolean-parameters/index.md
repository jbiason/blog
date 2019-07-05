+++
title = "Things I Learnt The Hard Way - Don't Use Booleans As Parameters"
date = 2019-06-23

[taxonomies]
tags = ["en-au", "books", "things i learnt", "booleans", "functions", "parameters"]
+++

When you're designing a function, you may be tempted to add a flag (a
parameter in a function that it is a boolean). Don't do this.

<!-- more -->

Here, let me show you an example: Suppose you have a messaging system and you
have a function that returns all the messages to an user, called
`getUserMessages`. But there is a case where you need to return a summary of
each message (say, the first paragraph) or the full message. So you add a
flag/Boolean parameter called `retrieveFullMessage`.

Again, don't do that.

'Cause anyone reading your code will see `getUserMessage(userId, true)` and
wonder what the heck that `true` means.

You can either rename the function to `getUserMessageSummaries` and have
another `getUserMessagesFull` or something around those lines, but each
function just call the original `getUserMessage` with true or false -- but the
interface to the outside of your class/module will still be clear.

But _don't_ add flags/Boolean parameters to your API.

{{ chapters(prev_chapter_link="/books/things-i-learnt/future-trashing", prev_chapter_title="Future Thinking is Future Trashing", next_chapter_link="/books/things-i-learnt/interface-changes", next_chapter_title="Beware of Interface Changes") }}
