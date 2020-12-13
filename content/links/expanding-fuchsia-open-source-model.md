+++
title = "Commented link: Expanding Fuchsia's open source model"
date = 2020-12-13

[taxonomies]
tags = ["links", "google", "fuchsia", "open source"]
+++

Google recently announced they they are [changing the open source
model](https://opensource.googleblog.com/2020/12/expanding-fuchsias-open-source-model.html)
of their new open source OS called Fuchsia. But there are so many red flags one
has to wonder what the announcement actually is.

<!-- more -->

For example: "We have been developing Fuchsia in the open, in our git
repository for the last four years." Thing is, nobody had access to the
repository for *writing*, only Google. And, although it was "open" you couldn't
suggest changes or anything, even if you were following the development since
its inception. The model is as "open" as Android is, where only way to
contribute to the mainline code is being at Google; you can clone the Android
code as much as you can clone Fuchsia code, but good luck trying to make it run
without voiding your device warranty.

"Starting today, we are expanding Fuchsia's open source model to make it easier
for the public to engage with the project." This point is important for the
next points, but you have to ask yourself: What is actually changing in the
model? Are they changing the license, to allow people to continuous contribute
as an open source project? Are they opening the lines for accepting external
pull requests? No, they are just creating a maillist and writing down how one
can get permission to submit patches or become a committer. How open is a
project that you need to have badge to be able to be part of the project?

"In addition, we are also publishing a technical roadmap for Fuchsia to provide
better insights for project direction and priorities." Remember the first point
about making easier to the public to contribute? Well, how can it be a
contribution from the public if the direction is already set? What if the
public decides that the direction should be another one? Either is a waste of
time of the current developers or the "easier to contribute" is simply for free
labor and not for building an open source project, in the end.

"Fuchsia is an open source project that is inclusive by design, from the
architecture of the platform itself, to the open source community that we’re
building." This point was raised from another user on Mastodon (hello
[Berkes](https://bitcoinhackers.org/@berkes)): One does not "build" an open
source community; you make an inclusive, open to everyone project, where people
can contribute to code, documentation, ideas, improvements and even direction
and the community will build itself -- Rust is a great example of that (and I'm
bringing this for later).

But even with all that, let's take a step back: Why would Google change the
"model" of such OS? Couldn't they develop it themselves, in the close? Sure
they could. The fact that they are "open sourcing" it probably means the
project lost importance inside Google and nobody actually cares to continue
development of it. The roadmap probably is just the original authors
"wishlist" for the OS and nothing more.

Also, there is the question of "Why Fuchsia?"; why would Google invest in
producing another OS when Linux seems to fit most of their needs (after all, it
fits their ChromeOS and Android systems)? While being developed with Rust, a
language the provides memory protection and should, in theory, provide a better
experience for users, it doesn't mean that other languages can't provide the
same protections -- Rust just means the compiler will do a better job at
pointing out problems than other languages. But when you have an operating
system like Linux, which is reviewed by thousands of developers around the
world, highly modular and with groups focused on different subsystems, the
protection comes from the *community*. Google could, pretty much, rewrite some
critical subsystems in Rust and get over it, but they decided to go with a
completely different OS. And the rumors say that it was simply 'cause Linux is
licensed under GPL, a license the allows anyone to contribute -- with later
versions of the license even requesting companies to provide the encryption
keys for devices that require it -- and that Google simply abhors.

So, an OS created (probably) out of petty spite for rules that actually *build*
open source communities now is trying to create an open source community. If
this isn't poetic justice, I don't know what it is.

