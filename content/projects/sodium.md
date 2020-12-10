+++
title = "Condensed Sodium"
date = 2020-12-10

[taxonomies]
tags = ["projects", "personal", "client", "status", "web", "rust"]
+++

A Client Status web app.

* [Rocket](https://rocket.rs/)
* [Diesel](http://diesel.rs/)
* [TailwindCSS](https://tailwindcss.com/)
* Translatable.
* Contacts:
        * Name
        * Phone
        * Email
        * Company
* Clients are basically groups of contacts + interactions.
* Interaction can be marked as "Successful" or "Waiting".
* Dashboard shows all clients with their statuses.

```
+----------------------------------+
| +-----------+ +----------------+ |
| | Client 1  | | Client 2       | |
| | No issues | | Await response | |
| +-----------+ +----------------+ |
+----------------------------------+
```

"Await response" is the text of the interaction.

```
+----------------------------------+
| Client 2        [ See Contacts ] |
|                                  |
| New interaction:                 |
| [                              ] |
| [                              ] |
| [                              ] |
|            [ Await ] [ Success ] |
|                                  |
| Previous interactions:           |
| * DATE - Asked if this works   ! |
| * DATE - Await response        ? |
+----------------------------------+
```

"Previous interactions" goes from the oldest to the newest results.
