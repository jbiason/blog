+++
title = "Why Mixing Spaces and Tabs IS a Big Deal"
date = 2016-12-15

category = "code"

[taxonomies]
tags = ["tabs", "spaces", "clean code", "editors"]
+++

Why something so small is actually a big deal.

<!-- more -->

Reading Reddit comments about [How terrible code gets written by perfectly
sane people](https://www.reddit.com/r/programming/comments/5gc871/how_terrible_code_gets_written_by_perfectly_sane/)
when I read this comment:

>>  spaces/tabs for indentation

> Is this a joke? I've been programming professionally from 2008 and I've not
> yet found an actual case where this was an actual problem. The code looks
> the same on everyone's screen if you set tab length in the editor to same
> as the amount of spaces in your indentation. It would take seconds to fix
> this :) I've never seen a tabs vs spaces argument go anywhere. It's such a
> dumb thing to complain about. Maybe because I'm young I don't have
> experience of bad code editors of old days but it's 2016 now. It's not a
> big deal anymore.

Unfortunately, I lost the time to properly reply to this comment, but here it
goes:

No, it *isn't* a joke. If you've read [Clean Code](https://www.goodreads.com/book/show/3735293-clean-code?from_search=true),
you'd see that, at some point, Uncle Bob mentions that there isn't an actual
experiment about it, but his team personally found that a programmer that cares about
consistency and follows coding standards are prone to write less buggy code.

I get what he means: If someone cares about the small stuff,
they also care about the big stuff. It doesn't mean that people that ignore
coding standards (and the difference between using tabs and using spaces)
doesn't care about the big stuff; but on my own experience in those 28
years in the field proved the opposite: people who cared about
"putting the code at the door" without worrying about following coding standards
(and we can add tabs vs spaces here), proper code documentation,
separation of concerns, a good level of abstraction, tend to write
horrible/unmaintable code.

*This* is why mixed spaces/tabs is bad: it means that whoever didn't care enough
with something so small as the coding standard, probably didn't care
about the bigger stuff. Their only worry was to deliever stuff, no matter
what. "And no matter what" usually results in terrible code.

So, while not an "actual problem", it is an indicator that something really
terrible is going on. So, no, it isn't a joke and yes, it is a big deal. And
it has absolutely nothing to do with "bad code editors", it's a problem with
"bad coders".
