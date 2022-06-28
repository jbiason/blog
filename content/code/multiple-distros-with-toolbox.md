+++
title = "Multiple Distros with Toolbx"
date = 2022-06-24

[taxonomies]
tags = ["linux", "podman", "containers", "toolbox", "toolbx"]
+++

When I switched from Fedora to
[Silverblue](https://silverblue.fedoraproject.org/), I got used to use
`toolbox` to check for packages and whatnot. But when I needed to test a
project in multiple distributions, I decided it was time to explore Toolbx a
little deeper.

<!-- more -->

## What's it?

First of what, Toolbx (or `toolbox`) is a tool created to make it easier to
play with [Podman](https://podman.io/) images. You know when you use Docker to
create an image that you can work along your normal install, so you can break
as much as you want without damaging the external system, and still have access
to your data? Well, that's Toolbx.

By default, on Silverblue, there is basically just one image: fedora-toolbox.
It is the default Fedora Workstation install, but you can pick any version you
want. You can do 

```shell
toolbox create
```

... to create an environment with a Fedora install in the same version of the
current Silverblue install and then 

```shell
toolbox enter
```

... to get into the image. So now you can install whatever you want without
burdening your system.

`toolbox create` have an option to select an image, and that's when I got the
idea of using it to have different distributions in my system, each in their
own container, with their own tools, so I could break them as much as I wanted
without breaking my base system.

## Getting Other Images

To use a different image for your Toolbx, you can simply download them with
`podman pull` and an image name. Unfortunately, not every image is ready to be
used, 'cause there are some requirements that Toolbx needs to interact with the
image.

## Requirements

First, you'll need `capsh` to be available inside the image. The name of the
package depends on the distribuition, but in the images I tried, none had it
installed by default.

Second, you'll probably need "sudo" so you can install packages on the
container and, again, it doesn't seeem to be part of the base images.

Third, because "sudo" is not available, there will be no `sudoers` file,
requiring that you create one.

Fourth, the sudo group can change from distribuition to distribution; some call
it "sudo", others call it "wheel". But the group must exist.

And fifth, Toolbx will mess with the entrypoint of the container, so you must
be sure that there is no command in the entrypoint. 

{% note() %}
There is a line that basically removes the entrypoint no matter what the base
image uses, and I added it in all examples, just to be in the safe side.
{% end %}

## An OpenSuse Image

Let me start with an OpenSuse image: Suse doesn't have a sudo group, doesn't
come with `capsh` installed not `sudo`. So I had to create my own image.
This can be done with a `Containerfile` file or, if you prefer, you can create
it with the name `Dockerfile`, which Podman is pretty chill in using without
issues.

So I have this `Containerfile`:

```dockerfile
FROM opensuse/leap:15.1

LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true"

RUN groupadd wheel
RUN zypper install -y libcap-progs sudo
COPY sudoers /etc/sudoers

ENTRYPOINT []
```

The labels are just to inform Toolbx that the image is a Toolbx image. Because
there is no sudo group, I had to need to create a `wheel` group; libcap-progs
is the source for the `capsh` app; a `sudoers` file that was added to allow
using `sudo` without a password.

{% note() %}
If you're curious, the whole `sudoers` I use have just one line:

```sudo
%wheel        ALL=(ALL)       NOPASSWD: ALL
```
{% end %}

With that in place, the image can be created with `podman create . -t suse51`,
where "suse51" will be the image name.

Image created, the Toolbx environment can created with `toolbox create -i
<hash> suse`; the `<hash>` part is the image ID and `suse` is the toolbox name.
Dunno why, but sometimes referring to the image by its name (the one used in
the `build` part) doesn't seem to work, but the hash always do.

And then, to use the environment, simply do `toolbox enter suse`.

Other distributions I build images:

## Ubuntu Image

Similar to OpenSuse, Ubuntu default image also doesn't come with `capsh` and
`sudo`, but this can fixed with this `Containerfile`:

```dockerfile
FROM ubuntu:18.04

LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true"

RUN apt update && apt upgrade -y
RUN apt install -y libcap2-bin sudo
COPY sudoers /etc/sudoers

ENTRYPOINT []
```

Also, the `sudo` group is "sudo", so the `sudoers` file had to reflect this.

## Centos 7 Image

Centos 7 comes with `capsh`, but not `sudo`. So another custom image needs to
be used:

```dockerfile
FROM centos:7.3.1611

LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true"

RUN yum -y update yum-skip-broken
RUN yum install -y sudo
COPY sudoers /etc/sudoers

ENTRYPOINT []
```

`sudo` group is "wheel", so `sudoers` had to be adjusted.

## Conclusion

That's basically it. I had to mess a bit with the images, check the logs trying
to create the environment with `toolbox create -i <image> <somename>
--log-level DEBUG` to see any complains, figure out how to fix those but once
the first image (the Suse one) was created, figuring out what was needed was
pretty easy.

And now I don't need to do distro hopping to figure out if our project work on
them.
