+++
title = "Linux Shell Scripting Cookbook - Shantanu Tushar"
date = 2016-01-13

category = "review"

[taxonomies]
tags = ["books", "en-au", "shantanu tushar"]
+++
{{ stars(stars=2) }}

I don't know why, but when I saw the title, I expected to be a book only about bash. Bash is a shell for *nix based systems and, as VIM, is one of the apps you can use for 10 years and, after reading something about it, you find something completely new.

Thing is, this is not just about bash. This book is about tools in the GNU system that can help write shell scripts. And even if you're pissed about Stallman asking to call the system GNU/Linux, this *is* about GNU tools: tr, expect, find... All GNU tools.

So "GNU Shell Scripting Cookbook" would be a more appropriate title.

About the content itself... It's mostly a miss than a hit. Some things are some wrong it hurts (Git does *not* add a `.git` directory inside every directory) and some are so utterly stupid to the point of being dangerous (you don't need root to chown a file!). Some points are so strange, they seem like the authors used a GNU/Linux for only two months and decided to write a book about it.

The book have two authors and it shows. Lots of repeated information, some things not building on things already said (really guys? Not matching pipe with stdin/stdout redirection?) will give you the impression that they never spoke about the book or had a roadmap for it. And there is a shitton of "as follows" (seriously, you'll get sick of reading "as follows" over the book). It says in the cover that, besides the two authors, there were at least 5 reviewers. But it seems none of them actually read the book -- and I'm not talking about easy things to find in a 1 minute Google search (like the git thing), but things like "this 'as follows' is getting through my nerves, you're using it every-fucking-where".

The content gets better in the end, when it gets over the "teaching phase", but you'll still have the bad taste of things wrong from the previous chapters. 

So, basically, the book tries to cater  to two different audiences -- the beginner and the master -- and doesn't seem to be able to provide a good content for any. 