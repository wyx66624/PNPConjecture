# P versus NP — AI-Assisted, Proof-First Open Research

This repository coordinates an open research program aimed at resolving the **P versus NP problem** with auditable mathematics and machine-checked formalization in Lean.

Its ultimate objective is one of the following:

1. an unconditional proof of \(P \ne NP\);
2. an unconditional proof of \(P = NP\), including a fully specified polynomial-time algorithm for an NP-complete problem; or
3. a rigorous refutation of a proposed proof route by an explicit counterexample or incompatibility theorem.

A final resolution is intended to be written as a journal-quality English paper and formalized without proof placeholders. Until that standard is met, the repository distinguishes proved results from conjectures and open gaps.

## Current status

**The P versus NP problem is not claimed to be solved in this repository.**

The current verified baseline contains Lean-checked auxiliary theorems, counterexamples, and research infrastructure. In particular, it includes:

- a four-part formal audit of the proposed homological separation in arXiv:2510.17829;
- a proof that the proposed directed-path boundary is not closed on its stated generators;
- a proof that ordinary many-one reductions do not form the claimed additive category;
- a counterexample to additivity of the proposed verification-order functional;
- a counterexample to the displayed contracting homotopy;
- verifier-padding and accepting-certificate-fiber invariance theorems;
- a same-language/different-witness-structure no-go theorem;
- a semantic quotient of verifier presentations by recognized-language equivalence;
- a constant-time trace-gadget theorem showing that an induced cycle can be added to an easy computation presentation without changing the recognized language; and
- abstract obstruction-soundness and class-separation lemmas.

These results rule out specific invalid arguments and impose necessary invariance conditions on future topological or categorical approaches. They do **not** constitute a proof of \(P = NP\) or \(P \ne NP\).

## Research methodology

The project uses multiple parallel research routes. Each route is examined by four adversarial roles:

- a **builder**, who develops the strongest precise theorem available;
- a **counterexample hunter**, who searches for minimal falsifying instances;
- a **barrier auditor**, who checks relativization, natural-proofs, algebrization, uniformity, and model-transfer issues; and
- a **formalizer**, who translates proved statements into Lean only after the mathematical proof is complete.

Routes include unrestricted Boolean-circuit lower bounds, algorithms-to-lower-bounds, constructive refuters and range avoidance, proof complexity, bounded arithmetic, algebraic geometry and representation theory, meta-complexity, an adversarial search for polynomial-time SAT algorithms, and the new verifier-invariant topological route described below.

## Verifier-Invariant Obstruction Theory

The repository develops **Verifier-Invariant Obstruction Theory (VIOT)** as a higher-structural research program.

The central observation is that raw computation traces are presentations rather than canonical language objects. Polynomial-time padding, dummy certificates, state recoding, bounded stuttering, and independent-check reordering can change witness or trace structure without changing the recognized language. A valid obstruction must therefore be defined only after these presentation artifacts have been identified through a resource-sensitive quotient or localization.

A successful VIOT separation would require two genuine bridge theorems:

\[
\text{small circuit computing } f
\Longrightarrow
\text{vanishing or bounded obstruction},
\]

and

\[
\text{explicit NP target } f
\Longrightarrow
\text{nonvanishing or superpolynomially growing obstruction}.
\]

Neither bridge is currently claimed as proved.

## Repository map

- `RESEARCH_STATUS.md` — exact claim ledger, statuses, and decisive remaining gaps.
- `docs/LITERATURE_REVIEW.md` — barrier-aware literature review through September 2026.
- `docs/HOMOLOGICAL_CLAIM_AUDIT.md` — mathematical audit and explicit counterexamples.
- `docs/VERIFIER_INVARIANT_OBSTRUCTION_THEORY.md` — definitions and proof obligations for VIOT.
- `docs/MULTI_ROUTE_PROGRAM.md` — parallel research routes and falsification criteria.
- `paper/main.tex` — English research paper authored by **ChatGPT**.
- `PNPConjecture/*.lean` — Lean formalizations of proved baseline statements.
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
