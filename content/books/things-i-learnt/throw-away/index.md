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
the long run.

You shouldn't worry about this. Your code is not a wall: if you have to throw
it always, it is not wasted material. Surely it means your time writing code
was lost, but you got a better understanding about the problem now.

Not only that, but as you progress through your project, solving problems and
getting "acquainted" with the problem, you'll also notice that the
[spec](/books/things-i-learnt/spec-first) will also change. This means that the problem you solved
wasn't exactly the problem you _needed_ to solve; your code is trying to solve
something that isn't exactly the problem.

Also, this is really common -- the spec changing, not throwing the code away,
that is. One thing that you can be sure is that it won't change _everywhere_.
Some of the things you solved will stay the same, some others will be
completely removed and some others added. And you will see that you'll
refactor your code a lot, and throw a lot of code away. And not just code that
solves the problem, but also the tests for that code.

... unless you focus mostly on [integration
tests](/books/things-i-learnt/integration-tests).

{{ chapters(prev_chapter_link="/books/things-i-learnt/document-is-contract", prev_chapter_title="The Function Documentation Is Its Contract", next_chapter_link="/books/things-i-learnt/future-trashing", next_chapter_title="Future Thinking Is Future Trashing") }}
