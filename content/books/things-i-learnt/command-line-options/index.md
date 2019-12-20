+++
title = "Things I Learnt The Hard Way - Command Line Options Are Weird, But Helpful"
date = 2019-07-15

[taxonomies]
tags = ["books", "things i learnt", "configuration", "command line options", "cli"]
+++

In this day and age, when everything has a graphical interface, does it still
makes sense to add command line options to your application? In fact, it does.

<!-- more -->

When I mentioned the configuration file, you may have thought about using
adding a default path for it and using the same file over and over.

Well, that's not wrong, but what if you want to use a different configuration?
Would you keep moving the original configuration file to another place, moving
your configuration back and keep this back and forth? Keep both versions and
just use a [symbolic link](https://en.wikipedia.org/wiki/Symbolic_link) with
the configuration filename pointing to the one you want?

Why not add a command line option in which the user can select which
configuration file should be loaded?

This would make their life _and yours_ easy.

Also, be aware that, today, there may be libraries to handle command line in
every language, which will help you build a good command line interface, along
with standardizing it to have the same interface as other applications.

{{ chapters(prev_chapter_link="/books/things-i-learnt/config-file", prev_chapter_title="The Config File Is Friend", next_chapter_link="/books/things-i-learnt/application-composition", next_chapter_title="Not Just Function Composition, But Application Composition") }}
