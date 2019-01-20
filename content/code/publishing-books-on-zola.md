+++
title = "Publishing Books on Zola"
date = 2019-01-20
category = "thoughts"

[taxonomies]
tags = ["en-au", "books", "zola"]
+++

A long time ago I wrote a couple of posts on a WordPress, then moved them to
GitBook. Unfortunately, GitBook changed its layout to something a bit more
confusing and now I'm bringing them back to this blog, which runs Zola.

<!-- more -->

Zola is a blog system; a static blog generator. It wasn't projected to be a
publishing tool, but because it has support for publishing stuff without
appearing in the main page, specialized templates for each page and
shortcodes, I managed to come with a clever solution.

But let's see how I did:

## The Theme

The first problem is tied to the current Zola themes: some of them lack
support for tags, some for sections and some to both. For [After
Dark](https://github.com/getzola/after-dark/), I
had to add support for both, but renamed it to
[Nighttime](https://github.com/jbiason/nighttime). This allows
putting the books in their own sections, which helps the general organization
of the content.

## Hiding Book Posts From Main Site

Each Zola section needs a `_index.md` file with the meta information for the
section; for example, it's title.

To make posts in a section not appear in the main site (you know, the site
index), you need to set a property in its meta information: `transparent`.
When a section is transparent, posts inside the section will not appear in the
main index and, thus, will be contained only on the section.

... unless you want to make some "episodic" chapters and allow them to appear
in the main site. That's up for you.

## Post Order in the Section

By default, posts in sections are ordered from the most recent to the oldest,
based on their published date. You can change this by changing the `sort_by`
property in the section to `weight`, which will show posts by weight, from the
lightest to the heaviest.

Why would you want to change the order of posts in the section? 'Cause the
section content works pretty damn fine as a general index for your book, which
each post as a chapter.

All fine and dandy, but the fact is that posts titles, with their dates and
summaries, is not a very good index. But Zola has a workaround for this: Each
section data can also have a `template` option, which allows using a different
template for that section alone. In my case, I created a template on
"Nighttime" that have all the meta information but not the posts in it, called
`section-contentless.html`. 

But what is good about a section/book with a title and an empty index? That's
another thing Zola can do: If you add any content in the `_index.md`, it will
be rendered normally. So you can write the index yourself (which is not
optimal, but it works).

As a side note, you can also create a template which shows only the post
title, no summary or date, and use the weight solution.

## Navigation

Although you can now display the book with its chapters, it still is a bit
hard for readers to do a nice, continuous reading if they need to go back to
the index after reading a chapter to get to the next.

For that, you can use a shortcode to add the navigation at the bottom of each
post. Something like this:

```jinja
<div>
	{% if prev_chapter_link %}
		<div style="float:left">
			&lt;&lt; <a href="{{ prev_chapter_link }}">{{ prev_chapter_title }}</a>
		</div>
	{% endif %}

	&nbsp;

	{% if next_chapter_link %}
		<div style="float:right">
			<a href="{{ next_chapter_link }}">{{ next_chapter_title }}</a> &gt;&gt;
		</div>
	{% endif %}
</div>
```

And then, adding in the end of each post a 
`{ { nav(prev_chapter_link="<link>", prev_chapter_title="Title", next_chapter_link="<link>", next_chapter_title="Title") }}` 
and Zola will add the HTML (with the parameters) at the bottom of each post,
making navigation easier.

And that's basically it!
