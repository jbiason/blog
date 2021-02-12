+++
title = " Learn you some Erlang for great good! - Fred Hebert"
date = 2020-10-25
updated = 2021-02-12

[taxonomies]
tags = ["books", "reviews", "it", "erlang", "fred hebert", "stars:4",
"books:2020", "published:2012"]
+++

[GoodReads Summary](https://www.goodreads.com/book/show/6718693-learn-you-some-erlang-for-great-good):
(No Summary)

<!-- more -->

{{ stars(stars=4) }}

Another Erlang book for my collection.

This one takes its time to explain every point. So if you like to go fast and
furious, that's not it. Also, because I read some other books (ok, "book")
about Erlang, some topics felt a little bit boring, 'cause I did get the point
already.

Also, it seems this books also suffer from the "let me use the shell to explain
this point". It's not that bad when you want to show a point in the very
beginning and then just drop it ('cause, you know, you won't use the shell as
part of your application -- you may use as a helper to figure out when things
go haywire, but not as a default tool) but not when you're near the middle of
the book explaining some important topic, like supervisors.

But, at the same time, some topics that the other books (ok, "book") completely
ignored, like "how do you build, package and deploy an Erlang application".

But yeah, the "using shell for important stuff" *really* annoyed me.

## Highlights

> The correct ordering of each element in a comparison is the following:
> number < atom < reference < fun < port < pid < tuple < list < bit string.

>  A tuple that contains an atom with one element following it is called a
>  tagged tuple.

*Note*: Example: `(tag, value, value)`, `(other_tag, value, value)`.

> port Erlang to the JVM, giving the Erjang.

>  To compile to native code, you need to use the hipe module and call it the
>  following way: hipe:c(Module,OptionsList). You could also use
>  c(Module,[native]) 

>  There are also a few predefined macros, such as the following: 
>  - ?MODULE, which is replaced by the current module name as an atom 
>  - ?FILE, which is replaced by the filename as a string 
>  - ?LINE, which returns the line number of wherever the macro is placed 

>  -ifdef(DEBUGMODE).<br>
>  -define(DEBUG(S), io:format("dbg: "++S)).<br>
>  -else.<br>
>  -define(DEBUG(S), ok).<br>
>  -endif.

*Note*: This is how you define a function that exists only if the atom is
defined.

>  right_age(X) when X >= 16, X =< 104 -> true;
>  right_age(_) -> false. 

*Note*: The function for `right_age` returns true only when the guardian
matches. Basically, we don't need `if`s in this kind of function.

>  wrong_age(X) when X < 16; X > 104 -> true;<br>
>  wrong_age(_) -> false 

*Note*: Same thing.

>  1> {ok, Binary} = file:read_file("road.txt").<br>
>  {ok,<<"50\r\n10\r\n30\r\n5\r\n90\r\n20\r\n40\r\n2\r\n25\r\n10\r\n8\r\n0\r\n">>} <br>
>  2> S = string:tokens(binary_to_list(Binary), "\r\n\t ").<br>
>  ["50","10","30","5","90","20","40","2","25","10","8","0"] 

*Note*: the `<<>>` format denotes binary content (like bytes in Python, maybe?).

>  main([FileName]) -> <br>
>    {ok, Bin} = file:read_file(FileName),<br>
>    Map = parse_map(Bin),<br>
>    io:format("˜p˜n",[optimal_path(Map)]),<br>
>    erlang:halt().
>
>  The main function now has an arity of 1, needed to receive parameters from
>  the command line. We’ve also added the function erlang:halt/0, which will
>  shut down the Erlang VM after being called 

>  erlc road.erl <br>
>  $ erl -noshell -run road main road.txt 

*Note*: `erlc`, the Erlang Compiler. Still needs `erl` to run the thing,
though.

>  The Erlang escript command provides a simple way to run Erlang programs
>  without starting the erl application directly.

>  % This is a .hrl (header) file.<br>
>  -record(included, {some_field, some_default = "yeah!", unimaginative_name}).

*Note*: Records are just tuples with added syntactic sugar.

>  Because a single list doesn't allow efficiently adding and removing elements
>  from both ends at once (it's only fast to add and remove the head), the idea
>  behind the queue module is that if you have two lists, then you can use one
>  to add elements and one to remove elements. One of the lists then behaves as
>  one end of the queue, where you push values, and the other list acts as the
>  other end, where you pop them. When the latter is empty, you take the former
>  and reverse it 

>  Erlang directory structure, which looks like this:
>  - ebin/ 
>  - include/ 
>  - priv/ 
>  - src/ 

>  Open a file named Emakefile.

*Note*: `Emakefile`s make file file.

>  {'src/*', [debug_info, {i, "src"}, {i, "include"}, {outdir, "ebin"}]}. 

*Note*: format of said Emakefile.

>  erl -make 

*Note*: How to build a project using the Emakefile.

>  Start a shell to be a TCP server: 

*Note*: This is the kind of stuff that drove me crazy: Why would I turn my
shell into a TCP server? It makes no sense! Sure, it is simpler, but who the
heck would do that in a normal way?

>  Promises and futures are a bit like remote procedure calls 

*Note*: WHAAAATTTTT?!?!?
