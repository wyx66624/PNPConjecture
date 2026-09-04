# Research status and claim ledger

Last updated: 2026-09-04

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
| A11 | Under the current abstract trace semantics, every start-to-accept reachable graph represents the universal language, and any two reachable trace gadgets represent the same language regardless of their unused graph structure. | FORMALIZED | `TracePresentationUniversality.lean` |
| A12 | Constant-factor equivalence of cost profiles is an equivalence relation; combining it with same-language equivalence yields a first resource-sensitive quotient of costed verifier presentations. Nonempty dummy padding is equality in this quotient. | FORMALIZED | `ResourceSensitivePresentation.lean` |
| A13 | The pure semantic quotient forgets asymptotic cost: one identical always-accepting verifier with costs \(1\) and \(n+1\) has the same semantic class but different resource classes. | FORMALIZED | `SemanticCostLoss.lean` |
| A14 | Certificate-preserving, constant-overhead resource simulations compose; bidirectional simulations form a setoid and a quotient. Ignored nonempty padding is witnessed by explicit forward and backward simulations and becomes equality in that quotient. | FORMALIZED | `ResourceSimulation.lean` |
| A15 | The linear and diamond trace presentations have the same language and constant-factor-equivalent costs, yet only the diamond has an induced four-cycle. Raw trace-cycle structure therefore fails even resource-equivalence invariance. | FORMALIZED | `ResourceSensitiveTraceNoGo.lean` |
| A16 | If every legal construction step raises a natural-valued potential by at most \(\delta\), then an \(s\)-step construction raises it by at most \(s\delta\); a target beyond that budget cannot be constructed in \(s\) steps. | FORMALIZED | `QuantitativePotential.lean` |
| A17 | If a target family's potential exceeds the budget of every polynomial derivation-size bound, while each construction step has the stated local potential bound, then the target derivation-size family is not polynomially bounded. | FORMALIZED | `AsymptoticPotential.lean` |
| A18 | The canonical pointwise-disagreement obstruction is nonzero for every candidate exactly when no exact candidate exists. It therefore restates, rather than proves, the desired lower bound. | FORMALIZED | `DisagreementObstruction.lean` |

Results A1–A4 refute the cited manuscript's specific proof. Results A5, A8–A15 establish necessary presentation- and resource-invariance conditions for any repaired topological or categorical route. Results A16–A17 give a correct abstract quantitative lower-bound bridge. Result A18 rules out a tautological choice of obstruction. None of these statements is an unconditional P-versus-NP separation.

## Current literature calibration

The September 2026 review includes major nearby advances in convergent gate elimination, constructive refuters, depth-two threshold circuits, near-maximum lower bounds in exponential-time classes, monotone perfect-matching circuits, noncommutative arithmetic circuits, proof complexity, meta-complexity, and topological lower bounds for restricted models.

Each advance is model-specific. None currently supplies either a worst-case polynomial-time SAT algorithm or a superpolynomial lower bound for SAT against unrestricted Boolean circuits.

## Progress on the four decisive gaps

### 1. Resource-sensitive presentation invariance

**Narrowed but not closed.** A first quotient by same language and constant-factor cost has been formalized, as has a more structural quotient by explicit bidirectional certificate simulations with constant-factor overhead. The pure semantic quotient has been formally shown to erase asymptotic cost.

The remaining requirement is to derive the cost profile from a formal uniform machine or circuit semantics rather than supply it externally, and to formalize state recoding, bounded stuttering, branch insertion, certificate recoding, advice, fan-out, sharing, depth, size, and uniformity with proved overhead bounds.

### 2. Circuit soundness

**Abstract logical bridge formalized; concrete bridge open.** The one-step and family-level potential theorems prove the exact implication

\[
\text{local gate-growth bound} + \text{superpolynomial target potential}
\Longrightarrow
\text{superpolynomial construction size}.
\]

What remains is a non-tautological potential or obstruction for the full unrestricted binary basis \(\mathcal B_2\), with a proved one-gate Lipschitz bound and a faithful correspondence between derivation length and circuit size.

### 3. Explicit NP target nonvanishing

**Open.** The disagreement obstruction has been proved tautological. A useful obstruction must have an independently provable structural upper bound for every small circuit and a separately provable superpolynomial lower bound for SAT or another explicit NP-complete family. No such unrestricted-circuit nonvanishing theorem is presently established here.

### 4. Barrier escape

**Diagnosed but not closed.** The current quotient, simulation, and potential-accumulation lemmas relativize and are compatible with algebraic extension; consequently they cannot be the decisive barrier-escaping ingredient. A final proof must isolate an exact target-specific lemma that is nonrelativizing and nonalgebrizing, and must audit whether the induced property is constructive, large, and useful in the Razborov–Rudich sense. Results for restricted circuit models require an explicit transfer theorem before they can say anything about unrestricted SAT circuits.

## Resource-Localized Obstruction Profiles

The current synthesis is called a **Resource-Localized Obstruction Profile (RLOP)**. An RLOP should consist of:

1. a resource-simulation quotient of computational presentations;
2. a gate-construction category or higher rewriting groupoid;
3. a presentation-invariant potential or index \(\Phi_f\);
4. a one-gate quantitative growth theorem;
5. an explicit target-growth theorem;
6. a barrier audit and a transfer theorem to a standard NP-complete family.

Items 1 and the abstract form of item 4 now have Lean-checked calibration models. Items 3, 5, and 6 remain the decisive research targets for unrestricted circuits.

## Refuted route versus active repair

**REFUTED:** “Take adjacent valid computation traces as simplices, apply ordinary face deletion, and use verification-order cycles to separate P from NP.”

**ALSO REFUTED AS A LANGUAGE OR RESOURCE INVARIANT:** “Use raw accepting-witness multiplicity or raw trace-cycle structure without first quotienting constant-overhead presentation changes.”

**TAUTOLOGICAL, NOT A LOWER-BOUND METHOD:** “Use the existence of a pointwise disagreement itself as the obstruction and call its universal nonvanishing a proof.”

**ACTIVE:** “Construct a resource-localized, non-tautological obstruction over unrestricted circuit-building operations, prove a one-gate bound, and establish superpolynomial target growth for an explicit NP family.”

The distinction is essential: explicit counterexamples eliminate precise definitions, while the repaired route remains active until one of its own exact conjectures is refuted or proved.
