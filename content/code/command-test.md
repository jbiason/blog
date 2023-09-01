+++
title = "Running a Command and Saving Its Output to File in Rust"
date = 2023-09-01

[taxonomies]
tags = ["random", "rust", "command", "log"]
+++

I had an issue: I needed to run a command inside Rust, but I needed that all
its output should go to a file, and I needed to check if there were certain
phrases in it.

<!-- more -->

So, first step: Create a script that could "replicate" the output of a command,
with the expected strings to be captured:

```bash
#!/usr/bin/env bash

for loop in {1..1000}
do
	echo "Hello, I'm a script!"
	echo "I write stuff in the output."
	echo "Everything should go to a file."
	echo "But also, you need to capture warnings:"

	if (( $loop%7 == 0)); then
		echo "WARNING: This is a warning"
		echo "   It continues if the line starts with spaces"
		echo "   And keeps going till there are no more spaces-prefixes"
	fi

	if (( $loop%8 == 0)); then
		# ERR is just to make sure we find it easily in the logs
		echo "ERR: Sometimes, I also write in stderr!" >&2
		echo "ERR: Just for funsies!" >&2
	fi

	echo "Like this."
	echo "Then you're good to go."
	echo ""
done
```

What this script does is to print a message over 1,000 times, and sometimes it
will display a "WARNING" text -- which is the special output I need to capture --
and sometimes it will print things to stderr.

For the code, what we need to do is:

1. Spawn the command;
2. Take the stdour (and stderr) from it.
3. Spawn a thread that will keep listening to the output, doing the search,
   and writing everything to a file (our log).
4. The thread returns the list of captured messages, which we can get back
   when we `.join()` it.
5. Since I was expecting stderr to be smaller enough, I did the capturing of
   it after the thread completes (which would also close the file, so we can
   be sure that we can open it again without any issues).

The first step is quite easy: Just use `std::process::Command` and use the
`.spawn()` function to create the `Child` controller.

For the second step, we use the `Child` structure and use `.take()` on both
stdout and stderr. This will give us the file descriptor for both (think about
them as `File`s).

The third step is quite easy, actualy: `std::thread::spawn()` to create a
thread, and just read the content from the file descriptors from step 2. In
this, I used `BufReader`, which gives access to reading the content line by
line, which is way easier than reading to a buffer and processing it.

```rust
use std::fs::{File, OpenOptions};
use std::io::{BufRead, BufReader, Read, Write};
use std::path::PathBuf;
use std::process::Command;

fn main() {
    // this requires always running with `cargo run`
    let base = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let the_script = base.join("src").join("the_script.sh");

    let mut cmd = Command::new("bash")
        .arg(the_script)
        .stdout(std::process::Stdio::piped())
        .stderr(std::process::Stdio::piped())
        .spawn()
        .unwrap();

    // capture both the stdout and stderr as File structs (actually FDs, but basically the same
    // thing)
    let stdout = cmd.stdout.take().unwrap();
    let mut stderr = cmd.stderr.take().unwrap();

    // spawn a thread to keep capturing and processing the stdout.
    let writer_pid = std::thread::spawn(move || {
        let reader = BufReader::new(stdout);
        let lines = reader.lines();
        let mut log_file = File::create("script.log").unwrap();
        let mut in_warning = false;
        let mut result = Vec::new();

        for line in lines {
            let line = line.unwrap();
            log_file.write(line.as_bytes()).unwrap();
            log_file.write(b"\n").unwrap(); // 'cause lines() eat it

            if line.starts_with("WARNING:") {
                in_warning = true;
            } else if line.starts_with("   ") && in_warning {
                result.push(line);
            } else if in_warning {
                in_warning = false;
            }
        }

        result
    });

    // run the command till it finishes
    cmd.wait().unwrap();

    // ... and wait till the thread finishes processing the whole output.
    let warnings = writer_pid.join().unwrap();

    // this is somewhat a hack: Instead of spawning a thread for stderr and trying to fight with
    // stdout for the lock to be able to write in the log file, we do this after the thread ends
    // (which closes the file) and then open it again and write the stderr in the end. We do this
    // 'cause we expect that the stderr is way smaller than stdout and can fit in memory without
    // any issues.
    let mut buffer = String::new();
    stderr.read_to_string(&mut buffer).unwrap();

    let mut file = OpenOptions::new().append(true).open("script.log").unwrap();
    file.write(buffer.as_bytes()).unwrap();

    // This is purely for diagnostic purposes. We could put the warnings in another file, or pass
    // it along to something else to process it. Here, we just display them.
    // Same for stderr: Since we already put them in the file, this is used just to make sure we
    // are capturing the errors without looking at the file.
    println!("Warnings:\n{:?}", warnings);
    println!("ERR:\n{:?}", buffer)
}
```
