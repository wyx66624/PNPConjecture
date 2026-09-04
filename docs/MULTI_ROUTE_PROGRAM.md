# Multi-route P-versus-NP research program

The program uses multiple adversarial agents conceptually: each route has a builder, a counterexample hunter, a barrier auditor, and a formalizer. Results are exchanged through exact lemmas rather than prose consensus.

## Route R1 — General-circuit gate elimination and rewriting

**Builder objective.** Extend restriction-based simplification from local linear elimination to a global potential that can accumulate superpolynomially.

**Current anchor.** Convergent term-graph rewriting works for DeMorgan and \(\{\land,\lor,\oplus\}\) bases, while confluence fails for \(\mathcal U_2\) and \(\mathcal B_2\).

**New direction.** Replace a single normal form by a rewriting 2-groupoid. Objects are circuits, 1-cells are simplification sequences, and 2-cells resolve critical pairs. Search for a quantitative invariant of unresolved higher critical structure.

**Decisive gap.** Prove that the invariant lower-bounds unrestricted circuit size and grows superpolynomially for an explicit NP function.

**Retirement condition.** A family of small circuits with arbitrarily large proposed invariant, or a theorem that the invariant is polynomially bounded for all functions.

## Route R2 — Algorithms to lower bounds

**Builder objective.** Obtain a satisfiability or correlation algorithm for a circuit class strictly beyond current frontiers, then invoke a proved transfer theorem.

**Counterexample task.** Check whether the algorithm only handles formulas, bounded depth, ACC, sparse circuits, average case, or promises not preserved by the transfer.

**Decisive gap.** A nontrivial algorithm for a class rich enough that the resulting lower bound reaches an explicit NP language against unrestricted polynomial-size circuits.

## Route R3 — Constructive lower bounds, refuters, and range avoidance

**Builder objective.** Given a candidate circuit \(C\), efficiently output an input \(x\) such that \(C(x)\ne f(x)\).

**New synthesis.** Treat local refuters as sections on the restriction site and use VIOT to encode compatibility or obstruction.

**Decisive gap.** Uniformly construct the target function and refuter within sufficiently low complexity; exponential-time near-maximum lower bounds do not automatically descend to NP.

## Route R4 — Proof complexity and bounded arithmetic

**Builder objective.** Prove lower bounds for strong proof systems or reflection principles and establish the exact transfer to circuit lower bounds.

**Counterexample task.** Detect when a lower bound is only for Resolution, bounded depth Frege, cutting planes, or another system too weak to imply NP circuit lower bounds.

**Decisive gap.** Extended Frege–level lower bounds or a new transfer avoiding that bottleneck.

## Route R5 — Algebraic geometry and representation theory

**Builder objective.** Use orbit closures, representation multiplicities, geometric complexity theory, or algebraic natural-proof escape mechanisms to separate explicit families.

**Barrier audit.** Distinguish Boolean versus arithmetic models and ensure that an algebraic separation transfers to Boolean SAT circuits with controlled overhead.

**New direction.** Compare orbit-closure obstructions with equivariant VIOT indices; investigate whether presentation localization has a moduli-space interpretation.

## Route R6 — Equivariant topology and VIOT

**Builder objective.** Construct a presentation-invariant object and prove a quantitative bridge from equivariant/cohomological index to circuit size.

**Calibration.** First recover known sign-rank, communication, query, or formula lower bounds.

**Decisive gap.** Target nonvanishing for an explicit NP family and a superpolynomial circuit-size bridge.

**Already refuted subroute.** Ordinary face deletion on raw directed traces plus verification-order averages.

## Route R7 — P=NP constructive search

A balanced program must also attempt the opposite conclusion.

**Builder objective.** Find a deterministic polynomial-time algorithm for SAT, possibly via canonical proof search, structural decomposition, learned invariants with exact certification, or an unexpected collapse theorem.

**Counterexample task.** Construct formula families defeating every proposed branching, width, rank, or decomposition bound. Verify worst-case polynomial time, not empirical performance.

**Decisive success condition.** A fully specified algorithm, proof of correctness, and polynomial worst-case bound on all formulas.

## Route R8 — Meta-complexity and minimum circuit size

**Builder objective.** Use MCSP, Kolmogorov-style resource-bounded complexity, useful properties, and magnification to turn modest lower bounds into stronger separations.

**Barrier audit.** Track naturalness and constructivity explicitly. Do not assume MCSP is NP-complete under reductions for which that remains unknown.

## Cross-route theorem ledger

Every route must export results in this form:

- exact statement;
- status label;
- dependencies;
- proof or counterexample;
- computational model;
- barrier profile;
- Lean module;
- next weakest unresolved lemma.

A route is not abandoned because it is difficult. It is narrowed or retired only when a counterexample addresses its exact conjecture. Conversely, “not yet refuted” is not evidence that the conjecture is true.

## Current allocation

The highest-value immediate work is:

1. formalize verifier-presentation invariance and gadget-insertion no-go theorems;
2. calibrate VIOT on a known topological lower bound;
3. formalize a convergent-rewriting lower-bound theorem for a restricted basis;
4. connect local refuters to a sheaf/derived obstruction with a precise soundness theorem;
5. maintain R7 as an adversarial search for polynomial SAT algorithms.

No route currently closes the unconditional problem.
