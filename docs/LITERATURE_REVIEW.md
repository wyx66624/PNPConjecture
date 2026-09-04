# Barrier-aware literature review through September 2026

## 1. Problem statement and proof targets

The P-versus-NP problem asks whether every polynomial-time verifiable language is polynomial-time decidable. Cook–Levin gives SAT as an NP-complete target. Consequently, either a polynomial-time SAT algorithm proves \(P=NP\), or a proof that SAT is outside P proves \(P\ne NP\).

A standard nonuniform target is stronger: because \(P\subseteq P/poly\), proving
\[
\mathrm{SAT}\notin P/poly
\]
would imply \(P\ne NP\). This route asks for superpolynomial lower bounds against general Boolean circuits for an explicit NP function.

## 2. Classical barrier map

### Relativization

Baker, Gill, and Solovay constructed oracles \(A,B\) with
\[
P^A=NP^A,\qquad P^B\ne NP^B.
\]
Therefore a proof technique whose reasoning survives arbitrary oracle access cannot by itself resolve the unrelativized question.

### Natural proofs

Razborov and Rudich showed, under standard pseudorandomness assumptions, that a broad class of circuit-lower-bound properties cannot be simultaneously large and constructive while being useful against strong circuit classes. A route based on an efficiently recognizable property satisfied by a large fraction of Boolean functions must state why it is not trapped by this framework.

### Algebrization

Aaronson and Wigderson extended the relativization warning to techniques that remain valid after low-degree algebraic extensions of oracle information. Arithmetization alone is therefore not an automatic escape.

These are not impossibility theorems for all mathematics. They are tests that force a proposed proof to identify its nonrelativizing, non-natural, or nonalgebrizing ingredient.

## 3. Unrestricted circuit lower bounds

For explicit functions and unrestricted fan-in-two Boolean gates, the best known lower bounds remain linear. Li and Yang obtained a \(3.1n-o(n)\) lower bound over the full binary basis \(\mathcal B_2\). Carmosino, Dang, and Jackman (2026) recast simplification over DeMorgan and \(\{\land,\lor,\oplus\}\) bases as convergent term-graph rewriting, while proving that analogous convergence fails for \(\mathcal U_2\) and \(\mathcal B_2\). They also connect gate elimination to constructive lower bounds: an efficient refuter produces an input on which every candidate circuit errs.

This identifies a concrete local frontier. A larger linear constant would be valuable but cannot by itself yield \(P\ne NP\); a successful route must generate superpolynomial growth or connect a local invariant to a qualitatively stronger global mechanism.

## 4. Algorithms to lower bounds

Williams proved that NEXP is not contained in ACC, using faster satisfiability algorithms for ACC circuits. The strategic lesson is that a nontrivial algorithm for a circuit class can imply a lower bound against that class. The unrestricted-circuit version would require an algorithmic improvement strong enough to avoid known self-reference and simulation bottlenecks.

The route remains active in this repository:

- seek satisfiability, range-avoidance, or useful-property algorithms for progressively richer classes;
- record the exact algorithm-to-lower-bound transfer theorem;
- prevent accidental extrapolation from ACC, formulas, or bounded depth to unrestricted circuits.

## 5. Range avoidance, refuters, and near-maximum lower bounds

Work through 2024–2026 has sharpened near-maximum circuit lower bounds for classes in exponential time and for computation with promise Merlin–Arthur queries. Ren and Williams (2026) obtain a near-maximum lower bound in an exponential-time class with promise-MA access using a new range-avoidance algorithm.

This is major progress on constructing hard truth tables, but it is not yet an NP circuit lower bound. The gap is not merely quantitative: efficiently and uniformly constructing the relevant hard function inside NP is the core obstacle.

## 6. Proof complexity and bounded arithmetic

Proof complexity translates lower bounds into statements about the inability of proof systems to certify tautologies succinctly. Bounded arithmetic asks which complexity lower bounds can be proved in weak theories.

Atserias and Müller (2026) prove that the theory \(S^1_2\), which formalizes polynomial-time reasoning, is consistent with an EXP versus \(P/poly\) separation. This advances the metamathematics of circuit lower bounds while leaving the central NP-versus-\(P/poly\) consistency question unresolved. The repository treats this as a distinct route, not as a proof of the external separation.

A decisive proof-complexity route would need a lower bound for a sufficiently strong system, such as Extended Frege or an equivalent reflection principle, together with a theorem transferring that lower bound to the desired circuit separation.

## 7. Topology and geometry

Topology has rigorous successes in discrete complexity: evasiveness results, Borsuk–Ulam methods, communication complexity, and sign-rank. Frick, Hosseini, and Vasileuski (2026) define a \(\mathbb Z_2\)-topological sign-complex framework whose equivariant index lower-bounds sign-rank, obtaining essentially tight bounds for Gap Hamming Distance in regimes beyond earlier methods.

The lesson is positive but precise: topology becomes a lower-bound method only after a theorem connects a topological index to a standard complexity measure. Merely finding cycles in a machine's trace graph is insufficient, because trace topology can change under semantically irrelevant verifier transformations.

## 8. Audit of a claimed homological separation

The preprint arXiv:2510.17829 claims a complete homological proof of \(P\ne NP\). The repository's audit finds explicit counterexamples to four indispensable steps:

1. face deletion is not closed on directed valid paths;
2. the claimed reduction category has no empty-language zero object and no defined abelian-group law on hom-sets;
3. the verification-order average is not additive under concatenation;
4. the proposed contracting homotopy fails on a one-edge path.

Therefore that manuscript does not currently establish a chain complex or a P-versus-NP separation. The counterexamples are fully stated in `HOMOLOGICAL_CLAIM_AUDIT.md` and formalized in Lean.

## 9. Research synthesis

The most promising combined program is not to select one fashionable vocabulary, but to demand a bridge theorem:

\[
\text{small circuit}
\Longrightarrow
\text{vanishing/bounded invariant},
\qquad
\text{explicit NP target}
\Longrightarrow
\text{nonvanishing/growing invariant}.
\]

VIOT proposes to build such an invariant only after quotienting away verifier-presentation artifacts. Constructive gate elimination and refuter theory supply candidate local witnesses; topology supplies gluing obstructions; proof complexity supplies formal reflection principles; algorithms-to-lower-bounds supplies transfer mechanisms. Every arrow in this diagram remains an explicit proof obligation.

## References

- T. Baker, J. Gill, R. Solovay, “Relativizations of the P =? NP Question,” *SIAM Journal on Computing* 4 (1975).
- S. Cook, “The Complexity of Theorem-Proving Procedures,” STOC (1971).
- L. Levin, “Universal Search Problems,” *Problems of Information Transmission* (1973).
- A. Razborov, S. Rudich, “Natural Proofs,” *Journal of Computer and System Sciences* 55 (1997).
- S. Aaronson, A. Wigderson, “Algebrization: A New Barrier in Complexity Theory,” *ACM Transactions on Computation Theory* 1 (2009).
- R. Williams, “Nonuniform ACC Circuit Lower Bounds,” *Journal of the ACM* 61 (2014).
- J. Li, T. Yang, unrestricted \(\mathcal B_2\) circuit lower bounds, STOC (2022).
- M. Carmosino, N. Dang, T. Jackman, “Convergent Gate Elimination and Constructive Circuit Lower Bounds,” arXiv:2602.17942 (2026).
- H. Ren, R. Williams, “Near-Maximum Circuit Lower Bounds for Exponential Time with Merlin-Arthur Queries,” arXiv:2607.09963 (2026).
- A. Atserias, M. Müller, “From Gödel Incompleteness to the Consistency of Circuit Lower Bounds,” arXiv:2604.25251 (2026).
- F. Frick, K. Hosseini, A. Vasileuski, “A \(\mathbb Z_2\)-Topological Framework for Sign-rank Lower Bounds,” arXiv:2604.01510 (2026).
- J.-G. Tang, “A Homological Separation of P from NP via Computational Topology and Category Theory,” arXiv:2510.17829v2.
