+++
title = "The Day I Found My Old Code"
date = 2015-12-18
category = "code"

[taxonomies]
tags = ["code", "python", "pep8", "pylint", "en-au"]
+++

Found a piece of code I wrote 2 years ago, following a lot of linters. I'm
amazed how readable the code still is.

<!-- more -->

Today, walking across a client repository, I found a module I wrote two years
ago in Python. At the time, we lacked the knowledge to write proper tests, but
we used a lot of other tools: PEP8 and Pylint, mostly.

Today-me is pissed with two-years-ago-me for the lack of tests, but where my
memory forgot the nuances of the project, the huge amount of comments and
proper documentation makes it for.

For example, every pylint disable have an explanation about why it was
disabled:

```python
# flask has a weird way to deal with extensions, which work fine but confuses
# the hell out of PyLint.
```

Related modules are loaded in sequence, with line breaks between different
sources: 

```python
from flask.ext.babel import Babel
from flask.ext.babel import refresh

from flask.ext.gravatar import Gravatar

from werkzeug.routing import NotFound
from werkzeug.routing import RequestRedirect
```

Every variable, every function, is documented in proper Sphinx format, which
contributes to understanding what the variable/function do:

```python
#: Session duration time
#: The time is given as number and a time interval ("m" for minutes, "h" for
#: hours, "d" for days and "w" for weeks), e.g., "3d". A value of "None" will
#: make the session last till the user closes the browser.
SESSION_EXPIRATION = "1d"
```

```python
def reroute(route):
    """Route control. The route must exist in the known routes list to return
    a valid result; unknown routes will be redirected to the 404 page; if the
    route exists but it's marked as "maintenance", the request will be
    redirected to the 503 page."""
```

Also, I found a class with a docstring of about 20 lines. It explains every
single parameter in its `__init__` function, which makes perfect sense when
you generate the documentation.

Where the functions lacked a good name (due having a good name inside their
own objects/modules), a comment was added to explain what the function was
actually doing:

```python
inject(current_app)         # inject values if run stand-alone modules
load_routes(current_app)    # load the routing information
register_filters()          # register jinja filters
register_functions()        # register jinja functions
register_tests()            # register jinja tests
set_session_time()          # define the cookie time
```

Also, I had the slight habit of putting large comments in the code when
something was kinda hacky:

```python
# Now you're asking yourself: "Why heuristic find?" The reason is
# simple: in _function() , we add a new endpoint on top of one
# existing endpoint; because we do that on top of anything, we don't
# know, for sure, which one of the parameters the user (the other
# programmer, in this case) used in their URLs. So we need to through
# all parameters they expect to receive in their detail function in
# the hopes of finding something that actually matches a "pk".
```

It doesn't make much sense here, but believe me, it works. I was just reading
the code with a function called `heuristic_find` and I was "Man, which drugs I
took to call it 'heuristic_find'?" And BOOM, there it was why it was called
like that.

Ok, honesty time: I wasn't the only one writing this code. But thanks to the
client input, I started and enforced all those rules (and wrote a huge part of
the base code), the code is still readable two years later.

Yeah, I'm proud of it. 
