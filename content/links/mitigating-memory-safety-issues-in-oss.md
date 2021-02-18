+++
title = "Commented Link:  Mitigating Memory Safety Issues in Open Source Software"
date = 2021-02-18

[taxonomies]
tags = ["links", "google", "safety", "rust"]
+++

Initially announced on HackerNews as "Google to Pay Developers to Port Their Code
to Rust" [on this
post](https://security.googleblog.com/2021/02/mitigating-memory-safety-issues-in-open.html),
what is actually going on is not quite what it seems.

And it seems this time HackerNews comments [actually got what it actually
means](https://news.ycombinator.com/item?id=26179032).

<!-- more -->

But let me surmise this.

First of all, the funding is not going to open source developers so they can
secure their applications, or look for alternatives that seem more
secure. Google will fund another company -- ISRG -- for them to write new
versions of some code. So, even if the idea is pretty good, it won't translate
into offering help to the authors so they could still work on their project; the
money will all go to someone else, to provide patches.

This "someone will provide patches" always remind me of a talk by Brett Cannon
on a DjangoCon. "You see this little puppy, so cute, but what I see is 10 years
of walks, giving food and picking its crap."[^1] So, while ISRG will provide
patches for improving open source projects using memory safe languages, there is
no word about "and continue to make things work". Sure it is nice to have a
safety patch in some other language landing in your project, but who will take
care of it in the next version? And the next one? ISRG or the original author --
whose, again, got absolutely nothing in the first place?

Second, there is this line:

> The ISRG's approach of working directly with maintainers to support rewriting
> tools and libraries incrementally falls directly in line with our perspective
> here at Google.

What feels strange about it is that we know, for a long time, that Google does
not work for the common good; it works for itself (and that's ok for the
company). But what if the secure way of some project does not fall in the exact
"perspective" of Google? Will they fork it? Accept that their perspective isn't
the right way?

For example, recently Cryptography replaced a core element to use Rust -- which
totally makes sense in a secure project. The problem is that some people, using
some non-mainstream architectures, [saw their builds
failing](https://github.com/pyca/cryptography/issues/5771). Now, again, it makes
sense for something that enforces security to use a memory safe language, but
what that was the proposed solution by ISRG -- which, again, aligns with the
perspective of Google -- and the author decided that portability is more
important?

In the end, it feels like Goog is trying another way to take hold on open source
projects for their own purposes and not actually caring about helping end users
to have a better internet experience.

---

[^1]: Paraphrased, I can't really recall the actual quote.
