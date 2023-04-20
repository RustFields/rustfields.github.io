# Ubiquitous Language

<table>
    <tr>
        <th>Term</th>
        <th>Description</th>
        <th>Association</th>
    </tr>
    <tr>
        <td>Aggregate Program</td>
        <td>Specification for a collective behaviour that need to be achieved by the CAS</td>
        <td>Collective Adaptive System</td>
    </tr>
    <tr>
        <td>Collective Adaptive System</td>
        <td>A large number of heterogeneous entities that act as a collective.</td>
        <td></td>
    </tr>
    <tr>
        <td>Device</td>
        <td>A singular entity of the CAS. Also called: nodes, agents, robots.</td>
        <td></td>
    </tr>
    <tr>
        <td>Neighbour</td>
        <td>A relation between devices which communicate directly.</td>
        <td></td>
    </tr>
    <tr>
        <td>Computational Field</td>
        <td>A field is a collective structure that maps each device in some portion of the network to locally computed values over time. Also called: nvalue.</td>
        <td></td>
    </tr>
    <tr>
        <td>Field Calculus</td>
        <td>A mathematical model in which nvalues are first class entity.</td>
        <td></td>
    </tr>
    <tr>
        <td>Sensor</td>
        <td>Piece of hardware that serves as a sensor or actuator for the device. It expresses the capabilities of the device in terms of interactions with the real world.</td>
        <td></td>
    </tr>
    <tr>
        <td>Environment</td>
        <td>An abstraction for the real world, in which the CAS is.</td>
        <td></td>
    </tr>
    <tr>
        <td>Export</td>
        <td>Abstraction for the result of a local computation.</td>
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
        <td>A data oriented representation of the aggregate program structure.</td>
        <td>Path</td>
    </tr>
    <tr>
        <td>Context</td>
        <td>An abstraction for the local computation's input. It contains the result of the last collective computation and the local status of the device.</td>
        <td></td>
    </tr>
    <tr>
        <td>Syntax</td>
        <td>The collection of basic constructs that are included in the language.</td>
        <td></td>
    </tr>
    <tr>
        <td>Nbr</td>
        <td>It observes the value of an expression across neighbours, producing a “field of fields”.</td>
        <td></td>
    </tr>
    <tr>
        <td>Rep</td>
        <td>It iteratively updates the value of the input expression at each device with the minimum available at any neighbour.</td>
        <td></td>
    </tr>
    <tr>
        <td>Exchange</td>
        <td>The exchange construct handles neighbour-to-neighbour propagation of partial accumulates.</td>
        <td></td>
    </tr>
    <tr>
        <td>Round</td>
        <td>Corresponds to a local computation in a device.</td>
        <td></td>
    </tr>
</table>

