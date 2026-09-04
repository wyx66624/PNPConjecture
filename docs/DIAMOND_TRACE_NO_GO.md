# A constant-time trace-gadget no-go theorem

## Status

**FORMALIZED.** The Lean proof is in `PNPConjecture/DiamondTraceNoGo.lean`.

## Motivation

A topology extracted from the raw trace graph of one machine or verifier can represent implementation choices rather than the complexity of the recognized language. To make this objection resource-sensitive, it is not enough to add an unreachable gadget or an unbounded loop. The following example uses only finite, acyclic, constant-depth computation graphs.

## Definitions

For a directed transition relation \(E\subseteq S\times S\), write \(E^{*}(a,b)\) for reflexive-transitive reachability. A presentation with start state \(s\) and accepting state \(t\) recognizes the language
\[
L_E=\{x:E^{*}(s,t)\}.
\]
The input set in the example is the singleton \(\{*\}\), so the only possible languages are the empty and universal languages.

Given \(E\), let \(U(E)\) be the underlying undirected adjacency relation:
\[
U(E)(a,b)\iff E(a,b)\lor E(b,a).
\]
An induced four-cycle consists of four distinct vertices \(a,b,c,d\) with
\[
U(a,b),\ U(b,c),\ U(c,d),\ U(d,a),
\]
and with no diagonal edges \(U(a,c)\) or \(U(b,d)\).

## Theorem

There are two constant-time, acyclic presentations recognizing the same universal language on one input such that the underlying graph of one has no induced four-cycle and the underlying graph of the other has an induced four-cycle.

## Proof

Define the **linear presentation** by the two states
\[
s,t
\]
and the sole transition
\[
s\longrightarrow t.
\]
The accepting state is reachable from the start state in one step, so the presentation recognizes the universal language on \(\{*\}\). Assign ranks
\[
r(s)=0,\qquad r(t)=1.
\]
Every edge strictly increases rank. Hence the directed graph is acyclic and every computation has constant length. Because it has only two states, it cannot contain four distinct vertices and therefore has no induced four-cycle.

Define the **diamond presentation** by four states
\[
s,\ell,r,t
\]
and transitions
\[
s\to\ell,\qquad s\to r,\qquad
\ell\to t,\qquad r\to t.
\]
The accepting state is reachable by either length-two path, so this presentation also recognizes the universal language on \(\{*\}\). Assign ranks
\[
r(s)=0,\qquad r(\ell)=r(r)=1,\qquad r(t)=2.
\]
Again every directed edge strictly increases rank, so the presentation is acyclic and constant-time.

After forgetting orientation, the four states form
\[
s-\ell-t-r-s.
\]
There is no edge between \(s\) and \(t\), and no edge between \(\ell\) and \(r\). Thus this is a chordless induced four-cycle.

The two presentations recognize exactly the same language but have different induced-cycle structure. Therefore induced-cycle structure of a raw trace graph is not a language invariant. \(\square\)

## Consequence

Any proposed lower bound of the form
\[
\text{“the raw computation trace contains a cycle, hence the language is hard”}
\]
is invalid unless the cycle survives all resource-bounded presentation transformations that preserve the language. In particular, the invariant must ignore constant-size dummy branching and reconvergence.

This theorem does not rule out all topological complexity methods. It specifies one additional relation that a resource-sensitive localization must identify before a topological obstruction can be interpreted as a property of a language or of its computational complexity.
