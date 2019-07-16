+++
title = "Things I Learnt The Hard Way - Code Reviews Are Not For Style"
date = 2019-07-16

[taxonomies]
tags = ["en-au", "books", "things i learnt", "code reviews", "code style"]
+++

When doing code reviews, do not focus on style; focus on design things that
look a bit weird.

<!-- more -->

Code reviews are designed to spread knowledge around the team, with focus on
construction and problem description. Does the sequence of code gives you an
understanding on what it is trying to do? Does it contains something you know
it will make things harder to read in the future? Does it miss the point?

That's the things you should focus.

If the author of the code missed a space here, left a blank line there...
that's of no consequence in a code review. This is not the thing to discuss in
the code review.

And people _hate_ people who go through code reviews just to point
missing/extra spaces and lines.

On the other hand, if you find something weird in the code which is something
you want the author to recheck, _then_ you're free to comment that "it would
be good" if they fix the style. But that's it.

{{ chapters(prev_chapter_link="/books/things-i-learnt/right-tool-obvious", prev_chapter_title="The Right Tool Is More Obvious Than You Think", next_chapter_link="/books/things-i-learnt/right-tool-obvious", next_chapter_title="The Right Tool Is More Obvious Than You Think") }}
