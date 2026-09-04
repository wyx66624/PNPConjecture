# P versus NP: auditable research and Lean formalization

This repository is an open, proof-first research program on the **P versus NP problem**. Its long-term target is either:

1. an unconditional, independently audited proof of \(P\ne NP\) or \(P=NP\), followed by a gap-free Lean formalization; or
2. a rigorous refutation of a proposed route by an explicit counterexample, with the failed assumptions recorded for future work.

## Current status

**No proof of \(P\ne NP\) or \(P=NP\) is claimed.** The initial repository audit found that the original `main` branch contained only a license and a Lean cache ignore rule. This research branch therefore establishes a reproducible baseline rather than presenting an already completed solution.

The first verified contribution is a four-part audit of the 2025/2026 preprint *A Homological Separation of P from NP via Computational Topology and Category Theory* (arXiv:2510.17829). The audit gives explicit counterexamples to:

- closure of the proposed path generators under face deletion;
- the claim that the reduction category is additive;
- additivity of the proposed verification-order average under path composition; and
- the displayed contracting homotopy on the one-edge computation.

A fifth result proves a **verifier-padding invariance theorem**: adding an ignored, nonempty dummy certificate type does not change the recognized language. This motivates the new route called **Verifier-Invariant Obstruction Theory (VIOT)**: a topological or categorical invariant intended to say something about a language must first survive polynomial-time changes of verifier presentation.

## Repository map

- `RESEARCH_STATUS.md` — claim ledger and exact open gaps.
- `docs/LITERATURE_REVIEW.md` — barrier-aware literature review through September 2026.
- `docs/HOMOLOGICAL_CLAIM_AUDIT.md` — mathematical counterexamples, with proofs.
- `docs/VERIFIER_INVARIANT_OBSTRUCTION_THEORY.md` — the new higher-structural route.
- `docs/MULTI_ROUTE_PROGRAM.md` — parallel research routes and falsification criteria.
- `paper/main.tex` — English research paper, author **ChatGPT**.
- `PNPConjecture/*.lean` — Lean formalization of the proved baseline results.
- `.github/workflows/lean.yml` — automated proof checking and prohibition of `sorry`, `admit`, and user-declared `axiom`.

## Epistemic labels

Every mathematical statement should carry one of these labels:

- **FORMALIZED** — compiled by the pinned Lean toolchain without placeholders.
- **PROVED** — a complete conventional proof is written, but not yet formalized.
- **CONDITIONAL** — proved from explicitly listed hypotheses.
- **OPEN GAP** — required for a route but not proved.
- **CONJECTURE** — proposed statement supported by evidence, not a theorem.
- **REFUTED** — an explicit counterexample is supplied.

A failed attempt is not marked false merely because a proof has not been found. A route is retired only after a counterexample or an incompatibility theorem addresses its precise statement.

## Merge policy

`main` is reserved for material that has passed:

1. mathematical dependency auditing;
2. Lean CI with no proof placeholders;
3. barrier analysis against relativization, natural proofs, and algebrization where applicable;
4. adversarial review by a mathematically independent reviewer; and
5. explicit maintainer review before merge.

A complete P-versus-NP claim must not be merged merely because a manuscript is long, a model is confident, or a proof assistant verifies only auxiliary lemmas.
