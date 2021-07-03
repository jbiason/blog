+++
title = "Using `alternatives`"
date = 2021-06-21

[taxonomies]
tags = ["linux", "cli", "vim", "alternatives"]
+++

`alternatives` allows one to select a different executable for a normal command
line program, but how does it work?

<!-- more -->

I'll give an example: I enjoy using NeoVim instead of Vim for different
reasons. But there is a nag that I keep hitting: NeoVim executable is called
`nvim` instead of the `vim` for... Vim.

I could change two different environment variables, `VISUAL` and `EDITOR` to
`nvim`, so any application that wants to open an external editor would call
NeoVim instead. But, unfortunately, my muscle memory doesn't work with
environment variables, so either I keep correcting myself to type `nvim`
instead of `vim` or I find a way to, when I call `vim`, it should actually call
`nvim`.

The initial solution is to use aliases, so `alias vim nvim` (in Fish) would
make `vim` actually run `nvim`... except when I use `sudo`, which doesn't
expand the alias before its call. The actual solution would be something
global, that takes care of this.

And that's what `alternatives` do.

In my case, what I actually need to do is run the follow command:

```
sudo alternatives --install /usr/bin/nvim vim /usr/bin/vim 1
```

What does it do:

* Say I want to use `/usr/bin/nvim`
* ... which I'll call "vim" (which is the name `alternatives` uses in its
  configuration)
* ... making a symlink into `/usr/bin/vim`
* ... with priority 1.
