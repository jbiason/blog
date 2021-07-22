+++
title = "Command Pattern Experiments in Rust"
date = 2021-07-22

[taxonomies]
tags = ["design patterns", "command", "rust"]
+++

I've been doing some experiments in using the command pattern in Rust and found
at least two ways to write it.

<!-- more -->

## But first... Why?

There is one thing I'm trying to do in which the command pattern fits
perfectly: I want to have a library with all the actions and then plug
interfaces on top of, being either a CLI interface or a Web interface or
whatever interface. For that, the logic behind the action should be somewhat
isolated from whatever source it is calling it.

## What It Is

The Command Pattern is described as having one object for each action ('cause,
you know, the patterns focused more on OO designs) and each of those have an
`execute` method which... well... execute the command.

## The Enum Solution

As what you have is a list of actions, one of the ideas was to use `Enums`,
even if it is not exactly what the pattern describes.

Say, we have two actions can be called: deposit money and withdraw money.
Simple.

So one could have the following Enum[^1]:

```rust
enum Command {
    Deposit(Decimal),
    Withdraw(Decimal),
}
```

Because Rust allows enum variants to carry a value with them, the amount to be
deposited/withdraw is attached directly to the variant.

And then you have the `execute()` function. And, again, 'cause Rust allows
adding functions to almost everything, what I did was add a method in the Enum:

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

To use it, I put something pretty close to this in my interface layer:

```rust
let value = incoming_external_request.value()
let command = match incoming_external_request.command() {
    "deposit" => Command::Deposit(value),
    "withdraw" => Command::Withdraw(value),
}
command.execute();
```

It feels fine and all, but it tends to make a mess with the amount of content
that goes in or around the `impl`, in my opinion. But, at the same time, the
dispatch layer (between the service/enum layer and the interface layer) is
pretty basic.

One solution to the amount of "content in or around `impl`" could be use
multiple `impl`: So I could have a module `deposit.rs` which `impl`s the
`do_the_deposit` and another module `withdraw.rs` which also `impl`s inside the
enum with the `withdraw_money` content. But I'd still need the center `execute`
to do the proper "dispatch" of the calls.

## The Trait Solution

The trait solution is very close to what the pattern is: You create a trait
(interface) and "impl" it for all the commands, which are just structs. For
example:

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

... which feels a bit cleaner, since all related things to Deposit or Withdraw
are now tied together.

However, this causes a slight problem with the interface layer: Now it can't
just return one sized thing: It needs to return a dynamic dispatchable content,
like `Box<dyn Command>`, which isn't as pretty as the direct Enum/Struct/sized
content.

On the other hand, since `Box` implements `Deref`, once the interface throws
something-that-implements-Command, one could just call `execute()` directly on
it.

```rust
let command = interface_that_returns_a_box_dyn_command();
command.execute();
```

## Where I see those two

I can see the Enum being used for simple, single domain architectures. Since
all things are related, they can reside correctly under the Enum.

But when dealing with multiple domains, the trait/dynamic dispatch feels more
at home: Related things get into their own module, in their own space and the
idea of mixing them (for example, if you have a money domain and a tag domain,
and you want to tag money operations) goes on layer above.

---

[^1]: `Decimal` is not part of Rust Standard Library, but can be used from the
  [rust_decimal crate](https://crates.io/crates/rust_decimal).
