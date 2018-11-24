+++
title = "On Unit Tests and Layers"
date = 2017-09-11

category = "code"

[taxonomies]
tags = ["unit tests", "en-au", "testing", "layers"]
+++

On a recent discussion about testing, I think I came up with a
reason why some people really think we need to test everything: they
are thinking in layers, without even realizing it.

<!-- more -->

This weekend I had an idea on why some people insist on writing tests for
every single function and object, but first you must know that 3 things
happened:

First, I told someone a programmer-joke like this: "You can't teach top-down
development to newcomers 'cause they don't know which side is up." (Actually, I
heard from someone else; I'm not that smart to come with a line like this).
Yes, it is a joke; yes, it is somewhat fun, but at the same time, it is a
reality: we should let newcomers get wet before telling them how to properly
design their project.

The second is that I got "drafted" to do a tutorial on DjangoRestFramework and,
because I was expecting someone to ask how to manage validation on forms and
serializers and decided to learn a bit more about "fat models", which basically
says you should put all your business rules on the model layer. And here is the
part that stuck with me: the model is not an *object*, but a *layer*.

{% note() %}
"forms" are responsible for validating incoming HTML form content;
"serializers" are responsible for validating incoming data from the API --
although "serializers" are also responsible for serializing the output data
back to the client.
{% end %}

The third is that I was summoned to explain to a group to explain what should
be tested. Thing is, they did a "fizzbuzz" code in which they had
`multiple_of_3`, `multiple_of_5`, `multiple_of_15` and someone mentioned
that we *should* test them too.

And that's what got me thinking: Should we test it? My response for this
question is always "no, think your project is a black box in which you press a
button and some light goes on; you don't need to know if there is a nerve
somewhere in your knee that you hit it and your leg does some kicking or if
the signal is sent all the way to your brain and it sends a response back to
the muscle to make it kick, all you need to know -- and test -- is that when
you hit someone in the knee, they kick and *that's* your requirement and
*that's* what you should test." But what if it is not that simple?

The model *layer* has a responsability and has its own requirements: It should
receive the data and store it somewhere; it can expose some business rules (as
validation of said data) but shouldn't run those rules. The controller *layer*
also has its own responsabilities and its own requireements: it gets the data
from somewhere, do the checks, validate the business rules and then sends it
to the model layer to be store. The view *layer*, again, has its own
responsabilities and its own requirements: exposes the data to the user and
receives data from the user and passes it to the controller layer, exposing
the errors back to the user.

In a way, all those layers could be separate projects: because they have a
defined API, one could replace each layer independently -- I could have a
model layer that stores all that in JSON and then replace it to one that
stores in a Stream Processing Database and the controller and view layers will
never know about. All those layers could be separate *libraries* -- a lost art
of getting code with a single functionality and giving it its own space, with
its own build tools and a well defined interface and which is its used by other
projects as a black box: they know the interface, but they don't know how,
internally, the library does whatever it does.

And, because each library has its own code, it will have its own tests.

And that's what people were seeing: They were seeing, unconciously,  "this is
another *layer* in the project, this layer should be tested because it can be
replaced any time". Each `multilple_of` function was an *API* exposed from
the model layer and, thus, should be tested. Even if the design doesn't seem
to be layered and appear all around the code.

Thing is, each layer is nothing by itself: There is no use for exposing
business/validation rules without a controller to send the data; there is no
use for something to validate incoming data and apply business rules if there
is noone sending the data and noone to store it; there is no use for something
responsibile for calling business rules check if there isn't business rules.
All three layers are required to do the word -- and that's probably why I
believe you should test them all as a single unity.

But, in the very end, it seems that going full force into unit tests and what
should be tested can actually help people see they layers of their projects.
