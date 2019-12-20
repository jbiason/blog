+++
title = "Things I Learnt The Hard Way - Git-Flow Is The Way To Go"
date = 2019-07-30

[taxonomies]
tags = ["books", "things i learnt", "git", "git flow", "source control"]
+++

If [Gerrit is such a mistake](/books/thing-i-learnt/gerrit), what can you use
instead? Git Flow!

<!-- more -->

Git Flow is a plugin for Git for managing branches. It is based on the concept
of "feature branches", in which each branch is a feature or bug you're working
on. Once you finish it, it will just close the branch.

Although there is a lot to be said about Git and how you should use it, the
fact is that Git Flow manages a lot of complexity of having a stable branch,
an "unstable"/testing branch and all features around those.

Not only that, but with the current source control sites like Github and
GitLab, the flow is quite similar -- although working with branches is changed
with forks.

You can even install Git Flow and use it on your personal project -- which is
something I do with this blog/book!

{{ chapters(prev_chapter_link="/books/things-i-learnt/gerrit", prev_chapter_title="Gerrit Is A Mistake", next_chapter_link="/books/things-i-learnt/project-organization", next_chapter_title="Organize Your Code by Data/Type, Not Functionality") }}
