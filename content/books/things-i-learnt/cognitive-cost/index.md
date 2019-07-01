+++
title = "Things I Learnt The Hard Way - Cognitive Cost Is The Readability Killer"
date = 2019-06-26

[taxonomies]
tags = ["en-au", "books", "things i learnt", "cognitive dissonance", "cognitive cost"]
+++

"[Cognitive dissonance](https://en.wikipedia.org/wiki/Cognitive_dissonance)" 
is a fancy way of saying "I need to remember two (or more) different and
contradicting things at the same time to understand this." Keeping those
different things in your head creates a cost and it keeps accumulating the
more indirect the things are ('cause you'll have to keep all those in your
head).

<!-- more -->

(Disclaimer: I like to use the expression "cognitive dissonance" to make me
sound smarter. I usually explain what it means, though.)

To give you an example of a (very mild) cognitive cost, I'll show you this:

* You have a function called `sum()`. It does the sum of the numbers of a
	list.
* You have another function, called `is_pred()`. It gets a value and, if it
	fits the predicate -- a test, basically -- returns True; otherwise,
	returns False.

So, pretty simple, right? One function sums numbers and another returns a
boolean.

Now, what would you say if I shown you this, in Python:

```python
sum(is_pred(x) for x in my_list)
```

Wait, didn't I say that `sum()` sums numbers? And that `is_pred()` returns a
boolean? How can I sum booleans? What's the expected result of True + True +
False?

Sadly, this works. Because someone, long time ago, didn't think booleans were
worth a thing and used an integer instead. And everyone else since then did
the same stupid mistake.

But, for you, you'll now read a line that says "summing a boolean list returns
a number". And that's two different, disparate things that you suddenly have
to keep in mind when reading that line.

That's why [types are important](/books/things-i-learnt/data-types) are
important. Also, this may sound a bit like [the magical number
seven](/books/things-i-learnt/magical-number-seven), 'cause you have to keep
two things at your mind at the same thing but, although that's not near seven,
they are not the same, with opposite (for weird meanings of "opposite", in this
case) meanings.

{{ chapters(prev_chapter_link="/books/things-i-learnt/magical-number-seven", prev_chapter_title="The Magic Number Seven, Plus Or Minus Two", next_chapter_link="/books/things-i-learnt/functional-programming", next_chapter_title="Learn The Basics of Functional Programming") }}
