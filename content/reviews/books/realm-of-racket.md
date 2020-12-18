+++
title = "Realm of Racket: Lean to Program, One Game at a Time!"
date = 2020-12-18

[taxonomies]
tags = ["books", "reviews", "it", "racket", "2020 challenge", "2 stars"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/17153511-realm-of-racket):
Racket is a descendant of Lisp, a programming
language renowned for its elegance, power, and challenging learning
curve. But while Racket retains the functional goodness of Lisp, it
was designed with beginning programmers in mind. Realm of Racket is
your introduction to the Racket language.

<!-- more -->

{{ stars(stars=2) }}

This is a weird book. Not because its content, or the topic at hand,
but the path chosen to explain things. For example, even after reading
the whole book, I don't have any idea why I should pick Racket over
any other Lisp variant.

So, laundry list of things that put me off:

- No real explanation on why I should pick Racket over any other Lisp
  (or any other language, for that matter); they don't say it's faster,
  or more accurate, or it's syntax makes you write less bugs or the
  compiler will prevent you from doing it so.

- There is a strong favouritism for Racket. It isn't that unexpected,
  but they authors start by bashing other languages, which gives a
  feeling that they just want to make their favourite language look
  better (this goes away only in the last chapter, when comparing Racket
  to Java).

- They use different words for common things. There isn't and IDE, it
  is a PDE, "program development environment"; the integrated
  development environment becomes "interactive development
  environment"; functions don't "receive" parameters, they "consume"
  the values, which make it sound more like a Rust thing, in which the
  function gets the ownership of the value and, on its end, the memory
  is freed, which doesn't happen in Racket.

- There is a bunch of "trivial", "simple", and such. This is bad,
  specially if you want newbies to read the book; if they don't grasp
  the concept, saying it is "trivial" will make them feel bad about
  themselves.

- A lot of explanations are basically "(+ a 1)" -> "adds 1 to
  a". Sure, one may not understand all the facets of the code, but
  when you explain "why" you wrote code that way instead of "what" the
  code is, it is a lot easier to understand.

- Because the book is too focused on explaining one single library,
  some things feel like "if everything you have is a hammer". For
  example, there is one game of attacking monsters and which the
  authors put the target in the state, and it doesn't feel like this
  should be part of the state of the game. Sure, the selected target
  affects the state, but it is not part of the state, at least for me,
  and there isn't any good explanation on why it should be part of it.

- Another example uses a complex number to represent points in a 2D
  plane. Sure, 2D points and complex numbers are composed by two
  elements, but that doesn't mean that 2D points **are** complex
  numbers. Types matter, even in dynamic languages.

So... yeah, I think I learn a bit of Racket, but I still don't know
why I should pick it over anything else. Is it just the game building
library? Should one pick a language exclusively because of some built
in library? Doesn't anything else affects this decision? (All
questions are rhetorical, it is obvious that you shouldn't pick a
language just because one library).

---

Highlights:

> `(foo)*g++.baz(!&qux::zip->ding());`

"Let me write a very contrived example, just to make my favourite
language look better compared to this one."

> `(sqrt (+ (sqr 3) (sqr 4)))`

This is nowhere _near_ the example in C++. If you want to compare
languages, at least write the same thing.

> If you’re on a *nix box, you are already a hero and don’t need instructions.

What a load of bull. It sounds more like you don't have an idea on how
to do it in Linux.

> (the compiler) DrRacket reads this expression, evaluates it,
> prints the result, and then displays its prompt again.

You just described an interpreter, not a compiler. For all purposes
and intents, sure, it compiles the code to make sure it is not
invalid, but the concept of "compiler" is used mostly for things that
take a source and produce a stand-alone executable. Otherwise, even
Python have a compiler.

>  the function uses a set! expression to change the value of a
>  variable.

Why `set!`? Why not just `set`? What the `!` means? Nothing? Is it
just a convention?

>  Racket has three kinds of comments 

And absolutely no example of those kinds.

> ``` 
> (/ 4 6)
> 2/3```

This is one cool thing: Racket keeps the values in their fractional
format.

> ```(struct student (name id# dorm))
> (student-name freshman1)
> 'Joe
> (student-id# freshman1)
> 1234```

Creating structs and extracting values from them.

> ```(define x 7)
>   (cond [(= x 7) 5]
>         [(odd? x) 'odd-number]
>         [else 'even-number])```

Multiple tests. Also, there is this use of brackets ("[") and
parenthesis ("(") which is never properly explained, though.

> ```
> (when (and file-modified (ask-user-about-saving)) (save-file))
> ```

Because `and` and `or` return the value if it's not the boolean false
(`#f`), you can use tests to simplify the code.

> ```
> (define filename "my-first-program.rkt")
> (unless (ask-user-whether-to-keep-file filename) (delete-file filename))
> ```

`unless` is a form of `if` that performs an action only if the value
is `#f` (false).

> ```
> (struct orc monster (club))
> (struct hydra monster ())
> (struct slime monster (sliminess))
> (struct brigand monster ())
> ```

Examples of deriving structs from other structs.

>  In summary, mutators make programming complex 

Just a few paragraphs better, you used a mutator saying that this
would make the code better.

>  `raco exe -l hello-world.rkt`

Generating a standalone executable from Racket source code.

> ```
> (define snake%
>   (class object%
>     (super-new)
>     (init-field dir head tail)
>     (define/public (slither)
>       (set! tail (cons head (all-but-last tail)))
>       (set! head (next-head)))
> ```

Classes in Racket.
