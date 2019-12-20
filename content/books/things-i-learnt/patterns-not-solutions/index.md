+++
title = "Things I Learnt The Hard Way - Design Patters Are Used to Name Solution, Not Find Them"
date = 2019-06-25

[taxonomies]
tags = ["books", "things i learnt", "design patterns"]
+++

Most of the times I saw design patterns being applied, they were applied as a
way to find a solution, so you end up twisting a solution -- and, sometimes,
the problem it self -- to fit the pattern.

<!-- more -->

My guess is that the heavy use of "let's apply _this_ design pattern" before
even understanding the problem -- or even trying to solve it -- comes as a
form of [cargo cult](/books/things-i-learnt/cargo-cult): "We saw that people
used this pattern and solved their problem, so let's use it too and it will
solve our problem". Or, worse: "Design pattern is described by _Famous
Person_, so we must use it".

Here is the thing: Design pattern should _not_ be used as a way to find
solution to any problems. You may use some of them as base for your solution,
but you must focus on the _problem_, not the _pattern_. 

"Do a visitor pattern will solve this?" is the wrong question. "What should we
do to solve our problem?" is the real question. Once you went there and solved
the problem you may look back and see if it is a visitor pattern -- or whatever
pattern. If it doesn't, that's alright, 'cause you _solved the problem_. If it
did... well, congratulations, you now know how to name your solution.

I've seen this happening a lot: People have a problem; people decided to use a
pattern; the pattern doesn't actually solve the problem (not in the 100% mark,
but above 50%); what happens then is that people start twisting the problem to
fit the pattern or, worse, add new layers to transform the problem into the
pattern.

{{ chapters(prev_chapter_link="/books/things-i-learnt/gherkin", prev_chapter_title="Gherkin Is Your Friend to Understand Expectations", next_chapter_link="/books/things-i-learnt/data-flow", next_chapter_title="Thinking Data Flow Beats Patterns") }}
