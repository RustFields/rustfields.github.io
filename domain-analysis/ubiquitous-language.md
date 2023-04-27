---
layout: default
title: Ubiquitous Language
parent: Domain Analysis
nav_order: 3
---
# Ubiquitous Language

<table>
    <tr>
        <th>Term</th>
        <th>Description</th>
        <th>Association</th>
    </tr>
    <tr>
        <td>Aggregate Program</td>
        <td>Specification for a collective behavior that need to be achieved.</td>
        <td>Collective Adaptive System</td>
    </tr>
    <tr>
        <td>VM</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>*Collective Adaptive System</td>
        <td>A large number of heterogeneous entities that act as a collective.</td>
        <td></td>
    </tr>
    <tr>
        <td>Device</td>
        <td>A singular entity that executes the aggregate program. Also called: nodes, agents and robots.</td>
        <td></td>
    </tr>
    <tr>
        <td>Neighbour</td>
        <td>A relation between devices that communicate directly.</td>
        <td></td>
    </tr>
    <tr>
        <td>Computational Field</td>
        <td>A field is a collective structure that maps each device in some portion of the network to locally computed values over time.</td>
        <td></td>
    </tr>
    <tr>
        <td>Field Calculus</td>
        <td>A programming model in which computational fields are first-class entity.</td>
        <td></td>
    </tr>
    <tr>
        <td>Sensor TODO</td>
        <td>Piece of hardware that serves as a sensor for the device. It expresses the capabilities of the device in terms of interactions with the real world.</td>
        <td></td>
    </tr>
    <tr>
        <td>Environment</td>
        <td>An abstraction for the real world.</td>
        <td></td>
    </tr>
    <tr>
        <td>Export</td>
        <td>Abstraction for the result of local computation. TODO è un ast decorato con il valore della computazione</td>
        <td></td>
    </tr>
    <tr>
        <td>Path</td>
        <td>Sequence of slots, corresponding to a branch of the AST.</td>
        <td>Abstract Syntax Tree</td>
    </tr>
    <tr>
        <td>Slot</td>
        <td>A representation for a construct of the language that forms an execution path.</td>
        <td></td>
    </tr>
    <tr>
        <td>Abstract Syntax Tree</td>
        <td>A data-oriented representation of the aggregate program structure.</td>
        <td>Path</td>
    </tr>
    <tr>
        <td>Context</td>
        <td>An abstraction for the local computation's input. It contains the neighbors' exports,  and the local status of the device.</td>
        <td></td>
    </tr>
    <tr>
        <td>Syntax</td>
        <td>The collection of basic constructs that are included in the language.</td>
        <td></td>
    </tr>
    <tr>
        <td>Nbr</td>
        <td>It observes the value of an expression across neighbors, producing a “field of fields”.</td>
        <td></td>
    </tr>
    <tr>
        <td>Rep</td>
        <td>It iteratively updates the value of the input expression at each device using the last computed value.</td>
        <td></td>
    </tr>
    <tr>
        <td>Foldhood</td>
        <td>Aggregates the results of the neighbor computation.</td>
    <td></td>
    </tr>
    <tr>
        <td>Branch</td>
        <td>It is like the if statement.</td>
    <td></td>
    </tr>
    <tr>
        <td>Mid</td>
        <td>It is the ID of the local device.</td>
        <td></td>
    </tr>
    <tr>
        <td>Sense</td>
        <td>Return the value of a local sensor.</td>
        <td></td>
    </tr>
    <tr>
        <td>Exchange TODO</td>
        <td>The exchange construct handles neighbour-to-neighbour propagation of partial accumulates.</td>
        <td></td>
    </tr>
    <tr>
        <td>Round</td>
        <td>Correspond to a local computation in a device. Create the context, evaluate the aggregate program and share the exports to the neighborhood.</td>
        <td></td>
    </tr>
</table>

