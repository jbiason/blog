+++
title = "I Redid My NeoVim Configuration"
date = 2022-01-19

[taxonomies]
tags = ["vim", "neovim", "nvim", "config", "lsp", "treesitter"]
+++

For some obscure reason, my NeoVim install decided it didn't want to
display LSP warnings anymore. So I redid the whole configuration.

<!-- more -->

Believe me, I didn't do 'cause "OMG, so broken". I guess I could have tracked
the problem to the way
[LanguageClient](https://github.com/autozimu/LanguageClient-neovim) was
installed -- it could be even out-of-date, 'cause I updated to NeoVim 0.6
recently -- but I also wanted to install the TreeSitter support, for better
highlight. Those two factors were enough to me to try a different
configuration, so I decided to do the full thing and rewrite the whole
configuration file, using the Lua format.

I started with the [post of Takuya
Matsuyama](https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887),
just as reference -- I'm not a user of a package manager (and
there may lie the problem with some outdated plugin) and I really prefer to
work with submodules and whatnot -- a way that is pretty close to what
[Pathogen](https://github.com/tpope/vim-pathogen) does.

As I wanted to move some things from my old configuration to the new, I had to
search on how to "translate" those. That's where I found [a post by Heiker
Curiel](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/),
which lists old configuration options and how they appear in the Lua config.

The result is that I have a brand sparkling NeoVim install, with all the bells
and wristles:

![](vim6.png "Yes, I do like to write long documentation strings")

The whole configuration file is [in my personal Git
repo](https://git.juliobiason.me/dotfiles.git/tree/nvim).

### What was left out?

When migrating, I few things I did not add in this new configuration:

- Fuzzy find: Previously I was using [Skim](https://github.com/lotabout/skim)
  for opening files with fuzzy find (e.g., type a few letters, see a list of
  the files with those letters). The Vim plugin for it was a bit flaky
  (sometimes it would completely ignore the typed input, which I think it meant
  it crashed somehow). But, 'cause I used only when bored, I decided that I
  won't use a fuzzy find; my favourite way of finding files is using the `-`
  shortcut, which I set to open `:Ex`.
- Snippets: [UltiSnips](https://github.com/sirver/UltiSnips) was not working
  before, so I decided not to try it again. I'll probably look at some other
  option in the future.
- Per FileType configuration: Previously I had a bunch of autocommands to set
  specific configuration for each file type (e.g., Python files should always
  use spaces instead of tabs, but HTML should use tabs instead of spaces). I
  left it out mostly 'cause there is no Lua support for such commands yet, as
  far as I know (you can run VimScript commands still, but I'm being a bit
  retentive about mixing those).
- Auto-trim lines: My previous configuration used an autocommand for running a
  regular expression that would remove all tailing spaces in the lines. Because
  I use Rust mostly these days and the LSP configuration can run the
  autoformatter (`rustfmt`, in this case) and this already remove tailing
  spaces, I decided to leave this option out for now.
