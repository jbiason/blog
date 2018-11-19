+++
title = "Mocking A Mock"
date = 2016-07-21
category = "code"

[taxonomies]
tags = ["python", "mock", "mongodb", "find", "count", "en-au"]
+++

Mocks are an important part of testing, but learn how to properly mock stuff.

<!-- more -->

A few weeks ago we had a test failing. Now, tests failing is not something
worth a blog post, but the solution -- and the reason it was failing -- is.

A few background information first: The test is part of our Django project;
this project stores part of the information on MongoDB, because the data is
schemaless -- it comes from different sources and each source has its own
format. Because MongoDB is external to our project, it had to be mocked
(sidenote: mocks are there exactly to do this: the avoid having to manage
something external to your project).

PyMongo, the MongoDB driver for Python, has a `find()` function, pretty much
like the MongoDB API; this function returns a list (or iterator, I guess) with
all the result records in the collection. Because it is a list (iterator,
whatever), it has a `count()` function that returns the number of records. So
you have something like this:

```mongodb
connector.collection.find({'field': 'value'}).count()
```

(Find everything which has a field named "field" that has a value of "value"
and count the results. Pretty simple, right?)

The second hand of information you need is about the `mock` module. Python 3
has a module for mocking external resources, which is also available to Python 2. 
The interface is the same, so you can 
[refer to the Python 3 documentation](https://docs.python.org/dev/library/unittest.mock.html) 
for both versions.

An usage example would be something like this: If I had a function like:

```python
def request():
  return connector.collection.find({'field': 'value'})
```

and I want to test it, I could this:

```python
class TestRequest(unittest.TestCase):
   @patch("MyModule.connector.collection.find")
   def test_request(self, mocked_find):
      mocked_find.return_value = [{'field': 'value', 'record': 1},
                                  {'field': 'value', 'record': 2}]
      result = request()
      self.assertDictEqual(result, mocked_find.return_value)
```

Kinda sketchy for a test, but I just want to use to explain what is going on:
the `@patch` decorator is creating a stub for any call for
`MyModule.connector.collection.find`; inside the test itself, the stub is
being converted to a mock by setting a `return_value`; when the test is run,
the mock library will intercept a call to the `collection.find` inside
`MyModule.connector` (because that module imported PyMongo driver to its
namespace as `connector`) and return the `return_value` instead.

Simple when someone explains like this, right? Well, at least I hope you got
the basics of this mocked stuff.

Now, what if you had to count the number of results? It's pretty damn easy to
realize how to do so: just call `count()` on the resulting list, or make it
return an object that has a `count()` property. 

The whole problem we had was that the result of `find()` was irrelevant and
all we wanted was the count. Something like

```python
def has_values():
   elements = connector.collection.find({'field': 'value'}).count()
   return elements > 1
```

First of all, you can't patch `MyModule.connector.collection.find.count`
because you'll only stub the `count` call, not `find`, which will actually try
to connect on MongoDB; so the original patch is required. And you can't patch
both `find` and `count` because the first patch will return a new `MagicMock`
object, which will not be patched (after all, it is *another* object). The
original developer tried to fix it this way:

```python
mocked_find.count.return_value = 0
```

... which, again, doesn't work because the call to `find()` will return a
`MagicMock` that doesn't have its `count` patched. But the developer never
realized that because `MagicMock` tries its best to *not* blow up your tests,
including having return values to conversions like... int. And it will always
return 1.

Is your head spinning yet? Mine sure did when I realized the whole mess it was
being made. And let me repeat this: The problem was *not* that MongoDB was
being mocked, but that it was being *mocked in the wrong way*.

The solution? As pointed above, make `find` return an object with a `count`
method.

```python
count_mock = MagicMock(return_value=0)
mocked_find.return_value = MagicMock(
    **{'count': count_mock})
```
