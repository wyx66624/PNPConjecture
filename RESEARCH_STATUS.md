# Research status and claim ledger

Last updated: 2026-09-03 (America/Chicago)

## Global question

Determine whether every language decidable by a nondeterministic polynomial-time Turing machine is decidable by a deterministic polynomial-time Turing machine.

**Status: OPEN GAP.** This repository does not claim \(P=NP\) or \(P\ne NP\).

## Results established in the repository

| ID | Statement | Mathematical status | Lean file |
|---|---|---:|---|
| A1 | Under the audited manuscript's own initial/terminal endpoint conditions, a valid path \((c_0,c_1,c_2)\) can have all three ordinary faces absent: one loses the initial endpoint, one skips a nonexistent transition, and one loses the terminal endpoint. | FORMALIZED | `PathBoundaryCounterexample.lean` |
| A2 | The category whose morphisms are ordinary many-one reductions cannot have the claimed empty-language zero object: a reduction from the universal nonempty language to the empty language does not exist. | FORMALIZED | `ReductionCategoryCounterexample.lean` |
| A3 | The proposed average of adjacent verification-order signs is not additive under concatenation. | FORMALIZED | `RhoCounterexample.lean` |
| A4 | The displayed “append the next configuration” homotopy fails on the unique one-edge path: \(s_0(c_1)-s_0(c_0)=-e\), not \(e\). | FORMALIZED | `ContractingHomotopyCounterexample.lean` |
| A5 | For ignored dummy certificate type \(D\), the accepting-certificate fiber of the padded verifier is equivalent to \(D\times W_x\); when \(D\) is nonempty, the recognized language is unchanged. Hence language-factored invariants must ignore this arbitrary product enlargement. | FORMALIZED | `VerifierPadding.lean` |
| A6 | Any obstruction satisfying “exact computation implies zero obstruction” and “all candidate circuits have nonzero obstruction” rules out every candidate circuit. | FORMALIZED | `ObstructionSoundness.lean` |
| A7 | If an NP problem is outside P, then \(P\ne NP\); more specifically, since \(P\subseteq P/poly\), an NP problem outside \(P/poly\) separates P from NP. | FORMALIZED (abstract class form) | `BarrierCriteria.lean` |
| A8 | A trivial verifier can have a subsingleton accepting-certificate fiber while its `Bool`-padded presentation has two provably distinct accepting certificates, although both presentations recognize exactly the same language. | FORMALIZED | `WitnessStructureCounterexample.lean` |
| A9 | Same-language equivalence is a setoid on verifier presentations; in the resulting coarse semantic quotient, nonempty dummy padding is literal equality, and every quotient-defined invariant ignores it. | FORMALIZED | `VerifierSemanticQuotient.lean` |
| A10 | Two constant-time, rank-increasing trace presentations recognize the same universal language on `Unit`, while the direct presentation has no induced four-cycle and the dummy two-branch diamond has a chordless square in its underlying graph. Hence raw trace-cycle structure is not a language invariant. | FORMALIZED | `DiamondTraceNoGo.lean` |

Results A1–A4 refute the cited manuscript's specific proof. Results A5, A8, A9, and A10 establish presentation-invariance requirements for any repaired topological or categorical route. They do **not** refute every possible topological approach to circuit complexity.

## Current literature calibration

The September 2026 review includes the following major nearby advances:

- convergent gate elimination and constructive refuters for restricted Boolean bases;
- \(n^{2.5-\varepsilon}\) lower bounds for depth-two threshold circuits for a function in \(E^{NP}\);
- near-maximum circuit lower bounds in \(E^{\mathrm{prMA}}/_1\);
- \(\exp(\widetilde\Omega(\sqrt n))\) monotone lower bounds for bipartite perfect matching;
- \(\Omega(n^{1.5})\) noncommutative arithmetic-circuit product-gate lower bounds; and
- an extension of natural-proofs barriers to broad classes of linear-function lower bounds.

Each advance is model-specific. None currently supplies either a worst-case polynomial-time SAT algorithm or a superpolynomial lower bound for SAT against unrestricted Boolean circuits.

## Decisive remaining gaps

A proof of \(P\ne NP\) through circuit lower bounds must ultimately supply an explicit language in NP—typically SAT—with superpolynomial circuit lower bounds. The unrestricted fan-in-two Boolean-circuit frontier remains only linear for explicit functions, so improving a constant in gate elimination is not close to the required asymptotic separation.

The proposed VIOT route has four non-negotiable gaps:

1. **Resource-sensitive presentation invariance:** construct a localization or quotient where padding, bounded stuttering, recoding, dummy branching, and polynomial-time bidirectional simulation act trivially without erasing the computational cost information needed for lower bounds.
2. **Circuit soundness:** prove that a size-\(s(n)\) circuit computing the target forces the obstruction to vanish or remain below a quantitative index.
3. **Target nonvanishing:** prove, uniformly and explicitly, that the target NP family has a nonzero or superpolynomially growing obstruction against every circuit of the prescribed size.
4. **Barrier escape:** identify exactly which decisive premise is nonrelativizing, non-natural in the Razborov–Rudich sense, and non-algebrizing, or explicitly restrict the theorem to a model where the corresponding barrier is inapplicable.

The semantic quotient in A9 is deliberately coarse: it removes presentation artifacts but also forgets computational cost. It is a calibration object, not the final resource-sensitive localization required by VIOT.

## Refuted route versus active repair

**REFUTED:** “Take adjacent valid computation traces as simplices, apply ordinary face deletion, and use verification-order cycles to separate P from NP.”

**ALSO REFUTED AS A LANGUAGE INVARIANT:** “Use raw accepting-witness multiplicity or raw trace-cycle structure without first quotienting polynomial-time presentation changes.”

**ACTIVE:** “Construct a resource-sensitive presentation-invariant derived object over restrictions or simulations, prove a circuit-sound obstruction theorem, and establish superpolynomial target nonvanishing for an explicit NP family.”

The distinction is essential: explicit counterexamples eliminate precise definitions, while the repaired route remains active until one of its own exact conjectures is refuted or proved.
