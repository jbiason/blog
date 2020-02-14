+++
title = "Code is a Book, Unit Tests are Spellcheckers"
date = 2020-02-14

[taxonomies]
tags = ["unit tests", "testing", "integration tests", "books", "code"]
+++

If we use an analogy for code as being the words in a book and the system
being built as the whole book, then what are unit tests?

<!-- more -->

I just found this analogy pretty good[^1]: You can to think about your code
as a book: Each module is a chapter, each class is a paragraph and each
function is a sentence.

In that analogy, were would unit tests sit?

To me, the unit tests are like spell checkers -- or, at least, the more modern
ones: Are you writing the proper words? Are your sentences grammatically
correct? The spell checker will take care of this.

But there is one thing that the spell checker won't do: make sure the chapter
makes sense in the whole context of the book. Escaping the analogy for a
moment, let me ask you this: Have you read "Les Misérables"? I did, and there
is one chapter in the middle of the book in which Victor Hugo discuss the
Battle of Waterloo. Although it makes sense in the historical point of the
story of Les Misérables, it makes absolutely no sense in the general story
itself -- no matter how well punctuate, correct in spelling and grammar it may
be.

This is a huge failure of unit tests: They don't see the whole. The whole is
given by reviewers of a book and integration tests of a system. Jumping back
to the analogy, when you have your integration tests defined by the system
requisites, anything that isn't being covered is a chapter that doesn't make
sense in the whole of the book.

In the long run, as writers will remember the times the spell checker
pointed a word was spelled wrong or a verb was in the wrong tense and, thus,
make it pop less and less, so does unit tests: In the long run, the ROI[^2] of
unit tests tend to go down, while the integration tests -- the ones that check
if the "chapter" makes sense in the story being told by the "book" -- tend to
go up.

And I just found the analogy so good for the way I see those two test
methodologies.

---

[^1]: ... but I lost the source of it. :(

[^2]: "Return Of Investment"
