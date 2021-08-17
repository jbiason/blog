+++
title = "Three Weeks With Silverblue"
date = 2021-07-23

[taxonomies]
tags = ["fedora", "silverblue", "immutable", "docker"]
+++

A few weeks ago (four weeks ago, to be exact, based on this post date), my
Fedora Workstation crashed hard, in some freak accident that, I believe, killed
my `/boot` partition. At first I reinstalled Workstation, but then decided to
give a change to [Silverblue](https://silverblue.fedoraproject.org/).

<!-- more -->

## What's a Silverblue?

Silverblue is a distribution that is pretty close to what containers do: The
base system sits on a immutable file system, giving the impression that the
system is just a kernel and Docker (it uses Podman actually, but it is
basically the same thing, when we look at the functionality) and a volume with
all the applications.

## How Does It Feel?

Honestly, it doesn't have any difference from the Workstation, in a day-to-day
perspective. I still use the same editors, the same browser, the same terminal
and, with a few caveats, everything feels exactly the same.

## What's Different, though?

### Install

To install packages, you need to use `rpm-ostree` instead of `dnf`. The weird
part is that by installing a package, it doesn't make things available
immediately -- because it generates a new layer on the top of the current
volume and you're still using the current (not yet updated) volume. If you were
using a container system, you would shutdown your container and restart it, so
the new layer would assume. Since the whole system is (basically) a container,
you need to restart the whole thing... Which isn't something that weird if
you use Workstation, 'cause that's the way Workstation works, most of the time
(which you can completely ignore on Workstation but not here).

Once a package is installed with `rpm-ostree install <package>`, you can
restart the whole thing with `systemctl reboot` (yes, no `sudo` required). But
once it reboots, there is no need to run the scriptlets in the packages: Reboot
loads the new volume and things appear. You can also run multiple installs to
buy just a single layer on top of the original.

(So far, I haven't seen anything like "this volume is getting too many layers
and now it is taking forever; but, then again, three weeks only.)

### Firefox

Firefox bundled in the base file system (the immutable part) comes without any
codecs, so basically no video on the internet works. You can install the
Flatpak version -- which is also something you can use for most things -- but
then you end with two Firefox installs.

And before Firefox is part of the base, immutable file system, you can uninstall
it. But you can override the install by putting a new layer which removes
Firefox from the base install. For that, you use

```
rpm-ostree override remove firefox
```

... instead of the expected...

```
rpm-ostree uninstall firefox
```

### Extra Repositories

Silverblue doesn't allow adding extra repositories the way you normally do with
Workstation -- creating a simple file in `/etc/yum.repos.d/`. Now you need to
use `ostree remote add <name> <url>` -- Yup, that's pretty close the way you
add a Git remote or something.

After that, installing packages takes the normal `rpm-ostree install`.

### Speed

No, sorry. I didn't notice any speed improvements, although it feels like it
boots a bit faster than Workstation.

Kinda related, since I'm running on a laptop, it seems the battery life
improved under Silverblue, for some reason. I may take a leap here and say that
maybe the base image is smaller -- since it is immutable and you can uninstall,
I feel they put the bare minimum to boot a desktop system instead of everything
that may be useful.

### Podman

Not that you can't use Docker on Silverblue, but Silverblue uses Podman by
default for almost everything -- there is even a tool to create your own small
containers for running things in isolation, called `toolbox`. It takes a bit of
time to understand how it works, specially since, so far, I couldn't find a
group I can add my user to it so I can run commands without `sudo`, but
whatever.

Besides the `sudo` thing, you may want to enable the `podman.socket` service,
which makes Podman create a socket the same way Docker does, so you can use
`docker-compose` like you were using Docker.

Honestly, I feel I should take a bit more time to properly understand Podman
instead of using it as Docker, but since I had a docker-compose file already and
I needed to quickly jump back into work, I postponed this learning so far.

## Conclusion

So far, I'm pretty happy with Silverblue as a main drive. It works, it seems --
emphasis on "seems" -- to be more lightweight than Workstation and I still have
everything I need.
