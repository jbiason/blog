+++
title = "Write Great Code: Volume I: Understanding the Machine - Randall Hyde"
date = 2016-10-05

category = "review"

[taxonomies]
tags = ["books", "en-au", "randall hyde"]
+++
{{ stars(stars=1) }}

"Great code" is machine dependent and written in assembly. Or, at least, that's what this book makes you believe till the very last chapter, when it starts backtracking about writing code directly into CPU code.

Now, don't get me wrong, it's not a terrible book -- it's a damn complete book about *computer architecture*, even being so out-of-date that there is no word about SSDs (when talking about storage), no mention about MP3s (when discussing about audio hardware), the top CPU discussed is Pentium, there is no word about UTF-8 (and mentions ASCII is used all around) and recommending search things on AltaVista. 

The problem is discussing all this when the topic is "great code": Great code is not machine dependent; great code is not highly optimized code that runs extremely fast and uses very little memory; there are trade offs that you have to take in account when coding: Sure, you don't write something that uses all the available memory, but you write in a language that allows you to easily extend the code later and which your code reads exactly what you meant it to say. That's great code, not code that uses some multimedia extensions that is available since a very specific generation of CPUs.

The book also goes into great lengths to explain stuff that is hardly useful. For example, there is a whole implementation of the floating point standard (IEEE 754), which is not optimized -- so, no great code -- and that's absolutely unnecessary, since this is done directly into the CPU (and, if it isn't, you have libraries ready for that).

It could be that the "Great Code" will come in the later volumes, but ignoring what *is* great code (I mean, *real* great code) and just building a base for later is plainly greedy.