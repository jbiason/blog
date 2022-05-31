+++
title = "The Types of OOP"
date = 2022-05-31
draft = true

[taxonomies]
tags = ["programming", "oo"]
+++

I'm seeing that a large group of newcomers don't get the idea behind object
oriented programming. And I think this misunderstanding is basically the way
this is explained.

<!-- more -->

If we take a page from the classical "first look" at OOP, we would see something
like

```python
class Animal:
	def say(self):
		print("Don't know what to say")

class Dog(Animal):
	def say(self):
		print("Woof!")
```

The example usually creates a base class, with a method (function), extends the
base class in a child class and overrides the method. And that's basically it.

But, in real life, things are not quite like that.

Ok ok, there are examples in real life that are basically that, but I don't
think we *start* with that, we *use* that.

So, what do I mean by "Types of OOP"?

## The Grouping

One of the types of OOP we usually do is "grouping". What do I mean by that is
that we usually have a group of values that are related and should be worked
together.

For example, in stock markets, we have the concept of a "candle": The candle
summazes what happened in a period of time -- be it one day, one hour, one
minute of 10 milliseconds. In that space of time, we capture the first value
seen, the last value, the highest value and the lowest value. We could, for
example, use a series of arrays for that, like

```python
first_values = [10, 20, 14, 21, 17]
last_values  = [20, 14, 21, 17, 12]
high_values  = [30, 20, 21, 21, 18]
low_values   = [9 , 14, 13, 17, 12]
```

Here, each "column" represents one entry in the period time; if we are doing it
per hour, that means in the first collected hour we have the values in the first
column, one hour later we have the values in the second column and so on. Thing
is, those values are related, and we could basically group them together.

```python
class Candle:
	def __init__(self, first, last, high, low):
		self.first = first
		self.last = last
		self.high = high
		self.low = low

entries = [
	Candle(10, 20, 30, 9),
	Candle(20, 14, 20, 14),
	Candle(14, 21, 21, 13),
	Candle(21, 17, 21, 17),
	Candle(17, 12, 18, 21),
]
```

This is basically the same thing, but now instead of having multiple arrays, we
have just one that keeps all related information together. The concept of
grouping information like that is not something new and even C had a `struct` to
keep related values together. But when we use objects, we can also add
"behaviours" to our data, and we could ask if the candle is going up or down, if
that would help us in our requirements.

A simple example could be the name of a person

```
class Name:
	def __init__(self, first_name, last_name):
		self.first_name = first_name
		self.last_name = last_name

	def full_name(self):
		return "{} {}".format(self.first_name, self.last_name)
```

For a person, we have related information like the first name and last name. But
if we want to put their names in an envelope, we need to print both names
together, so we added a "behaviour" (method) to produce that for us.

Quite simple.

## The Façade

Façade is, actually, a design pattern: You want to hide what the code does
behind the curtain, so changing the underlying structure would not affect the
code.

For example, let's take our Name example before. Let's say we want to save
it. We could do

```python
class Name:
	def __init__(self, first_name, last_name):
		self.first_name = first_name
		self.last_name = last_name

	def full_name(self):
		return "{} {}".format(self.first_name, self.last_name)

	def save(self):
		# saving to disk
		with open(self.full_name(), 'w') as target:
			target.write("first_name: {}\n".format(self.first_name))
			target.write("last_name: {}\n".format(self.last_name))
```

All good, we are just keeping our names saved on disk, with the filename being
the full name and, inside, we keep the first and last names. But let's say our
disk is full, and someone thought a good replacement would be to store all those
files in S3. Later, someone came with the great idea of saving those in a
database. And, much later, we realized we can speed things up by saving the
content in a Redis store for faster retrieval. In all those changes, we exposed
how things are saved inside our class, which may be simple enough, but imagine
you have hundreds of things to be stored, with their classes, and now you have
to go there and replace every one of those classes for every time we thought we
found a better way to store it.

In this case, we could've come with a `Storage` class, which would hide the way
we are storing (and probably retrieving, although I haven't shown in this
example) from the classes, so our `save()` method could be

```python
def save(self, storage):
	# convert to some format `Storage` knows, or just break the content of the
	# class down in some dictionary, for example.
	storage.save(self)
```

The `Storage` is just a façade to do the way we are actually saving the
data. The class doesn't know how its contents are stored, but it also doesn't
have to worry about it. `Storage` may even contain some related information to
save the content properly, but it's real purpose is just to hide whatever is
under it so the rest of the system doesn't have to worry about it.

{% note() %}
For languages that have support for it may use "interfaces" or "traits" to
ensure that whatever the Storage is doing, it has the same appearance
everywhere.
{% end %}

## The Framework
