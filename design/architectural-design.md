---
title: Architectural design
parent: Design
has_children: false
nav_order: 1
---
# Architectural design

One of the project's main goals is to enable aggregate programming on thin devices. This must be taken into account when choosing the architecture.

This goal can be achieved in two ways:
1. Create a DSL for creating aggregate programs in a natively compiled language, like Rust.
2. Allow the programmer to write aggregate programs in a hihg level language like Scala while keeping the execution of the program itself native, away from the JVM.

Since the project was meant as an exploration of different options for bringing aggregate programming into native contexts, we decided to explore both the solutions. The resulting architecture reflects this choice: in fact, we decided to develop a standalone aggregate programming framework in the Rust language, while also experimenting different ways to integrate it with the Scala ScaFi's ecosystem.

<div align="center"> 
    <img src="/assets/images/full-architecture.png"> 
</div>

The main issue here is to decide where to draw a line between Rust and Scala.
The team decided that a good point of separation is the Round VM, so every time a Round VM method is called, it won't be a standard call but Scala will make use of the Rust implementation of the method.

The detailed architecture of each sub-project will be explained in detail in the next sections.

## ScaFi-core

The current ScaFi architecture is the following:

<div align="center"> 
    <img src="/assets/images/scafi-architecture.png"> 
</div>

Our project focuses on the ScaFi core.
The core architecture is the following:

<div align="center"> 
    <img src="/assets/images/scafi-core-architecture.png"> 
</div>

The lang package contains the Scala DSL for aggregate programming.
The VM package contains the execution engine of the aggregate program.

## RuFi-core

Regarding the architecture of RuFi-core, it was decided to stick as much as possible to the original architecture of ScaFi-core.
The RuFi-core architecture is the following:

<div align="center"> 
    <img src="/assets/images/rufi-core-architecture.png">
</div>

## Integration layer between RuFi-core and ScaFi-core

As regards the integration of the RuFi-core RoundVM in ScaFi-core, it was decided to use an additional layer, written in C, which allows to perform the binding of the APIs exposed in Rust.

<div align="center"> 
    <img src="/assets/images/integration-layer.png">
</div>

## ScaFi-fields

ScaFi fields is a standalone repository that contains a library to enable the use of reified fields in ScaFi.
The library is written in Scala 3 and it is meant to be used in the ScaFi core.
This is the architecture of the library:

<div align="center"> 
    <img src="/assets/images/fields.png"> 
</div>
