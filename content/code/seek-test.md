+++
title = "Seek Test"
date = 2023-08-07

[taxonomies]
tags = ["random", "example", "rust", "seek"]
+++

How to use `.seek()` in Tokio `BufReader`s.

<!-- more -->

What was the issue:

I needed to read a file that have a header, marked with `#` and then followed
by the data itself; all the data is TSV (tab-separated-values). Note that there
is just one header and one data; it is not expected to find more headers/header
information after you start reading the data.

The easy solution could be:

1. Open file;
2. Read all the lines till there is one that **doesn't** start with `#`;
3. Close file;
4. Open the file again;
5. Skip all lines that start with `#`;
6. Process the result.

Because I didn't want to read part of the file again, I wanted to rewind the
cursor and have only one open. The general idea would be:

1. Open file.
2. Read all the lines till there is one that **doesn't** start with `#`;
3. Rewind the file reader the number of bytes of this line, thus returning to
   the very start of it;
4. Consider the header read; the next reads would always produce the data.

Example souce file:

```csv
# This is a header
# Each field is tab-separated.
# But so is the data, so it is all good.
# field1	field2	field3	field4
0	1	2	3
1	2	3	4	
2	3	4	5
3	4	5	6
```

And the file that actually reads it:

```rust
use std::io::SeekFrom;
use std::path::PathBuf;

use tokio::fs::File;
use tokio::io::AsyncBufReadExt;
use tokio::io::AsyncSeekExt;
use tokio::io::BufReader;

#[tokio::main(flavor = "current_thread")]
async fn main() {
    let file_name = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("resources")
        .join("the_file.tsv");

    let file = File::open(&file_name).await.unwrap();
    let reader = BufReader::new(file);
    // Here is why I can't seek after using `.lines()`:
    // `.lines()` takes `self` and not `&self`.
    let mut lines = reader.lines();

    println!("Finding headers...");
    while let Some(line) = lines.next_line().await.unwrap() {
        println!("\tGot line: {}", line);
        if !line.starts_with('#') {
            println!("\t\tOops, headers are done!");
            // XXX issue here:
            // We are assuming "+1" 'cause that the `\n` character that `.lines()` "eat" on every
            // read. But, on DOS files, it would be `\r\n`, or 2 bytes.
            // Need to find out a way to figure the line ending before doing "1+" or "2+" here.
            let bytes = (1 + line.bytes().len() as i64) * -1;
            println!("\t\tMust rewind {bytes} positions...");

            let mut inner = lines.into_inner(); // get back our BufReader
            inner.seek(SeekFrom::Current(bytes)).await.unwrap();

            lines = inner.lines(); // build a line reader from the rewinded Reader
            break;
        }
    }

    println!("Now it should be data...");
    while let Some(line) = lines.next_line().await.unwrap() {
        println!("\tGot line: {}", line);
    }
}
```
