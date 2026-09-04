# Research status and claim ledger

Last updated: 2026-09-03 (America/Chicago)

## Global question

Determine whether every language decidable by a nondeterministic polynomial-time Turing machine is decidable by a deterministic polynomial-time Turing machine.

**Status: OPEN GAP.** This repository does not claim \(P=NP\) or \(P\ne NP\).

## Repository audit

At the start of this research pass, `main` contained only `.gitignore` and `LICENSE`; there was no manuscript, Lean project, or previous research branch. Accordingly, phrases such as “the current proof in the repository” would have been inaccurate.

## Results established in this branch

| ID | Statement | Mathematical status | Lean file |
|---|---|---:|---|
| A1 | Deleting an interior vertex of a valid directed computation path need not produce a valid path. | FORMALIZED | `PathBoundaryCounterexample.lean` |
| A2 | The category whose morphisms are ordinary many-one reductions cannot have the claimed empty-language zero object: a reduction from the universal nonempty language to the empty language does not exist. | FORMALIZED | `ReductionCategoryCounterexample.lean` |
| A3 | The proposed average of adjacent verification-order signs is not additive under concatenation. | FORMALIZED | `RhoCounterexample.lean` |
| A4 | The displayed “append the next configuration” homotopy fails on the unique one-edge path: \(s_0(c_1)-s_0(c_0)=-e\), not \(e\). | FORMALIZED | `ContractingHomotopyCounterexample.lean` |
| A5 | Ignoring an additional nonempty dummy certificate type preserves the recognized language. | FORMALIZED | `VerifierPadding.lean` |
| A6 | Any obstruction satisfying “exact computation implies zero obstruction” and “all candidate circuits have nonzero obstruction” rules out every candidate circuit. | FORMALIZED | `ObstructionSoundness.lean` |
| A7 | If an NP problem is outside P, then \(P\ne NP\); more specifically, since \(P\subseteq P/poly\), an NP problem outside \(P/poly\) separates P from NP. | FORMALIZED (abstract class form) | `BarrierCriteria.lean` |

These results refute the cited manuscript's specific chain-complex construction and its main proof, but **do not refute every possible topological approach** to circuit complexity.

## Decisive remaining gaps

A proof of \(P\ne NP\) through circuit lower bounds must eventually supply an explicit language in NP—typically SAT—with superpolynomial circuit lower bounds. The unrestricted fan-in-two Boolean-circuit frontier remains only linear for explicit functions, so improving a constant in gate elimination is not close to the required asymptotic separation.

The proposed VIOT route has four non-negotiable gaps:

1. **Presentation invariance:** define the obstruction on a localization or equivalent quotient where certificate padding, stuttering, recoding, and polynomial-time bidirectional simulation act trivially.
2. **Circuit soundness:** prove that a size-\(s(n)\) circuit computing the target forces the obstruction to vanish or remain below a quantitative index.
3. **Target nonvanishing:** prove, uniformly and explicitly, that the target NP family has a nonzero or growing obstruction against every circuit of the prescribed size.
4. **Barrier escape:** identify exactly which premise is nonrelativizing, non-natural in the Razborov–Rudich sense, and non-algebrizing, or prove that the route is intentionally confined to a circuit class where those barriers do not apply.

Until all four are closed, VIOT is a structured research program, not a separation proof.

## Refuted route versus repaired route

**REFUTED:** “Take all adjacent valid computation traces as simplices and use ordinary face deletion; verification-order cycles then separate P from NP.”

**ACTIVE:** “Construct a presentation-invariant derived object over restrictions or simulations, prove a circuit-sound obstruction theorem, and obtain target nonvanishing by an explicit structural argument.”

The distinction matters: the counterexamples kill a precise definition, not the broader possibility of topology in complexity theory.
