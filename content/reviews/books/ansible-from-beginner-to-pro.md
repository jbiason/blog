+++
title = "Ansible: From Beginner to Pro - Michael Heap"
date = 2020-04-03

[taxonomies]
tags = ["books", "reviews", "ti", "ansible", "michael heap", "2020 challenge"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/29201033-ansible):
This book is your concise guide to Ansible, the simple way to automate apps
and IT infrastructure. In less than 250 pages, this book takes you from
knowing nothing about configuration management to understanding how to use
Ansible in a professional setting.

<!-- more -->

{{ stars(stars=3) }}

It's kinda hard to put a review on this. I mean, yes, it takes you from the
basics of Ansible, explaining how to build a playbook, split things into
roles, adding triggers... the normal Ansible stuff.

The problem lies on the Python part. Ansible is built on top of Python and the
book mentions the current version of Python: 2.6. Problem is, Python 2.6 was
released in 2008 and the 2.x series in unsupported at this point. Surely, it's
a matter of time for this kind of stuff to happen, but still...

Also, it seems the author didn't really know Python. The last part, when
talking about building your own Ansible module, it uses the long version to
build dictionaries, `dict(key=value)`, instead of the classic and short
`{'key': value}`. There is no explanation why use this version instead.

Sure, at this point, it helps beginners with Ansible, but I'm not quite sure
if the "Pro" part still holds up.
