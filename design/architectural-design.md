---
title: Architectural design
parent: Design
has_children: false
nav_order: 1
---
# Architectural design

## ScaFi architecture

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

## Rust architecture

The Rust version architecture is...

## ScaFi Fields

ScaFi fields is a standalone repository that contains a library to enable the use of reified fields in ScaFi.
The library is written in Scala 3 and it is meant to be used in the ScaFi core.
This is the architecture of the library:

<div align="center"> 
    <img src="/assets/images/fields.png"> 
</div>