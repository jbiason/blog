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
