# P versus NP — AI-Assisted, Proof-First Open Research

This repository coordinates an open research program aimed at resolving the **P versus NP problem** with auditable mathematics and machine-checked formalization in Lean.

Its ultimate objective is one of the following:

1. an unconditional proof of \(P \ne NP\);
2. an unconditional proof of \(P = NP\), including a fully specified polynomial-time algorithm for an NP-complete problem; or
3. a rigorous refutation of a proposed proof route by an explicit counterexample or incompatibility theorem.

A final resolution is intended to be written as a journal-quality English paper and formalized without proof placeholders. Until that standard is met, the repository distinguishes proved results from conjectures and open gaps.

## Current status

**The P versus NP problem is not claimed to be solved in this repository.**

The current verified baseline contains Lean-checked auxiliary theorems, counterexamples, resource-sensitive formal infrastructure, and an exact ledger of the remaining proof obligations. Highlights include:

- a four-part formal audit of the proposed homological separation in arXiv:2510.17829;
- verifier-padding and accepting-certificate-fiber invariance theorems;
- same-language/different-witness-structure and same-language/different-trace-cycle no-go theorems;
- a general theorem showing that every reachable fixed trace gadget represents the same universal language under the current abstract trace semantics;
- a proof that raw trace cycles can change even between presentations with constant-factor-equivalent running-time profiles;
- a semantic quotient of verifier presentations and a formal proof that this quotient forgets asymptotic cost;
- a first resource-sensitive quotient using same-language and constant-factor cost equivalence;
- an explicit quotient by bidirectional certificate simulations with constant-factor resource overhead;
- a quantitative theorem showing that a potential with bounded one-step growth yields construction-size lower bounds;
- a family-level theorem converting superpolynomial target-potential growth into a non-polynomial derivation-size lower bound; and
- a formal diagnostic proving that the naive disagreement obstruction merely restates the desired lower bound.

These results eliminate several invalid approaches and make the remaining circuit-lower-bound burden more precise. They do **not** constitute a proof of \(P = NP\) or \(P \ne NP\).

## Research methodology

The project uses multiple parallel research routes. Each route is examined by four adversarial roles:

- a **builder**, who develops the strongest precise theorem available;
- a **counterexample hunter**, who searches for minimal falsifying instances;
- a **barrier auditor**, who checks relativization, natural-proofs, algebrization, uniformity, and model-transfer issues; and
- a **formalizer**, who translates proved statements into Lean only after the mathematical proof is complete.

Routes include unrestricted Boolean-circuit lower bounds, algorithms-to-lower-bounds, constructive refuters and range avoidance, proof complexity, bounded arithmetic, algebraic geometry and representation theory, meta-complexity, an adversarial search for polynomial-time SAT algorithms, and the verifier-invariant structural route described below.

## VIOT and Resource-Localized Obstruction Profiles

The repository develops **Verifier-Invariant Obstruction Theory (VIOT)** and its quantitative refinement, a **Resource-Localized Obstruction Profile (RLOP)**.

The central observation is that raw computation traces are presentations rather than canonical complexity objects. Padding, dummy certificates, state recoding, bounded stuttering, and constant-overhead branch insertion can change witness and trace topology without changing either the recognized language or its asymptotic resource class. A valid obstruction must therefore be defined only after these presentation artifacts have been identified through an explicit resource-sensitive quotient or localization.

An RLOP is intended to contain:

1. a quotient by resource-controlled computational simulations;
2. a gate-construction category or higher rewriting groupoid;
3. a presentation-invariant, non-tautological potential or index \(\Phi_f\);
4. a one-gate growth theorem over the chosen circuit basis;
5. an explicit target-growth theorem; and
6. a barrier and model-transfer audit.

The repository now formalizes calibration versions of the resource quotient and the abstract quantitative bridge. The decisive unrestricted-circuit statements remain open. A successful separation still requires

\[
\text{small circuit computing }f
\Longrightarrow
\text{bounded resource-localized obstruction},
\]

and

\[
\text{explicit NP target }f
\Longrightarrow
\text{superpolynomially growing obstruction}.
\]

For a proof through circuit lower bounds, the second implication must be strong enough to establish \(\mathrm{SAT}\notin P/poly\).

## Repository map

- `RESEARCH_STATUS.md` — exact claim ledger, statuses, and decisive remaining gaps.
- `docs/CORE_GAP_DEEP_RESEARCH.md` — direct analysis of resource localization, circuit soundness, SAT nonvanishing, and barrier escape.
- `docs/LITERATURE_REVIEW.md` — barrier-aware literature review through September 2026.
- `docs/HOMOLOGICAL_CLAIM_AUDIT.md` — mathematical audit and explicit counterexamples.
- `docs/DIAMOND_TRACE_NO_GO.md` — proof that constant-time dummy branching can change raw trace-cycle structure.
- `docs/VERIFIER_INVARIANT_OBSTRUCTION_THEORY.md` — definitions and proof obligations for VIOT.
- `docs/MULTI_ROUTE_PROGRAM.md` — parallel research routes and falsification criteria.
- `paper/main.tex` — English research paper authored by **ChatGPT**.
- `PNPConjecture/*.lean` — Lean formalizations of proved statements.
- `.github/workflows/lean.yml` — automated Lean checking and rejection of proof placeholders.

## Claim labels

Every nontrivial claim should be marked with one of the following labels:

- **FORMALIZED** — compiled by the pinned Lean toolchain without `sorry`, `admit`, or user-declared axioms.
- **PROVED** — a complete conventional proof is present but has not yet been formalized.
- **CONDITIONAL** — proved from explicitly listed hypotheses.
- **OPEN GAP** — a required implication has not been proved.
- **CONJECTURE** — a precise proposed theorem, not an established result.
- **REFUTED** — an explicit counterexample or incompatibility proof is supplied.

A route is not discarded merely because it is difficult. It is narrowed or retired only when a counterexample addresses its precise statement. Conversely, survival against current counterexample searches is not evidence of truth.

## Merge standard

Material merged into `main` must pass the checks appropriate to its scope:

1. an exact mathematical statement with all quantifiers and computational models specified;
2. a complete proof or explicit counterexample;
3. dependency and barrier auditing;
4. Lean CI with no proof placeholders for claims marked **FORMALIZED**;
5. agreement between the manuscript statement and the Lean statement; and
6. maintainer review.

Any claimed complete resolution of P versus NP additionally requires independent expert review and a complete bridge to a standard NP-complete problem such as SAT. Length, confidence, experimental evidence, or verification of only auxiliary lemmas is not sufficient.

## Contributing

Contributions are welcome through pull requests. State the exact theorem, model of computation, uniformity assumptions, asymptotic regime, dependencies, proof, counterexample search, barrier profile, and Lean correspondence. See `CONTRIBUTING.md` for the full protocol.
