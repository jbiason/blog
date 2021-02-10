+++
title = "Concise Guide To Databases - Peter Lake, Paul Crowther"
date = 2021-02-10

[taxonomies]
tags = ["books", "reviews", "it", "books:2021", "published:2013", "peter lake",
"paul crowther"]
+++

[GoodReads
Summary](https://www.goodreads.com/book/show/18475615-concise-guide-to-databases):
This easy-to-read textbook/reference presents a comprehensive introduction to
databases, opening with a concise history of databases and of data as an
organisational asset. As relational database management systems are no longer
the only database solution, the book takes a wider view of database technology,
encompassing big data, NoSQL, object and object-relational, and in-memory
databases. The text also examines the issues of scalability, availability,
performance and security encountered when building and running a database in the
real world.

<!-- more -->

{{ stars(stars=1) }}

Let me get something out of my system straight away: This book needs some
**serious** proof-reading. The authors seem to have an aversion to commas, and
that makes reading some sentences really hard ("Is that an adjective or a noun?
Oh, heck, I though it was an adjective, and now things don't make sense; let me
read that again as a noun to see if that works.") There are a lot of repeat
content (three times there is a discussion on how HDD prices are falling, how
the price per megabyte is falling and how SSD is faster than HD). All the
abstracts, the first part of every chapter, are just some copy'n'paste from a
few phrases of the first part after the abstract. And there are "is in the a
Microsoft", "none encrypted protocol" and there is even a "[company] and there
product". And two paragraphs one-next-to-the-other have "OS" written in 3
different ways ("o/s", "O/S" and "OS"). Oh, and there is no definitive style for
anything: Sometimes quotations would have a larger margin compared to the rest
of the text and sometimes they won't; all commands (including SQL queries and
related commands to be entered in databases) are all in the same font as the
rest of the text (with one single exception in the end of the book); sometimes
there are sub-sub-sections (like "14.4.1.1) and sometimes it just uses bold text
with no numeration.

But, if the book was actually nice (and easy) to read, besides all that, does is
live to its title? No.

Is it "Concise"? Well, not quite. The printed version is 300+ pages long, which
I could hardly call "concise". A lot of content could be removed with no affect
in the end, like the step-by-step explanation of all 5 levels of database
normalization (which is also arguable if that makes sense in a book that should
discuss databases), the explanation of XML (which is not arguable and feels
completely lost in a book about databases) and discussions on what to do when a
disk fails.

Is it a "Guide"? Not quite. The book does explore (lightly) different databases,
but fails to point **where** each makes sense: What kind of data/database
structure makes sense in a relational database? What kind of data fits better on
a NoSQL database? When it makes sense to use Hadoop?

Is it about "Databases"? That's where the book fails hard, in my opinion. Sure,
it talks about Oracle, and a bit about Mongo, and Oracle, and some about
Cassandra, and Oracle, and they even mention Hadoop. And then Oracle. It feels
like the whole book is just a huge propaganda on how to operate Oracle, how
Oracle tools work, and so on. Sure they talk about other databases, but when
every example is about Oracle, you have to wonder why.

Another example of how the book leans towards Oracle: There is a single mention
to PostgreSQL, saying that it "is popular with personal computer users". Heck,
AWS RDS was launched 4 years prior to the publishing of this book and it already
had the PostgreSQL layer. Since early 2000s, every time someone asked "What
database should I use for my project?" there was at least one "PostgreSQL"
answer. But, since PostgreSQL is in direct competition with Oracle, you can see
why it is largely ignored.

So, hard to read and doesn't fill the topic it proposes in its title. "7
Databases in 7 Weeks" does a better job about being a Guide to Databases than
this.

---

ISSN 1863-7310e-ISSN 2197-1781

ISBN 978-1-4471-5600-0e-ISBN 978-1-4471-5601-7
