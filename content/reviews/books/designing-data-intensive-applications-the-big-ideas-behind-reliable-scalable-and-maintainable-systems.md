+++
title = "Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems - Martin Kleppmann"
date = 2018-01-19

category = "review"

[taxonomies]
tags = ["books", "en-au", "martin kleppmann"]
+++
{{ stars(stars=3) }}

First off, right out of the bat: If you want to design Data Intensive Applications, this is *not* the book you're looking for. This book goes greats lengths to explain how already existing Data Intensive Applications work -- say, how Zookeeper works when synching data, how Cassandra works without a leader, how PostgreSQL do transactions and so on.

While informative, the biggest problem is that most of the text is very loaded: there are layers and layers on each paragraph and you'll take a long time putting it all together.

Personaly, I felt it lacked examples. Sure, it's interesting how many ways you can do leader election, but which databases use this or that way? I can see that one way is the way I want to build my applications on top, but without a really good example, where should I look?

Also, there is a slight tendency to describe the "market winners" in way more detail than everything else. There are long discussions about the ways Cassandra solves its problems than Voldermort (obviously, there is a reason why Cassandra is the market winner, but this "over-focus" on certain applications is tiring and just do a job on keeping those on top -- because that's the ones the book talks and who will look at a database called Voldermort when you mention it just in passing?)

Overall, it felt like reading my old "Operating Systems 101" books again -- in a theorical way, not productive way.