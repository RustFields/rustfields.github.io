---
title: Ubiquitous Language
parent: Domain Analysis
has_children: false
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
        <td>Specification for a collective behaviour that needs to be achieved.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Computational Field</td>
        <td>A field is a collective structure that maps each device in some portion of the network to locally computed values over time.</td>
        <td>Field Calculus</td>
    </tr>
    <tr>
        <td>Field Calculus</td>
        <td>A programming model in which computational fields are first-class entities.</td>
        <td>Computational Field</td>
    </tr>
    <tr>
        <td>VM</td>
        <td>A Virtual Machine for the execution of an aggregate program.</td>
        <td>Aggregate Program, Round</td>
    </tr>
    <tr>
        <td>Round</td>
        <td>Correspond to a local computation in a device. Create the context, evaluate the aggregate program and share the exports to the neighbourhood.</td>
        <td>VM</td>
    </tr>
    <tr>
        <td>Environment</td>
        <td>An abstraction for the real world.</td>
        <td>Sensor, Context</td>
    </tr>
    <tr>
        <td>Context</td>
        <td>An abstraction for the local computation's input. It contains the neighbours' exports, the local status of the device and the results of the previous round.</td>
        <td>Export</td>
    </tr>
    <tr>
        <td>Export</td>
        <td>A tree-like data structure that contains all the information needed for coordinating with neighbours and the output of the computation.</td>
        <td>AST</td>
    </tr>
    <tr>
        <td>Network</td>
        <td>A network of heterogeneous devices that act as a collective.</td>
        <td>Device</td>
    </tr>
    <tr>
        <td>Device</td>
        <td>A singular entity that executes the aggregate program. Also called: nodes or agents.</td>
        <td>Neighbour</td>
    </tr>
    <tr>
        <td>Neighboring</td>
        <td>A relation between devices that communicate directly.</td>
        <td>Device</td>
    </tr>
    <tr>
        <td>Sensor</td>
        <td>A physical or virtual component that allows the device to interact with the environment.</td>
        <td>Environment, Sense</td>
    </tr>
    <tr>
        <td>Abstract Syntax Tree</td>
        <td>A data-oriented representation used by ScaFi to represent the aggregate program structure.</td>
        <td>Path, Slot</td>
    </tr>
    <tr>
        <td>Path</td>
        <td>Sequence of slots, corresponding to a branch of the AST.</td>
        <td>Abstract Syntax Tree, Slot</td>
    </tr>
    <tr>
        <td>Slot</td>
        <td>A representation for a construct of the language.</td>
        <td>Path</td>
    </tr>
    <tr>
        <td>Language</td>
        <td>The collection of basic constructs.</td>
        <td>Nbr, Rep, Foldhood, Branch, Exchange</td>
    </tr>
    <tr>
        <td>Nbr</td>
        <td>It observes the value of an expression across neighbours, producing a “field of fields”.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Rep</td>
        <td>It iteratively updates the value of the input expression at each device using the last computed value.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Foldhood</td>
        <td>Aggregates the results of the neighbour computation.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Branch</td>
        <td>Partition the domain into two subspaces that do not interact with each other.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Alignment</td>
        <td>Two devices are said to be aligned if they have evaluated the same expression and belong to the same domain.</td>
    </tr>
    <tr>
        <td>Local ID</td>
        <td>It is the ID of the local device.</td>
        <td>Device, Language</td>
    </tr>
    <tr>
        <td>Sense</td>
        <td>Return the value of a local sensor.</td>
        <td>Sensor, Device</td>
    </tr>
    <tr>
        <td>Exchange</td>
        <td>The exchange construct handles neighbour-to-neighbour propagation of partial accumulates.
        <!--TODO exchange pensa che non si possa implementare se non reifichiamo i fields || OPERAZIONCINA spazio temporale dove tu puoi manipolare la patch di spazio tempo - ANISOTROPICO --></td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Share</td>
        <td>captures the space-time nature of field computation through observation of neighbours’ values, reduction to a single local value and updating and sharing to neighbours of a local variable</td>
        <td></td>
    </tr>
</table>
