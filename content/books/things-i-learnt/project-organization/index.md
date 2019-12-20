+++
title = "Things I Learnt The Hard Way - Organize Your Code by Data/Type, Not Functionality"
date = 2019-07-15

[taxonomies]
tags = ["books", "things i learnt", "project", "project organization"]
+++

A lot of projects assume that you'll put things with the same functionality in
the same place, no matter what data they deal with. This makes things harder
to break apart later.

<!-- more -->

Most projects keep organized by the functionality each component do. For
example, all the models are in the same place, all the functions that convert
one model into an internal structure/DTO are kept together, and so on.
Something like this:

```
.
+-- IncomingModels
|   +-- DataTypeInterface
|   +-- DataType1
|   +-- DataType2
|   +-- DataType3
+-- Filters
|   +-- FilterInterface
|   +-- FilterValidDataType2
+-- Processors
|   +-- ProcessorInterface
|   +-- ConvertDataType1ToDto1
|   +-- ConvertDataType2ToDto2
+-- OutgoingModels
    +-- DtoInterface
    +-- Dto1
	+-- Dto2
```

This is fine and works. But when you organize by data, it'll make a lot easier
to split your project in smaller projects -- 'cause, at some point, you may
want to do almost the same thing as you're doing right now, but with small
differences.

```
.
+-- Base
|   +-- IncomingModels
|   |   +-- DataTypeInterface
|   +-- Filters
|   |   +-- FilterInterface
|   +-- Processors
|   |   +-- ProcessorInterface
|   +-- OutgoingModels
|       +-- DtoInterface
+-- Data1
|   +-- IncomingModels
|   |   +-- DataType1
|   +-- Processors
|   |   +-- ConvertDataType1ToDto1
|   +-- OutgoingModels
|       +-- Dto1
...
```

Now you can make a module that deals _only_ with Data1, another that works
only with Data2 and so on. And then you can break them into isolated modules.

And then when you have another project that also have Data1 but also deals
with Data3, you can reuse most of the stuff in the Data1 module.

And I do understand that this creates an explosion of directories/packages,
which may seem a bit unnecessary.

Believe me, I also thought the idea of keeping things by functionality made
more sense. But in one project, I got a requirement to do almost the same
thing as I was doing before, but with a small change, which would require one
less step/transformation (in our example, you can think as the new requirement
as doing exactly what the Data1, Data2 and Data3 did, with their
transformations and such, but without the Data3 part). By breaking by their
types, I managed to create small modules for each one and the new project
would simply reference Data1 and Data2, but not Data3.

{{ chapters(prev_chapter_link="/books/things-i-learnt/git-flow", prev_chapter_title="Git-Flow Is The Way To Go", next_chapter_link="/books/things-i-learnt/libraries", next_chapter_title="Create Libraries") }}
