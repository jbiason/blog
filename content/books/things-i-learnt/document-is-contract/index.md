+++
title = "Things I Learnt The Hard Way - The Function Documentation Is Its Contract"
date = 2019-06-21

[taxonomies]
tags = ["en-au", "books", "things i learnt", "documentation", "contracts"]
+++

When you start the code by [writing the
documentation](/books/things-i-learnt/steps-as-comments), you're actually
making a contract (probably with your future self): I'm saying this function
does _this_ and _this_ is what it does.

<!-- more -->

Remember that the documentation must be a clear explanation of what your code
_is_ doing; remember that good messages will make [reading the code only by
the function documentation](/books/things-i-learnt/document-id) should be
clear.

A function called `mult`, documented as "Get the value and multiply by 2" but,
when you look at the code, it does multiply by 2, but sends the result through
the network or even just asks a remote service to multiply the incoming result
by 2, is clearly breaking its contract. It's not just multiplying by 2, it's
doing more than just that, or it's asking someone else to manipulate the
value.

Now, what happens when this kind of thing happens?

The easy solution is to change the documentation. But do you know if people
who called the function expecting it to be "multiply value by 2" will be happy
for it to call an external service? There is a clear breach of "contract" --
whatever you initially said your function would do -- so the correct solution
would be to add a new function with a proper contract -- and probably a better
name.

{{ chapters(prev_chapter_link="/books/things-i-learnt/document-it", prev_chapter_title="Documentation Is a Love Letter To Your Future Self", next_chapter_link="/books/things-i-learnt/throw-away", next_chapter_title="Be Ready To Throw Your Code Away") }}
