+++
title = "Command Pattern Experiments in Rust"
date = 2021-07-22

[taxonomies]
tags = ["design patterns", "command", "rust"]
+++

I've been playing a bit with the command pattern in Rust and found at least two
ways to write it.

<!-- more -->

## But first... why?

There is one thing I'm trying to do with all this: I want to have a library
with all the actions and then plug interfaces on top of, being either a CLI
interface or a Web interface or whatever interface. For that, the logic behind
the action should be somewhat isolated from whatever source it is calling it.
And the command interface fits perfectly in this.

## The Enum Solution

Because you have a list of actions, one of the ideas was to use `Enums`.

Say, we have two actions the user can trigger: deposit money and withdraw
money. Simple.

So one could have the following Enum:

```rust
enum Command {
    Deposit(Decimal),
    Withdraw(Decimal),
}
```

Because Rust allows enum variants to carry a value with them, the amount to be
deposited/withdraw is attached directly to the variant.

And then you have the `execute()` function. And, again, 'cause Rust allows
adding functions to almost everything, what I did was:

```rust
impl Command {
    fn execute(&self) -> Result<...> {
        match self {
            Deposit(value) => do_the_deposit(value),
            Withdraw(value) => withdraw_money(value),
        }
    }
}
```

... and so on.

It feels fine and all, but it tends to make a mess with the amount of content
that goes in or around the `impl`, in my opinion. But, at the same time, means
that our interface layer must just return `Command` and that's all fine.

One solution to the amount of "content in or around `impl`" could be use
multiple `impl`: So I could have a module `deposit.rs` which `impl`s the
`do_the_deposit` and another module `withdraw.rs` which also `impl`s inside the
enum with the `withdraw_money` content. But I'd still need the center `execute`
to do the proper "dispatch" of the calls.

## The Trait Solution

The trait solution is very close to what the pattern is: You create a trait and
"impl" it for all the commands. For example:

```rust
trait Command {
    fn execute(&self) -> Result<...>;
}
```

```rust
struct Deposit(Decimal);
impl Command for Deposit {
    fn execute(&self) -> Result<...> {
        // what was `do_the_deposit` now goes here.
    }
}

struct Withdraw(Decimal);
impl Command for Withdraw {
    fn execute(&self) -> Result<...> {
        // what was `withdraw_money` now goes here.
    }
}
```

This causes a slight problem with the interface layer: Now it can't just return
one sized thing: It needs to return a dynamic dispatchable content, like
`Box<dyn Command>`, which isn't as pretty as the direct Enum/Struct/sized
content from the Enum.

On the other hand, since `Box` implements `Deref`, once the interface throws
something-that-implements-Command, one could just call `execute()` directly on
it.

```rust
let command = interface_that_returns_a_box_dyn_command();
command.execute();
```

Also, because all commands are structures, they can hold the same information
as Enum variants would.

## Where I see those two

I can see the Enum being used for simple, single domain architectures. Since
all things are related, they can reside correctly under the Enum.

But when dealing with multiple domains, the trait/dynamic dispatch feels more
at home: Related things get into their own module, in their own space and the
idea of mixing them goes on layer above.
