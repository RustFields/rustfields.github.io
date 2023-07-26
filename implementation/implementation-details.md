---
title: Implementation details
parent: Implementation
has_children: false
nav_order: 1
---

# Implementation details

## Rust features

### Ownership & borrowing

Ownership is a set of rules that govern how a Rust program manages memory, it enables Rust to make memory safety guarantees without needing a garbage collector.
Ownership's rules are the following:

- Each value in Rust has an owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the value will be dropped.

Most of the time, we'd like to access data without taking ownership of it. To accomplish this, Rust uses a borrowing mechanism. Instead of passing objects by value (T), objects can be passed by reference (&T).

Below is an example taken from the form `rufi_core::core::vm::round_vm::round_vm` module. The `struct VMStatus` has a neighbor defined as `Option<i32>` and we want to return its reference without losing ownership of it:

```rust
pub fn neighbor(&self) -> &Option<i32> {
    &self.status.neighbour
}
```

### Function overload

Rust does not support function overloading, so given the following snippet of code:

```rust
pub fn new() -> Self {
    Self {
        slots: vec![],
    }
}

pub fn new(slots: Vec<Slot>) -> Self {
    let mut reversed_slots = slots;
    reversed_slots.reverse();
    Self {
        slots: reversed_slots,
    }
}
```
you will get the following error:

```
error[E0592]: duplicate definitions with name `new`
```
A possible solution for this problem is to remove the second constructor and implement the `From` trait. This is a very simple mechanism to convert between different types:

```rust
impl From<Vec<Slot>> for Path {
    fn from(slots: Vec<Slot>) -> Self {
        let mut reversed_slots = slots;
        reversed_slots.reverse();
        Self {
            slots: reversed_slots,
        }
    }
}

```

### Lifetimes

A lifetime is a construct the compiler uses to ensure all borrows are valid. Specifically, a variable's lifetime begins when it is created and ends when it is destroyed. As a reference lifetime `'static` indicates that the data pointed to by the reference lives for the entire lifetime of the running program.

In the following code snippet:

```rust
pub fn register_root<A: 'static + Copy>(&mut self, v: A) {
    self.export_data().put(Path::new(), || v);
}
```
if we remove the `'static` lifetime we get the following error:

```
error[E0310]: the parameter type `A` may not live long enough
```

### Smart pointers

In the following code snippet, we see that the `HashMap`'s value type is defined as `Box<dyn Any>`:

```rust
pub struct Export {
    pub(crate) map: HashMap<Path, Box<dyn Any>>,
}
```
Why not use `Any` directly? The dyn keyword is used to highlight that calls to methods on the associated `Trait` are dynamically dispatched.
`Box` is a smart pointer: boxes allow you to store data on the heap rather than the stack. What remains on the stack is the pointer to the heap data.
In this case, we use `Box` because we have a type whose size can’t be known at compile time and we want to use a value of that type in a context that requires an exact size.
### Macros

Fundamentally, macros are a way of writing code that writes other code, which is known as metaprogramming.

<div align="center"> 
    <img src="/assets/images/rust-macro.png"> 
</div>