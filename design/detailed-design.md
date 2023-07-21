---
title: Detailed design
parent: Design
has_children: false
nav_order: 2
---
# Detailed design

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
Which partitions the domain into two subspaces that do not interact with each others.
```scala
def branch[A](cond: => Boolean)(thn: => A)(els: => A): A
```

#### Sense
Sence obtains the value of a local sensor.

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

The field calculus take advantage of `Builtins` that extends the Language structure with additional mechanisms. 

### Builtins
Builtins are made to simplify some repetitive mechanisms that could take to errors.

Here are some example of builtins implemented:

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

## Rufi-core

## Scafi-fields

## Rufi-core-wrapper