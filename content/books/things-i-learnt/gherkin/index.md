+++
title = "Things I Learnt The Hard Way - Gherkin Is Your Friend to Understand Expectations"
date = 2019-06-19

[taxonomies]
tags = ["en-au", "book", "things i learnt", "gherkin", "expectations"]
+++

Gherkin is file format for writing behaviour tests. But it can also give you
some insights on what you should do.

<!-- more -->

Alright, let's talk a bit about Gherkin:

[Gherkin](https://en.wikipedia.org/wiki/Cucumber_(software)#Gherkin_language)
is a file format created for [Cucumber](https://en.wikipedia.org/wiki/Cucumber_(software)),
which describes scenarios, what's in them, what actions the user/system will
do and what's expected after those actions, in a very high level, so people
without programming experience can describe what's expected from the system.

Although Gherkin was born with Cucumber, it is now supported by a bunch of
programming languages, through external libraries.

A typical Gherkin file may look something like this:

* **Given that** _initial system environment_
* **When** _action performed by the user or some external system_
* **Then** _expected system environment_

Or, in a more concrete example:

* **Given that** The system is retrieving all tweets favourited by the user
* **When** It finds a tweet with an attachment
* **Then** The attachment should be saved along the tweet text

Pretty simple, right?

Now, why I'm mentioning this?

Sometimes, specs are not the most clear source of information about what it is
expected from the system. If you're confused about what you should write,
asking the person responsible for the request to write something like Gherkin
may give you some better insights about it.

Obviously, it won't be complete. People tend to forget the error situations --
people entering just numbers on names, letter in age fields, tweets with no
text and just attachments -- but at least with a Gherkin description of the
system, you can get a better picture of the whole.

Also, you may not like to write specs. That's alright, you can replace them
with Gherkin anyway.

{{ chapters(prev_chapter_link="/books/things-i-learnt/steps-as-comments", prev_chapter_title="Write Steps as Comments", next_chapter_link="/books/things-i-learnt/patterns-not-solutions", next_chapter_title="Design Patters Are Used to Name Solution, Not Find Them") }}
