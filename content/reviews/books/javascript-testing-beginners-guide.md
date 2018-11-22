+++
title = "JavaScript Testing Beginner's Guide - Liang Yuxian Eugene"
date = 2015-09-10

category = "review"

[taxonomies]
tags = ["books", "en-au", "liang yuxian eugene"]
+++
{{ stars(stars=1) }}

Let me start this by saying that I really liked the structure of the book. For each chapter, there is an explanation of what will be covered; a "call for action" which shows the code and then describes, step by step, what is going on; a further explanation on when running said code; and, finally, some pointers on where to go forward.

That being said, this is a mess of a book. The kindle version is completely mangled on the source code. Indentation is completely wrong, which makes the code hard to read; the code is full of stupid mistakes (like having an object and trying to get it again with `getElementById(element.id)`); and, generally, it's pure bad code (like raising an exception inside a try/catch just to catch it afterwards). Not only that, but the book goes incredible lengths to explain JavaScript, what are unit tests and such and, just in the last chapter, it finally explains JavaScript Testing.

That wouldn't be so bad if it was a recent book. But it's a book from 2010, with no further editions, and a lot has changed in the JavaScript landscape in those last 5 years. New frameworks appeared, new tools are here, JavaScript is not client side only anymore... The list goes on and on. Heck, the author goes lengths to explain how to test in IE because it's the most used browser at the time!

Honestly, stay away from this book. Get a book about JavaScript. Get a book about testing. Pick one of the JavaScript testing frameworks around (I know at least 5), read its documentation and you'll be in a better place than reading this.