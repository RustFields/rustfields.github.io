---
layout: default
title: Business Domain
parent: Domain Analysis
nav_order: 1
permalink: /domain-analysis/business-domain
---

# Business Domain

## Computational Fields & Field Calculus
A **Computational Field** is a function mapping a set of devices distributed over a network to a structured value. Such fields are aggregate-level distributed data structures which, due to the ongoing feedback loops that produce and maintain them, are generally robust to changes in the underlying topology (e.g., due to faults, mobility, or openness) and to unexpected interactions with the external environment. They are thus useful for implementing and composing self-organising coordination patterns to adaptively regulate the behaviour of complex distributed systems.

**Field Calculus** is a minimal core calculus meant to precisely capture a set of key in-
gredients of programming languages supporting the creation of computational fields: composition of fields, functions over fields, evolution of fields over time, construction of fields of values from neighbours, and restriction of a field computation to a sub-region of the network.

## Aggregate Programming

**Collective Adaptive Systems** refer to a form of complex systems where a large number of heterogeneous entities interact without specific external or internal central control, adapt their behaviour to environmental settings in pursuit of an individual or collective goal. Actual behaviour arises as an emergent property through swarm or collective intelligence.
Examples of CAS are drone swarms, ant colonies, economic markets and many others.

**Aggregate Programming** is a paradigm for the development of collective adaptive systems (CAS). It provides a compositional, functional programming model for expressing the self-organising behaviour of a CAS from a global perspective.

**Aggregate Computing** (AC) is formally grounded in the field calculus (FC), a minimal core language that captures the key mechanisms for bridging local and global behaviour. FC is based on the notion of a (computational) field, a (possibly dynamic) map from a (possibly dynamic) domain of devices to computational values.

Aggregate Computing is based on a logical model that can be mapped diversely onto physical infrastructure.

* From a structural point of view, an aggregate system is merely a graph or network of devices (also called: nodes, agents, robots). The edges connecting nodes represent logical communication channels that are set up by the aggregate computing platform according to an application-specific neighbouring relationship (which, for situated systems, is typically a communication range).
* From a behavioural point of view, any device “continuously” interprets the aggregate program against its local context.
* From an interactional point of view, any device continuously interacts with its neighbours to acquire and propagate context. This is what enables local activity to influence global activity and vice versa.

## Execution model

In practice, devices sustain the aggregate computation through asynchronous sense-compute-(inter)act rounds which conceptually consist of the following steps:

1. **Context update**: the device retrieves previous state, environment data (through sensors), and messages from neighbours.
2. **Aggregate program execution**: the field computation is executed against the local context; this yields an output.
3. **Action**
    1. **Export broadcasting to neighbours**: from the output, a subset of data (called an export) for neighbour coordination can be automatically derived; the export has to be broadcast to the entire neighbourhood.
    2. **Execution of actuators**: the output of the program can describe a set of actuations to be performed on the environment.

## Programming Model

Aggregate computing is a macro-programming paradigm where a single program (called the aggregate program) defines the overall behaviour of a network of devices or agents.

The aggregate program does not explicitly refer to the execution model discussed in the previous section, i.e., it somewhat abstracts from it (though in some cases it may assume that the execution model has certain characteristics). Instead, it expresses how input fields maps to output fields: for instance, how a field of temperature sensor readings maps to a field of warnings; or, as another example, how a field of service requests and resource advertisements map to a field of task allocations.