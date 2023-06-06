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
        <td>Language</td>
    </tr>
    <tr>
        <td>Computational Field</td>
        <td>A field is a collective structure that maps each device in some portion of the network to locally computed values over time.</td>
        <td>Field Calculus</td>
    </tr>
    <tr>
        <td>Field Calculus</td>
        <td>A programming model in which computational fields are first-class entity.</td>
        <td>Computational Field</td>
    </tr>
    <tr>
        <td>VM</td>
        <td>A Virtual Machine for the execution of an aggregate program.<!--TODO manca tutta la parte sulla reificazione dei fields, secondo lui non ha alcun senso tenerli impliciti, sintassi carina per scala ma ... --></td>
        <td>Aggregate Program, Round</td>
    </tr>
    <tr>
        <td>Round</td>
        <td>Correspond to a local computation in a device. Create the context, evaluate the aggregate program and share the exports to the neighborhood.</td>
        <td>VM</td>
    </tr>
    <tr>
        <td>Environment</td>
        <td>An abstraction for the real world.</td>
        <td>Sensor, Context</td>
    </tr>
    <tr>
        <td>Context</td>
        <td><!--CHECK - old comment -> this doesn't work a meno che non intendiamo anche i risultati del giro precedente-->An abstraction for the local computation's input. It contains the neighbors' exports, the local status of the device and the results of the previous round.</td>
        <td>Export</td>
    </tr>
    <tr>
        <td>Export</td>
        <td>A tree-like data structure that contains all the information needed for coordinating with neighbors and the output of the computation.</td>
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
        <td><!--TODO ha parlato di variabile d'ambiente e come viene letta???? dev random è un sensore? però interagisce col mondo reale (lmao?) parlare di pezzo di hardware è un po' forte, implica che in un simulatore non ho mai un sensore??? -->
A piece of hardware that allow the device to interact with the environment.</td>
        <td>Environment, Sense</td>
    </tr>
    <tr>
        <td>Abstract Syntax Tree</td>
        <td>A data-oriented representation of the aggregate program structure.
<!--TODO si potrebbero creare delle implementazioni in aggregate computing ma senza AST decorato--></td>
        <td>Path, Slot</td>
    </tr>
    <tr>
        <td>Path</td>
        <td>Sequence of slots, corresponding to a branch of the AST.<!--TODO stack overflow di definizione, o questo o slot dev'essere ground--></td>
        <td>Abstract Syntax Tree, Slot</td>
    </tr>
    <tr>
        <td>Slot</td>
        <td><!--TODO vedi todo di path-->A representation for a construct of the language that forms an execution path.</td>
        <td>Path</td>
    </tr>
    <tr>
        <td>Language</td>
        <td><!--TODO linguaggio è un linguaggio-->The collection of basic constructs that are included in the language.</td>
        <td>Nbr, Rep, Foldhood, Branch, Mid<!--TODO "mid è un sensore se proprio" - è un concetto del device ma non è un costrutto-->, Exchange</td>
    </tr>
    <tr>
        <td>Nbr</td>
        <td>It observes the value of an expression across neighbors, producing a “field of fields”.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Rep</td>
        <td>It iteratively updates the value of the input expression at each device using the last computed value.</td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Foldhood</td>
        <td>Aggregates the results of the neighbor computation.<!--TODO secondo lui è un'invenzione secca di scafi, un modo per estrarre un valore da un field, dentro scafi fa una cosa strana, ovvero un'esecuzione proiettata di ogni cosa che viene messa dentro. --></td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Branch</td>
        <td>Partition the domain into two subspaces that do not interact with each others.</td>
        <td>Language</td>
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
        <td>Exchange TODO</td>
        <td>The exchange construct handles neighbour-to-neighbour propagation of partial accumulates.
        <!--TODO exchange pensa che non si possa implementare se non reifichiamo i fields || OPERAZIONCINA spazio temporale dove tu puoi manipolare la patch di spazio tempo - ANISOTROPICO --></td>
        <td>Language</td>
    </tr>
    <tr>
        <td>Share TODO</td>
        <td>Isotropic</td>
        <td></td>
    </tr>
</table>


<!--TODO non c'è nulla per pilotare gli attuatori, che crede non siano nemmeno modellati in scafi - come scriviamo su un file?-->
<!-- abbiamo qualcosa per raccogliere i side effect? -->
<!-- possiamo usare il concetto di senso-attuatore o dividerli, se abbiamo dei sens-att fa strano che ci siano dei sensori che non fanno attuazione-->
<!-- sicuramente ad un certo punto dovremmo avere qualcosa in grado di estrarre da un field, si potrebbero fare delle funzioni che restituiscono un field. concetto di riuso di funzioni, ereditato da scala-->
<!-- fermiamoci al brancing-->
<!--TODO manca l'allineamento, perchè da branch partizioniamo in 2 sottospazi, è riconducibile perchè basta fare una catena di if, si potrebbe allineare in maniera arbitraria anche se qui nessun blocco lo sfrutta -->
<!-- con funzioni intende sia lambda che da field a field, (anche se non ha il nome è sempre una funzione) se usiamo quello che esiste è una reifica dei field, oppure decidiamo che le funzioni non possono restituire field-->
<!-- la share senza field reificati è come se si portasse dietro una nuova versione di nbr-->
<!--TODO REIFICARE I FIELDS-->
<!-- se la rep è temporale || share isotropico -->