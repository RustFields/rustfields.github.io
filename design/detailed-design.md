---
title: Detailed design
parent: Design
has_children: false
nav_order: 2
---
# Detailed design
In this section, we will show the most critical design choices made that lead to the realization of the framework as it currently is.

## Scafi-core

### Language

It is all based on the `Language` trait, composed by the main constructs, that are the followings.

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
#### Mid
Mid is a built-in sensor providing the identifier of devices;

```scala
def mid(): Int
```

#### Foldhood 
Foldhood supports neighborhood data aggregation, through a standard “fold” of functional programming with initial value `init`, aggregation function `aggr`, and the set of values to fold over obtained by evaluating `expr` against all neighbors;

```scala
def foldhood[A](init: => A)(aggr: (A, A) => A)(expr: => A): A
```

#### Branch
Which partitions the domain into two subspaces that do not interact with each other.
```scala
def branch[A](cond: => Boolean)(thn: => A)(els: => A): A
```

#### Sense
Sense obtains the value of a local sensor.

```scala
def sense[A](name: Sensor): A
```
#### NbrVar
NbrVar obtains the value of the neighbor's sensor.

```scala
def nbrVar[A](name: Sensor): A
```
By combining these constructs, higher-level functions can be defined to capture increasingly complex collective behavior.

<!--Those constructs are used within the Field Calculus to create and execute an Aggregate Program.-->   

## Aggregate Program
The execution of an aggregate program uses the `VM`, which is updated through `rounds` of the field calculus.

The field calculus takes advantage of `Builtins` that extends the Language structure with additional mechanisms. 

### Builtins
Builtins are made to simplify some repetitive mechanisms that could take to errors.

Here are some examples of builtins implemented:

```scala
def mux[A](cond: Boolean)(th: A)(el: A): A
```
Mux evaluates the condition given and returns `th` if the condition is satisfied, `el` otherwise.

```scala
def maxHood[A](expr: => A)(using of: Bounded[A]): A
```
MaxHood applies a `foldhood` to the bottom value of the bound given, with the aggregation function that is the max between two given values and the expression passed as input.

### VMstatus
VMStatus models the status of the virtual machine used for the evaluation of the constructs. It acts like a stack.

For example, it is composed by a `Path` of the computation, the `index` of the current `Slot`, the id of the current `neighbor` and other functions pertinent to the constructs of the language. 

### RoundVM
RoundVM evaluates the aggregate program at each local computation in a device. When done, it shares its exports to the neighbors in order to be aligned with each others.

This module works with `Context` and `Export` modules.

### Context
Context models the context of a device,
meaning that it has the ID of the device,
all the exports available to it and various functions to get values of the neighbors.

### Export - Path - Slot
Export is a data structure that contains the information needed for the coordination with the neighbors.
The values that are contained inside the Export are `Paths`, working like a stack, that are a list of `Slots` representing a path in a tree (the Export tree-like data structure).

A `Slot` is the most nested component of this structure.
A `Slot` can represent primitives like `nbr`, `rep`, `foldhood` and `branch`.
It also has methods to create paths and associate values to them.

## Rufi-core
For what concerns the module of `Rufi-core`, the main execution operates in the same way as the `Scafi-core` module. However, there are few differences between them, starting from the language.

### Language
As a result of a meticulous analysis,
the `Language` is now composed by fewer constructs with the same meaning as in `Scafi-core`,
which are the followings.

#### Nbr

```rust
pub fn nbr<A: Copy + 'static>(mut vm: RoundVM, expr: impl Fn(RoundVM) -> (RoundVM,A)) -> (RoundVM, A) 
```

#### Rep

```rust
pub fn rep<A: Copy + 'static>(mut vm: RoundVM, init: impl Fn() -> A, fun: impl Fn(RoundVM, A) -> (RoundVM, A)) -> (RoundVM, A)
```

#### Foldhood

```rust
pub fn foldhood<A: Copy + 'static>(mut vm: RoundVM, init: impl Fn() -> A, aggr: impl Fn(A, A) -> A, expr: impl Fn(RoundVM) -> (RoundVM, A)) -> (RoundVM, A)
```

#### Branch

```rust
pub fn branch<A: Copy + 'static>(mut vm: RoundVM, cond: impl Fn() -> bool, thn: impl Fn(RoundVM) -> (RoundVM, A), els: impl Fn(RoundVM) -> (RoundVM, A)) -> (RoundVM, A)
```


As you can see, the main concept is the same, the differences are of course the not very idiomatic syntax, and that every function needs to take the `RoundVM` as a mutable parameter and as a consequence, the functions must pass also the `RoundVM` status back to the caller.
This happens because of some limitations in Rust's variable borrowing which will be discussed later inside the [Implementation Issues](../implementation/implementation-issues.md) section.

As a language limitation to our application,
it must be specified also the `Copy` trait and the `'static` lifetime to our generic parameter,
that will be explained inside the [Implementation Details](../implementation/implementation-details.md) section..

Our analysis has resulted in moving some constructs that were in the `Language` trait of `Scafi-core` somewhere else. 

//TODO FORSE HO SBAGLIATO
For example, the `mid` function now has its own module named `SensorId` or the `sense` function that has not been implemented.

## Execution 
The execution is still based on rounds of `RoundVM` and the consequent structure and modules are the same as in `Scafi-core`.

## RoundVM

Due to other language limitations to this application,
the `nest` function from `Scafi-core` has been divided in `nest-in`,
`nest-write` and `nest-out`, for the reason of the borrowing limitations.

## Scafi-fields

The `Scafi-fields` module contains a library to enable the use of reified fields in the `Scafi-core`. 
Note that reified fields have only been implemented in Scala and not in Rust, so they cannot be used yet in `Rufi-core` applications.

The constructs with reified fields are noted with an `f` appended to the name of the construct, their signature also might be different, 
because most of the time it is returned a Field or passed it as parameter. 

Field calculus uses `Fields` trait with `FieldOps` that are operations applied to Fields.

### Fields

A field is a map from device ids to values of a generic type, if a device is not in the map, the default value is used.

Some methods that use or create Fields are the following:

```scala
//Create a Field with a single value for the current device.
def fromSelfValue[A](a: A): Field[A] 
```

```scala
//Dynamically creates a Field from a provided expression.
def fromExpression[A](default: => A)(expr: => A): Field[A]
```

### Language

`FieldLanguage` implements said constructs with the logic of reified fields.

## Rufi-core-wrapper

## Tests
As scala's standard on testing, there is a package in every scala project that contains unit tests and test with the functions applied as a simulation.

The scala standard is a bit different from the rust's one.

Rust's standard is to have unit test inside the module in which functions are implemented and the others in a specific crate.  

The rust standard makes unit test easier to understand because of the relative implementation right above; 
on the other hand, the module results to be less readable.
