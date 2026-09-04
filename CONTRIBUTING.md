# Contributing mathematical results

Contributions are welcome as pull requests. The standard is designed to distinguish a genuine theorem from a plausible research narrative.

## Required structure for every theorem PR

Include:

1. an exact theorem statement with all quantifiers, models of computation, uniformity conditions, and asymptotic parameters;
2. a dependency graph identifying every imported theorem;
3. a complete mathematical proof before Lean code;
4. a Lean file with no `sorry`, `admit`, user-declared `axiom`, or hidden unsound option;
5. the smallest known counterexample search performed against the statement;
6. a barrier audit: relativization, natural proofs, algebrization, and model-specific limitations;
7. a claim label from `README.md`;
8. reproducible build instructions.

For a proposed proof of \(P\ne NP\) or \(P=NP\), also include an independently checkable bridge from the central new lemma to a standard complete problem such as SAT, and state why the proof does not merely establish a restricted-circuit or nonuniform result.

## Review protocol

Reviewers should try to falsify the earliest nonstandard lemma first. Typical checks include:

- Is a proposed boundary operator closed on its generators?
- Is an alleged category actually locally small, pointed, preadditive, or additive?
- Is an invariant independent of machine encoding, padding, certificate order, and dummy computation?
- Does a claimed reduction preserve the property used by the lower bound?
- Does the proof silently exchange uniform and nonuniform complexity?
- Is a “large” finite lower bound being mistaken for a superpolynomial family?
- Does the Lean theorem formalize the manuscript's theorem, or only a weakened abstraction?

An AI review may assist with counterexample generation and dependency tracing, but merge approval for a complete solution requires mathematically independent human review.

## Branch and merge policy

Research should be developed on a named branch and proposed through a pull request. `main` is not to receive an unconditional P-versus-NP claim until every required check is satisfied. Maintainer review is required before merge; automatic self-merging of a claimed breakthrough is intentionally disabled.
