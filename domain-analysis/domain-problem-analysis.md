# Domain Problem Analysis

1. **What is ScaFi?**

> ScaFi is a Scala-based library and framework for Aggregate Programming. 
> It implements a variant of the Higher-Order Field Calculus (HOFC) operational semantics.

2. **What is the current ScaFi architecture?**

> From a deployment perspective, ScaFi consists of different modules:
> - scafi-core: represents the core of the project and provides an implementation of the ScaFi aggregate programming DSL, together with its standard library.
> - scafi-commons: provides basic entities (e.g., spatial and temporal abstractions).
> - scafi-simulator: provides basic support for simulating aggregate systems.
> - spala: provides an actor-based aggregate computing middleware.
> - scafi-distributed: ScaFi integration-layer for spala.

3. **What are the aspects of ScaFi that needs to be improved?**
> The first problem is that currently ScaFi is written in Scala 2: with the release of Scala 3 we want to adapt Scafi to the newest version of Scala.
>
> The second problem is about the platform: ScaFi is meant to run on different types of devices, from the bigger ones to the thin device, such as an Arduino. ScaFi needs a JVM to be executed, but those devices don't have the resources to launch a JVM. So we want a ScaFi version which is platform indipendent.

4. **Regarding the 'thin' device problem, do you have in mind a possible solution?**
> We heard about Rust, a relatively new programming language that is becoming very popular. The main goal of Rust is to ensure that the memory is correctly managed, so that the program doesn't waste resources during its execution. 
> This is why we think Rust can be a good choice.

5. **Which ScaFi component has to be written in Rust, and which in Scala 3?**
> The final goal is to write the aggregate program in Scala 3 but its execution at the lowest level should be Rust native. Where the line between Scala and Rust is drawn is your choice.
> We don't expect you to fully reach this goal, but to explore solutions in this direction.

6. **Should we start by implementing Aggregate Computing in Rust?**
> My advice is to start from the minimal part of the ScaFi core: the VM. Write this VM in Rust and then, split the team in two group. One group will approach the problem top-down and the other bottom-up. At one point you eventually converge (hopefully) and this is where you draw the line.
> By top-down I mean writing in Scala 3 the high level API.
> Buttom-up i mean extending the minimal core by adding other components in Rust.

7. **Is the ScaFi core tested?**
> Yes, there are some tests. However if you can expand this test suit during this work, we will be pleased.