---
title: Use cases
parent: Requirements 
has_children: false
nav_order: 2
---

# Use Cases

In the past, computing devices were mostly used by individuals. However, as the number of computing devices has increased and more of them have become embedded in our environment, it is now common for many devices to be involved in the provision of a single service. For example, a traffic management system might use a network of sensors, cameras, and other devices to track traffic and optimize routes.

This trend toward collective computing has led to several challenges for programmers. Traditional programming approaches focus on individual devices, which makes it difficult to manage the interactions between multiple devices. This can lead to problems such as inefficient communication, unreliable coordination, and difficult-to-debug behavior.

Aggregate programming is an emerging approach to programming that addresses these challenges. Aggregate programming treats a group of devices as a single unit, which simplifies the design, creation, and maintenance of complex distributed systems. This approach can help to improve the performance, reliability, and scalability of distributed systems.

Here are some of the benefits of aggregate programming:

- It simplifies the design of complex distributed systems by abstracting away the details of individual devices.
- It improves the performance of distributed systems by reducing the amount of communication between devices.
- It makes distributed systems more reliable by providing a single point of failure for each aggregate.
- It makes distributed systems more scalable by allowing aggregates to be easily added or removed.
 
Aggregate programming is still a relatively new approach, but it has the potential to revolutionize the way we build distributed systems. As the number of computing devices continues to grow, aggregate programming will become increasingly important for developing efficient, reliable, and scalable distributed systems.

Here are some examples of use cases where aggregate programming can be useful.

## Distributed Crowd Management

Crowd safety is important at large public events, such as marathons or festivals. One way to improve crowd safety is to use aggregate programming to build a crowd-safety service. This service would use cell phones to estimate crowd density and distribution, alert people in dangerous areas, and provide advice on how to move safely.

Traditionally, crowd-safety services have been built using device-centric approaches. This means that the programmer has to think about how the service will work on each device, as well as how the devices will interact with each other. This can be difficult and error-prone.

Aggregate programming takes a different approach. Instead of thinking about individual devices, aggregate programming thinks about the service as a set of distributed modules. The programmer can then compose these modules to form a complete application by specifying where they should execute and how information should flow between them.

For example, the crowd estimation module could produce a distributed data structure called a "computational field" that maps from location to crowd density. This data structure could then be used by the crowd-aware navigation module and the alerting service.

The details of how the modules interact with each other and how they are implemented can be automatically generated from the composition of data structures and services. This makes it easier to build complex, reusable, resilient, and composable distributed systems.

In short, aggregate programming makes it easier to build crowd-safety services that are more effective and efficient.

