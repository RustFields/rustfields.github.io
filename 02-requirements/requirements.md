---
layout: default
title: Requirements Breakdown Structure
nav_order: 1
parent: Requirements
---

# Requirements Breakdown Structure

## Native field calculus core

1. Implement field calculus syntax in Scala:
    1. Rep
    2. Nbr
    3. Foldhood
    4. Branch
    5. Exchange
2. Implement the AST of the aggregate program:
   1. Slot
   2. Path
3. Implement Context
4. Implement Export
5. Implement the Round VM

## Integration layer between the native core and Scala

1. Implement a Scala wrapper for the basic constructs defined in the native library

## ScaFi with Scala 3

1. Implement field calculus API
   1. Language
   2. Builtins
2. Implement field calculus syntax in Scala:
    1. Rep
    2. Nbr
    3. Foldhood
    4. Branch
    5. Exchange
3. Implement the AST of the aggregate program:
   1. Slot
   2. Path
4. Implement Context
5. Implement Export
6. Implement the Round VM
7. Enable the use of fields as a primary-level entity

## Standardize message format

1. Define standard message structure
2. Propose a message-passing framework that is platform agnostic