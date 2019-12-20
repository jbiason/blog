+++
title = "Couchbase Example and REST"
date = 2016-01-12

[taxonomies]
tags = ["rest", "couchbase", "example", "restful"]
+++

Using the example Couchbase to show how REST works.

<!-- more -->

Let me start this by pointing that I'm a RESTnazi: I'm the kind of guy that
will get into a fight with anyone that says things like "Ok, that's because
this is just REST, not RESTful" because... well, because, there is no
diference between REST and RESTful.

And today I found something weird while reading 
[the Couchbase documentation](http://developer.couchbase.com/documentation/server/4.1/travel-app/travel-app-walkthough.html)
with them claiming that their example is REST while... well, it isn't.

But hey, that's a good opportunity to explain a bit what is REST (and what is
not).

## What is REST?

REST is an architecture/design pattern/pick your buzzword built on top of HTTP
to provide information. It has two components:

* **Resources**: That's the elements in your system: Your users, your books,
  your airports, your flights and such.

* **Verbs**: Those are the things you do with your resources: You GET them,
  you UPDATE them, and so on.

There is no true "guideline" on how to write resources. It's usually done with
nouns in their plural form (or, at least, that's what [Apigee](http://apigee.com/about/)
concluded after checking a bunch of APIs around).  Those resources are mapped
through URLs with some base.

Let's pick the example from Couchbase: It's a travel app, with airports,
flights and flight paths. We could use a base URI scheme of
`/travel/api/v1.0/` because:

1. The travel app could also provide a user interface through `/travel/`, so
   we keep the API endpoint on `api` to not mix things.

2. We are versioning the API (here, v1.0). This is a recommendation from
   Apigee and, again, not part of the architecture/design patter/buzzword.

On the top of this base URI, we'll build our resource URLs:

* `/travel/api/v1.0/airports/` and
* `/travel/api/v1.0/flights/`

"Where is the flight path endpoint?", you must be asking? Well, I'll tell you
later about it, hold on a second, but we'll use those two to explain the very
basic of REST first, ok?

Besides those two URIs, we need two more: One for each resource to access
direct elements. So now we have:

* `/travel/api/v1.0/airports/`;
* `/travel/api/v1.0/airports/{airport_id}`;
* `/travel/api/v1.0/flights/` and finally
* `/travel/api/v1.0/flights/{flight_id}`.

So, now that we have our resources, we need ways to manage their contents. For
this, we use the "verbs" I mentioned before. The thing about rest is that
those actions are directly tied to the HTTP verbs:

* **GET** will retrieve elements in the resource;
* **POST** will insert a new element in the resource;
* **PUT** is used to update the information of an element [#put]_;
* **DELETE** is used to remove an element from the resource [#delete]_.

{% note () %}
If you want an easy mnemonic, "PUT" has and "U", for "update". Yes, it's silly,
but it works (at least, for me). Also, a "PUT" directly on a resource means
"replace the whole database with this information" and, thus, not not really
widespread.
{% end %}

{% note() %}
You can add a DELETE for your whole resource, if you're crazy and bold enough.
{% end %}

And adding those two we have:

* Get a list of all airports: `GET /travel/api/v1.0/airports/`
* Add a new airport: `POST /travel/api/v1.0/airports/`
* Get information of a single airport: `GET /travel/api/v1.0/airport_3577`
* Update the information of an airport: `PUT /travel/api/v1.0/airport_3577`

... and so on.

Easy as pie, right?

## The "Flight Path" resource

Now let's go back to the "flight path" resource, which I left behind. Thing
is, a flight path does not exist on its own. If a flight doesn't exist, the
flight path doesn't exist either, right? And if I flight exist, it should have
a path, right?

So a flight path is a resource linked directly to our resource of flights. For
this, REST allows resource chaining by just adding another layer on top of
existing URIs. As we pointed before, a flight path **needs** a flight (a
flight *element*, just to make more clear where I'm going for with this), so
we should build the resource on top of an element URI:

* `/travel/api/v1.0/flights/airline_24/paths` and
* `/travel/api/v1.0/flights/airline_24/paths/{path_id}`

... although the last one only makes sense if a flight could have two (or
more) different paths, which would make sense if it goes one way in a path and
goes back in a different path, which I do not know enough about flights to
know if this is possible, but for the sake of explaining everything about
REST, let's go with it, mkay?

And now you may be wondering: Why not simply do
`/travel/api/v1.0/flightpaths/{path_id}`? Again, because flight paths are tied
to flights, this means the base resource for the flight won't even exist and,
thus, it's sub-resources won't be available, which makes a lot of sense.

## Filtering results

Ok, now we know how to retrieve all airports, which is nice, but we don't want
them all: the user will type something and we'll show them only the airports
that match their search. We could screw the user and send the whole list to
them and let the application filter it locally, abusing the user bandwidth and
CPU power -- which isn't nice, since we have a database on our side that can
do this filtering faster.

Because we can use URIs only to point to resources and resource elements, we
need a different way of passing this to the server. And guess what? HTTP have
the proper way to do this: querystrings and forms.

Querystrings, for those unfamiliar with HTTP, are the things can come after
the "?" in the URL. For example, in the URL:
"`http://example.com/sayname?name=julio`", "`name=julio`" is the querystring.
It provides a key ("name") and a value ("julio"). Forms are basically the
same, but instead of being part of the URL, they are sent in the body of the
HTTP request (and can be much, much larger than querystrings).

There is one more thing about querystrings and forms: The only way to send
information to the server in a `GET` request is through querystrings, since
GETs do not have a body. DELETEs can have a body, but the RFC says it should
be ignored. POST and PUT do have bodies and, thus, information about the
element to be added/updated should come in there.

So, for filtering, we could have a "filter" querystring to filter elements.
Couchbase filters airports with a single querystring, so we could simply do

`GET /travel/api/v1.0/airports/?filter=<user input>`

So the user will see a bunch of airports with their input. And, since we have
all the airport, we could also link the flights as a subresource of it, with:

`GET /travel/api/v1.0/airports/<airport_id>/flights/`

... which we didn't mention before, but it is now making sense, right?

Couchbase example also allows showing which flights connect two airports and
the REST way is, again, using querystrings:

`GET /travel/api/v1.0/airports/<airport_id>/flights/?connectedTo=<airport_id>`

And, if you want to be nice enough, you could even add a "fields" parameter,
so your API consumers could filter out fields they don't want in the results,
to reduce the bandwidth required. But it's all up to you.

Weird how things make absolute sense here, and we never called the "flights"
resource, right? That's one of the things about REST: you build resources in a
way that make sense for the **consumer** of the API, not to reflect your
database.

## Pagination

Just for the sake of completeness, let's talk a bit about pagination.

Pagination, in REST, works for getting all the elements in the resource, so
it's used in the GET request for the resource. And, because it's part of the
GET request, it should come in the querystring.

There are a couple of ways of doing pagination, in this case:

* Let the consumer specify page size and page count: In this case, you could
  have a query string like `count=15&page=2` to retrieve the elements from the
  second page of 15 elements each. This is the most common way of doing
  pagination and Twitter is one good example of this.

* Have a hardcoded pagesize: Same as before, but the only option available is
  `page=2`.

* Have the consumer specify the last seen element and page size. So the first
  request would have something like `count=15` to retrieve the first 15
  elements, but the next request would have the last element in the list as a
  parameter, like `count=15&lastSeen=16` and the server would return all
  elements that come after the element with id "16". This prevents duplication
  in the results in case a new element is added. Reddit uses this in their
  API.

## The type of response

Again, for the sake of completeness, you may have noticed that not even once I
mentioned the type of data to be returned in each step. That's because REST
does not have a format: You could build a whole service that returns HTML
pages in REST format, and that's ok; you could return JSON, which the
Couchbase documentation points correctly that it is the most widely used
format; you could return XML; if you're crazy enough and want to return in
COBOL format, go for it!

## So, where the example fails to be REST?

1. All paths are marked with "findAll". "findAll" is **not** a resource and,
   thus, shouldn't be in the URL.

2. As I pointed, flight paths are actually a sub-resource of flights and
   should be linked. Flight paths should **not** exist if the flight doesn't
   exist.

The flight path query uses querystrings to retrieve the information for paths
that go through two airports, which is the right way of doing, but again, it
shouldn't be a resource on itself.

## How to fix the documenation

Easy way? Remove the "REST" mention in the pages. I *am* nitpicking the word
"REST" there, I fully reckonize it, and I understand that for the sake of
example it doesn't have to be REST, but it seems wrong to tell people
something is REST when it isn't.

If Oracle decided to say "we added a field type that can store huge amounts
of JSON data, and although you can't query its content, we can now say
OracleDB is a NoSQL database", people would lose their minds. But that's kinda
like I'm feeling about this whole thing.
