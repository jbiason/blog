+++
title = "Timeout With Command in Tokio"
date = 2023-08-31

[taxonomies]
tags = ["random", "rust", "tokio", "spawn", "process", "command", "timeout"]
+++

How to spawn an external command and give it a timeout in Rust, with Tokio

<!-- more -->

The entry point for running external applications in Rust is the
[Command](https://doc.rust-lang.org/std/process/struct.Command.html) structure,
in the process module. This whole structure is duplicated [on Tokio, with
async](https://docs.rs/tokio/latest/tokio/process/struct.Command.html).

But there is one thing that exist in other languages (like Python) that Rust
doesn't have: Having a timeout for the command (and killing it if it runs over
the timeout). The usual solution is to run the command on a specialized thread
and, with another thread, make sure to kill the first if the second finishes
first.

But Tokio have a funcionality that saves a lot of code when dealing with this:
[timeout](https://docs.rs/tokio/latest/tokio/time/fn.timeout.html). While it
doesn't apply to the Command itself, it applies to Futures, and waiting for a
command is an async function, which means it is wrapped around a Future, and we
can leverage this.

```rust
use std::time::Duration;

use tokio::process::Command;
use tokio::time::timeout;

#[tokio::main(flavor = "current_thread")]
async fn main() {
    let sleep = "sleep";

    println!("Run 3 secs");
    let mut cmd = Command::new(&sleep).arg("3s").spawn().unwrap();
    if let Err(_) = timeout(Duration::from_secs(4), cmd.wait()).await {
        println!("Got timeout!");
        cmd.kill().await.unwrap();
    } else {
        println!("No timeout");
    }

    println!("Run 25 secs");
    let mut cmd = Command::new(&sleep).arg("25s").spawn().unwrap();
    if let Err(_) = timeout(Duration::from_secs(4), cmd.wait()).await {
        println!("Got timeout");
        cmd.kill().await.unwrap();
    } else {
        println!("No timeout");
    }
}
```

The thing here is `.wait()`. That's when Tokio wraps the command call into a
Future. But, because the task is dead, it doesn't actually kill the command,
and that's why we need to call `.kill()` in case of timeout -- otherwise the
command will still run (you can check this by removing the `.kill()` call on
the 25s block, and calling `ps` after the application finishes).

Just note that the `if let Err(_)` is for timeout; `.wait()` also returns a
`Result`, and that's the one that needs to be checked for the actual success of
the execution.
