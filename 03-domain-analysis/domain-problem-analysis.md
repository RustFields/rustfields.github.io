---
title: Domain Problem Analysis
parent: Domain Analysis
has_children: false
nav_order: 2
---


# Domain Problem Analysis
<!-- TODO: check if this is correct -->

Aggregate programming is actually only used by devices capable of running a JVM.
However, the goal of this project is to make the field calculus available also for thin devices that lack the resources to run a JVM, such as Arduino.

Given this goal, we are committed to exploring different solutions to bring aggregate programming to thin devices.
There are various frameworks used for this purpose, such as Protelis and ScaFi.

After a brief analysis of the two frameworks, we decided to focus on ScaFi because it is more mature and actively maintained.

# Knowledge crunching

**What is ScaFi?**

> ScaFi is a Scala-based library and framework for Aggregate Programming. 
> It implements a variant of the Higher-Order Field Calculus (HOFC) operational semantics.

**What is the current ScaFi architecture?**

> From a deployment perspective, ScaFi consists of different modules:
>
> - scafi-core: represents the core of the project and provides an implementation of the ScaFi aggregate programming DSL, together with its standard library.
> - scafi-commons: provides basic entities (e.g., spatial and temporal abstractions).
> - scafi-simulator: provides basic support for simulating aggregate systems.
> - spala: provides an actor-based aggregate computing middleware.
> - scafi-distributed: ScaFi integration-layer for spala.

**What aspects of ScaFi need to be improved?**

> The first problem is that currently ScaFi is written in Scala 2. With the release of Scala 3 we want to adapt Scafi to the newest version of Scala.
>
> The second problem is about the platform: ScaFi is meant to run on different types of devices, from the bigger ones to the thin device, such as an Arduino. ScaFi requires a JVM to be executed, but those devices don't have the resources to launch a JVM. So we want a ScaFi version which is platform-independent.

**Regarding the 'thin' device problem, do you have in mind a possible solution?**

> We have heard about Rust, a relatively new programming language that is becoming very popular. The main goal of Rust is to ensure that the memory is correctly managed, so that the program doesn't waste resources during its execution. 
> This is why we think Rust can be a good choice.

**Which ScaFi component has to be written in Rust, and which in Scala 3?**

> The final goal is to write the aggregate program in Scala 3 but its execution at the lowest level should be Rust native. Where the line between Scala and Rust is drawn is your choice.
> We don't expect you to fully reach this goal, but to explore solutions in this direction.

**Should we start by implementing Aggregate Computing in Rust?**

> My advice is to start from the minimal part of the ScaFi core: the VM. Write this VM in Rust and then, split the team in two group. One group will approach the problem top-down and the other bottom-up. At one point you eventually converge (hopefully) and this is where you draw the line.
> By top-down I mean writing in Scala 3 the high level API.
> By bottom-up I mean extending the minimal core by adding other components in Rust.

**Is the ScaFi core tested?**

> Yes, there are some tests. However, if you can expand this test suit during this work, we will be pleased.

**What can a user do with our software?**

> The typical user of our application is a developer. He should be able to define an Aggregate Program using the default constructs of our language. This program should be run by what we call a RoundVM: a virtual machine that simulate the computation in each device.
> He could also define other things like the device network, but this is outside your project's scope.

**What are the default constructs of our language?**

> There are different contructs that can be used.
> You can use the language currently used by ScaFi, or adopt a new construct like Exchange.
> The choice is yours.

## Project Goals
From the interview with the stakeholders the following goal has been identified:
- Enable aggregate programming on a distributed network of heterogeneous devices.

This main goal, is divided in different sub-goals:
- Create a ScaFi version that can run native, without needing a JVM.
- <!--TODO perchè non usiamo scala native? per com'è scritto non c'è ragione di usare rust, trovare una spiegazione che possa essere sia quella dei thin device o altro-->
- Update ScaFi to the latest version of Scala.
- Create an integration layer that allow a Scala aggregate program to be run using a native core.
- Find a standard message format to allow the communication between distributed heterogeneous devices.