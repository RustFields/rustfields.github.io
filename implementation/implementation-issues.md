---
layout: default
title: Implementation
nav_order: 6
permalink: /implementation-issues
---
# Implementation Issues

## Scala Native, Rust and C Interoperability

Among the possible solutions analyzed to develop the integration layer between Rust and Scala, it was decided to use Scala Native and exploit the interoperability of the languages with the C language.
Interoperability details are defined in the documentation of the two projects:
- Rust: https://docs.rust-embedded.org/book/interoperability/index.html
- Scala Native: https://scala-native.org/en/stable/user/interop.html

As the documentation states, interoperability has well-defined limits and it is not possible to take full advantage of the functionality of the two languages.

A Rust function can be made interoperable with the C language by making the following changes:

As expected, you cannot use generics in Rust if your code is to be interoperable with the C language.

```rust
#[no_mangle]
pub extern "C" fn local_sense<A: 'static>(&self, sensor_id: &SensorId) -> Option<&A> {
    self.context.local_sense::<A>(sensor_id)
}
```
![](../assets/functions-generic-over-types-must-be-mangled-warning.png)

```rust
#[no_mangle]
pub extern "C" fn new(context: Context) -> Self {
    Self {
        vm: RoundVM::new_empty(context)
    }
}
```

![](../assets/not-FFI-safe-warning.png)

```rust
    #[no_mangle]
    pub extern "C" fn new(context: Context, status: VMStatus, export_stack: Vec<Export>) -> Self {
        Self {
            context,
            status,
            export_stack,
            isolated: false,
        }
    }
```

![](../assets/symbol-new-already-defined-error.png)
