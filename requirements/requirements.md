---
title: Requirements breakdown structure
parent: Requirements 
has_children: false
nav_order: 1
---

# Requirements Breakdown Structure

## Native field calculus core in Rust

1. Implement field calculus syntax in Rust:
    1. Rep
    2. Nbr
    3. Foldhood
    4. Branch
2. Implement the AST of the aggregate program:
   1. Slot
   2. Path
3. Implement Context
4. Implement Export
5. Implement the Round VM

## Integration layer between the native core and Scala

1. Implement a Scala wrapper for the basic constructs defined in the native library

## ScaFi with Scala 3

1. Implement a Scafi-core version in Scala 3
2. Implement a library that allows the use of reified fields
