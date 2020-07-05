+++
title = "Web Development with Django Cookbook - Aidas Bendoraitis"
date = 2016-07-10

[taxonomies]
tags = ["books", "aidas bendoraitis", "reviews", "python", "django", 
"web development", "it", "1 star"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/23477190-web-development-with-django-cookbook):
Over 70 practical recipes to create multilingual, responsive, and scalable
websites with Django About This Book Improve your skills by developing models,
forms, views, and templates Create a rich user experience using Ajax and other
JavaScript techniques A practical guide to writing and using APIs to import or
export data Who This Book Is For.

<!-- more -->

{{ stars(stars=1) }}

First point: This book is terribly outdated. It focus on Django 1.6, which is
at least 3 versions behind the current one (at the time of this review). 1.6
is so old that you can't find its documentation on the Django Project page
anymore.

Second point: This book is terrible. I mean, one of the very first examples it
talks about a mixin with creation date and modified date, which is pretty damn
easy with Django, but instead of using "auto_now=True" and/or
"auto_now_add=True", it overrides save() on the model. Now terrible enough?
Later in the book, it creates a templatetag to access model directly, which
completely obliterates the MVT (model-view-template) model of Django. Still
not terrible enough? Again in the very first part of the book, to prevent
browser caching issues, it gives a recipe for using the SVN revision in the
static path; the wrong part of it is: a) it means you'll have to have SVN in
your server instead of using proper setup.py to deliver your apps, b) it does
a system() call, which is slow, c) there is a prop in SVN which allows you to
use "$Id$" to automatically save the revision on commit (pretty much like CSV)
and d) If you're having caching issues, that's a problem with your webserver,
not Django.

(I won't even talk about long chapters talking about MPTT with examples either
don't show the tool properly or MPTT is so useless one could replace it with a
single ForeignKey.)

The whole book feels like someone searched for "django" on StackOverflow and
dropped the first answers.

In the end, the book is only good for giving you some ideas of what is
available with Django, not how to properly develop a Django app.
