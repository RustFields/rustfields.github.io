---
title: Detailed design
parent: Design
has_children: false
nav_order: 2
---
# Detailed design
In this section, we will show the most critical design choices made that led to the realization of the framework as it currently is.

## Scafi-core

### Language
We decided to keep the core language constructs under a common `Language` trait that can be mixed in with other traits to make it possible to use the core constructs inside code. The core language constructs are the following:

#### Rep
Rep captures state evolution, starting from an `init` value that is updated each round through `fun`.
```scala 
def rep[A](init: => A)(fun: A => A): A
``` 

#### Nbr
Nbr captures communication, of the value computed from its `expr` expression, with neighbors.

```scala 
def nbr[A](expr: => A): A
``` 

#### Foldhood 
Foldhood supports neighborhood data aggregation, through a standard, FP-oriented “fold” with initial value `init`, aggregation function `aggr`, and the set of values to fold over obtained by evaluating `expr` against all neighbors;

```scala
def foldhood[A](init: => A)(aggr: (A, A) => A)(expr: => A): A
```

#### Branch
This function partitions the domain into two subspaces that do not interact with each other, based on the `cond` expression.
```scala
def branch[A](cond: => Boolean)(thn: => A)(els: => A): A
```

By combining these constructs, higher-level functions can be defined to capture increasingly complex collective behavior, called `Builtins`.

### Aggregate Program Execution
The execution of an aggregate program uses a `VM`, which is updated through `rounds` of field calculus execution.

### Field Calculus Execution
The concept of field calculus execution corresponds to a function from the local device `Context` to an `Export` that contains information regarding the execution of the aggregate program. 
The execution is carried over in rounds by repeatedly updating the local context, calling the `round` function and producing the local export that, alongside the neighboring exports will form the context for the next round of computation. Here's the signature of the round function:

```scala
def round(c: Context, e: => Any = main()): Export
```
This function takes the starting local context and the aggregate program to produce the export. Inside the `FieldCalculusExecution` trait, we also define a main function, that can be overridden, where the aggregate program's code can be written.

### VMstatus
VMStatus models the status of the virtual machine used for the evaluation of the constructs. It acts like a stack, containing the `Path` of the computation, the `index` of the current `Slot` and the id of the current `neighbor`. 

### RoundVM
RoundVM evaluates the aggregate program at each local computation in a device. When done, it shares its exports with the neighbors to be aligned with each other.

This module works with `Context` and `Export` modules.

### Context
Context models the context of local computation,
meaning that it has the ID of the device,
all the exports available to it and various functions to get neighboring values.

### Export, Path and Slot
Export is a data structure that contains the information needed for coordination with the neighbors.
The values that are contained inside the Export are `Paths`, working like a stack, that is a list of `Slots` representing a path in a tree (the Export tree-like data structure).

A `Slot` is the most nested component of this structure.
A `Slot` can represent primitives like `nbr`, `rep`, `foldhood` and `branch`.
It also has methods to create paths and associate values with them.

## Rufi-core
The design of the `Rufi-core` project resembles the one adopted in the `Scafi-core` module.
However,
the differences between the Rust language and Scala lead to some notable design differences that are here discussed.
Please note
that these differences have arisen from the limitations that the Rust compiler imposes on the developer
and will be discussed in detail in the [Implementation](../implementation/implementation-issues.md) Issues](../implementation/implementation-issues.md) section.

### Language
The `Language` trait is now a simple rust module that contains the core language constructs such as Rep, Nbr, Foldhood and Branch.

```rust
pub mod lang {
    pub fn rep<A>(...)
    pub fn nbr<A>(...)
    pub fn foldhood<A>(...)
    pub fn branch<A>(...)
}
```

However, these functions have some differences between the Scala counterparts, mainly they take a `RoundVM` as a parameter and return a tuple (RoundVM, A) instead of a simple A value.
For example, here's the nbr function signature:

```rust
pub fn nbr<A: Copy + 'static>(mut vm: RoundVM, expr: impl Fn(RoundVM) -> (RoundVM,A)) -> (RoundVM, A) 
```

### Execution 
The execution is still based on `RoundVM` and the `round` function: 

```rust
fn round<A, P>(vm: RoundVM, program: P) -> (RoundVM, A)
where 
    P: Fn(RoundVM) -> (RoundVM, A) 
```

However, we can see that Context and Export are now substituted by a RoundVM. Also, the export's root value is returned in a tuple alongside the resulting RoundVM.

### RoundVM
Due to other language limitations to this application,
the `nest` function from `Scafi-core` has been divided into `nest-in`,
`nest-write` and `nest-out` functions.

```rust
/// Pushes the slot in the current Path.
pub fn nest_in(slot: Slot)
```
```rust
/// Checks if the value needs to be written inside the Export and returns it.
 pub fn nest_write<A>(write: bool, value: A) -> A
```
```rust
/// Checks if the status' index needs to be increased, then pops the current status.
 pub fn nest_out(inc: bool)
```

Here is an example of how a language construct is implemented using these functions:

```rust
pub fn nbr<A>(vm: RoundVM, expr: F) -> (RoundVM, A) {
    vm.nest_in(Nbr(...));
    let (vm_, nbr_val) = ... // nbr's logic that also uses expr
    let result = vm_.nest_write(nbr_val, ...);
    vm_.nest_out(...);
    (vm_, result)
}
```

Also, the `locally` function has been taken outside the RoundVM's associate functions and is now a private function that is used inside the constructs in the `lang` module. Here is the updated _locally_ signature:

```rust
fn locally<A, F>(mut vm: RoundVM, expr: F) -> (RoundVM, A)
where
    F: Fn(RoundVM) -> (RoundVM, A)
```

## Integration layer between RuFi-core and ScaFi-core

Two possible options have been identified for the detailed design of the integration layer between RuFi-core and ScaFi-core:

- Wrap the APIs exposed by the original core written in Rust.
- Rewrite a version of RuFi-core fully interoperable with C.

In any case, the APIs exposed in C are bound to Scala.

In the first solution, we have a layer that wraps the Round VM APIs and makes them compatible with C.
The exposed C APIs are bound in Scala, in this way ScaFi-core can use the Rust implementation in a completely transparent way.

<div align="center"> 
    <img src="/assets/images/integration-layer-wrapper.png">
</div>

The second solution is to rewrite a version of RuFi-core entirely compatible with C.
This option is chosen in case it is not possible to implement the first one, it also involves the partial replication of the RuFi-core code.

<div align="center"> 
    <img src="/assets/images/integration-layer-interoperable.png">
</div>

## Scafi-fields
The `Scafi-fields` module contains a library to enable the use of reified fields inside aggregate programs. 
Its main purpose is to enable explicit manipulation of fields through the use of language constructs, monadic operations and comprehensions.

A field maps devices to values of a generic type, if a device is not in the map, a default value is used. Here's a simple representation of a Field of A's:

```scala
case class Field[A](getMap: Map[Int, A], default: A)
```

The Field is meant to represent the local knowledge of the device about the neighboring values,
much like the Context data structure.


### Fields
The `Fields` trait defines the concept of `Field`, alongside some useful functions and factories. It also includes the instance of `cats`'`Monad` type class for Field, to enable special syntax and manipulation inside for-comprehensions. 
This trait can be mixed with other traits to enable field manipulation inside functions as we do inside the `FieldLanguage` trait.

### Field Language
This trait defines the core language constructs for the Field Calculus with reified fields. 
These constructs are the same as the regular `ScaFi-core` ones, but they differ in that they also use fields as values.

### Field Language Execution
The 'fields' extension of `ScaFi-core` is meant as a simple extension of the syntax and functionalities that are available inside a regular aggregate program. 
This means that the core execution architecture is the one defined inside the core module of ScaFi. To enable the execution of an aggregate program with reified fields, the FieldLanguageProgram trait has been introduced:

```scala
trait FieldLanguageProgram extends AggregateProgram with FieldLanguageImpl
```
