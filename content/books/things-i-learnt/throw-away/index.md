+++
title = "Things I Learnt The Hard Way - Be Ready To Throw Your Code Away"
date = 2019-06-19

[taxonomies]
tags = ["en-au", "book", "things i learnt", "code"]
+++

A lot of people, when they start with TDD, get annoyed when you say that you
may have to rewrite a lot of stuff, including whatever your already wrote.

<!-- more -->

TDD was _designed_ to throw code away: The more you learn about your problem,
the more you understand that, whatever you wrote, won't solve the problem in
the long run. Also, as you slowly solve new problems, you may notice some
pattern in the code emerging (you're doing the same thing over and over, with
only minor changes). That's a good time to go over and rewrite everything to
take advantage of this pattern.

You shouldn't worry about this. Your code is not a wall (or any physical
object): if you have to throw it away, you didn't wasted materials. Surely it
means your time writing code was lost, but you got a better understanding
about the problem now, or you may start to think in a more concise way to
solve the problem.

Not only that, but as you progress through your project, solving problems and
getting "acquainted" with the problem, you'll also notice that the
[spec](/books/things-i-learnt/spec-first) will also change. This means that
the problem your code solve wasn't exactly the problem you _needed_ to solve;
your code is trying to solve something that isn't exactly the problem.

Also, specs changing is really common.  One thing that you can be sure is that
it won't change _everywhere_.  Some of the things you solved will stay the
same, some others will be completely removed and some others added. And you
will see that you'll refactor your code a lot, and throw a lot of code away.
And not just code that solves the problem, but also the tests for that code.

... unless you focus mostly on [integration
tests](/books/things-i-learnt/integration-tests).

{{ chapters(prev_chapter_link="/books/things-i-learnt/always-vcs", prev_chapter_title="Always Use A Version Control System", next_chapter_link="/books/things-i-learnt/one-change-commit", next_chapter_title="One Commit Per Change") }}
