# Barrier-aware literature review through September 2026

## 1. Problem statement and exact proof targets

The P-versus-NP problem asks whether every polynomial-time verifiable language is polynomial-time decidable. Cook–Levin makes SAT an NP-complete target. Consequently:

- a deterministic polynomial-time algorithm for SAT proves \(P=NP\);
- a proof that SAT is outside P proves \(P\ne NP\); and
- because \(P\subseteq P/poly\), the stronger nonuniform lower bound
  \[
  \mathrm{SAT}\notin P/poly
  \]
  also proves \(P\ne NP\).

The circuit route therefore requires a superpolynomial lower bound against unrestricted Boolean circuits for an explicit function in NP. A lower bound for a restricted circuit class, a function only known to lie in exponential time, or an arithmetic model does not by itself close this target.

## 2. Classical barrier map

### Relativization

Baker, Gill, and Solovay constructed oracles \(A,B\) with
\[
P^A=NP^A,\qquad P^B\ne NP^B.
\]
A proof whose decisive reasoning survives arbitrary oracle access cannot by itself settle the unrelativized problem.

### Natural proofs

Razborov and Rudich showed, under standard pseudorandomness assumptions, that a broad family of lower-bound properties cannot be simultaneously large, efficiently constructive from truth tables, and useful against strong circuit classes. Every proposed efficiently recognizable obstruction must therefore disclose its largeness and constructivity profile.

Ran Raz's 2026 extension of the natural-proofs perspective to linear maps over finite fields gives an additional warning: under trapdoored-matrix assumptions, natural methods cannot establish substantially superlinear circuit lower bounds for broad classes of explicit linear functions. This result concerns a different model, but it reinforces the requirement that a proposed rank or linear-algebraic invariant identify a non-natural ingredient rather than merely repackage an efficiently testable large property.

### Algebrization

Aaronson and Wigderson extended the relativization warning to methods stable under low-degree algebraic extensions of oracle information. Arithmetization alone is therefore not an automatic escape.

These barriers are not universal impossibility theorems. They are mandatory diagnostic tests for the decisive lemma of any claimed resolution.

## 3. Unrestricted Boolean circuit lower bounds

For explicit functions and unrestricted fan-in-two Boolean gates, the best established lower bounds remain linear. Li and Yang obtained a \(3.1n-o(n)\) lower bound over the complete binary basis \(\mathcal B_2\).

Carmosino, Dang, and Jackman (2026) formalize simplification over the DeMorgan and \(\{\land,\lor,\oplus\}\) bases as convergent term-graph rewriting. They also prove that an analogous convergent simplification system does not exist over \(\mathcal U_2\) and \(\mathcal B_2\), and they connect gate elimination with constructive lower bounds through refuter algorithms.

This identifies a precise local frontier. Improving a linear constant is valuable, but no sequence of constant-factor improvements alone yields the superpolynomial lower bound needed for SAT. A successful unrestricted-circuit route needs either a potential that compounds across scales or a transfer theorem converting a local invariant into qualitatively stronger global growth.

## 4. Algorithms to lower bounds

Williams proved NEXP is not contained in ACC by deriving circuit lower bounds from faster algorithms for the same circuit class. The central methodological lesson is exact model matching: the algorithm and the resulting lower bound concern the same class.

Chen, Tal, and Wang (STOC 2026; ECCC TR26-039) obtain a superquadratic lower bound for depth-two linear threshold circuits. They construct a function in \(E^{NP}\) requiring \(n^{2.5-\varepsilon}\)-size \(\mathrm{THR}\circ\mathrm{THR}\) circuits for every \(\varepsilon>0\), via a \(2^{n-n^{\Omega(\varepsilon)}}\)-time acceptance-probability algorithm and Williams' transfer method.

This is significant progress for a difficult restricted class, but two transfers remain absent for P versus NP:

1. \(\mathrm{THR}\circ\mathrm{THR}\) is not the unrestricted Boolean-circuit model; and
2. the hard function is placed in \(E^{NP}\), not NP.

The repository's algorithms-to-lower-bounds route therefore records the circuit class, hard-function class, running-time saving, advice, promise, and uniformity assumptions for every proposed transfer.

## 5. Range avoidance, refuters, and near-maximum lower bounds

Ren and Williams (2026) prove a near-maximum \(2^n/n\) circuit lower bound for \(E^{\mathrm{prMA}}/_1\), using range avoidance, an iterative win–win argument, the PCP theorem, and an analysis of bounded-round NP queries with bounded witness length.

This demonstrates that almost-maximal explicit hardness can be obtained in an exponential-time class with promise-MA access and one advice bit. It does not yet yield an NP circuit lower bound. The decisive missing step is not only quantitative: the hard family must be generated uniformly inside NP while retaining the required lower bound against unrestricted polynomial-size circuits.

Constructive refuters remain a promising interface. A refuter receives a candidate circuit and returns an input on which it fails. The repository explores whether local refuters over restrictions can be organized into presentation-invariant sections whose failure to glue produces a quantitative obstruction. That program still requires a noncircular circuit-size bridge.

## 6. Strong lower bounds in restricted models

### Monotone circuits

Anup Rao (ECCC TR26-129, revision 4) proves an
\[
\exp(\widetilde\Omega(\sqrt n))
\]
monotone circuit lower bound for detecting perfect matchings in bipartite graphs, using a spread-matching lemma. This is an exponential lower bound for an explicit problem, but monotone circuits forbid negations. General circuits may exploit cancellation unavailable in the monotone model, so a monotone lower bound does not automatically transfer to ordinary Boolean circuits.

The transferable research question is therefore not whether the monotone bound is large, but whether its combinatorial bottleneck admits a lifting theorem robust to negation. No such transfer is assumed here.

### Depth-two threshold circuits

The \(n^{2.5-\varepsilon}\) lower bound of Chen–Tal–Wang breaks the previous subquadratic frontier for \(\mathrm{THR}\circ\mathrm{THR}\). It provides a concrete algorithmic template to test on richer classes, but unrestricted-circuit closure under depth reduction is unavailable at the parameters needed for P versus NP.

### Noncommutative arithmetic circuits

Ran Raz (2026) proves an \(\Omega(n^{1.5})\) product-gate lower bound for an explicit degree-\(n\), \(n\)-variate polynomial in the noncommutative arithmetic model, and more generally \(\Omega(d\sqrt n)\) for degree \(d\). This is a genuine polynomial improvement in algebraic complexity. However, noncommutative arithmetic circuits and Boolean circuits for SAT are different models. A Boolean consequence would require an explicit simulation or lifting theorem with controlled overhead; none is inferred merely from the magnitude of the arithmetic lower bound.

## 7. Proof complexity and bounded arithmetic

Proof complexity translates lower bounds into the inability of proof systems to produce short proofs. Bounded arithmetic asks which complexity statements can be proved in weak theories.

Atserias and Müller (2026) show that \(S^1_2\), a theory formalizing polynomial-time reasoning, is consistent with an EXP-versus-\(P/poly\) separation. This advances the metamathematics of lower bounds while leaving the external NP-versus-\(P/poly\) question unresolved.

A decisive proof-complexity route would need either a lower bound for a sufficiently strong system such as Extended Frege, together with a proved transfer to circuit complexity, or a new transfer theorem bypassing that bottleneck. Lower bounds for Resolution, bounded-depth Frege, polynomial calculus fragments, or depth-restricted systems must not be silently promoted to general circuit lower bounds.

## 8. Topology, geometry, and presentation invariance

Topology has rigorous successes in discrete complexity, including evasiveness, Borsuk–Ulam methods, communication complexity, and sign-rank. Frick, Hosseini, and Vasileuski (2026) construct a \(\mathbb Z_2\)-topological sign-complex framework whose equivariant index lower-bounds sign-rank and gives essentially tight Gap Hamming Distance bounds in new regimes.

The methodological requirement is exact:

\[
\text{topological index}
\Longrightarrow
\text{standard complexity measure}.
\]

Finding a cycle in a machine or verifier presentation is not enough. The repository now formalizes two presentation no-go mechanisms:

1. ignored nonempty certificate padding multiplies the accepting-certificate fiber by an arbitrary dummy type while preserving the recognized language; and
2. two constant-time, rank-increasing presentations of the same easy language can have different induced-cycle structure in their underlying trace graphs: a direct edge has no induced four-cycle, whereas a dummy two-branch diamond has a chordless square.

Thus raw witness multiplicity and raw trace-cycle structure are not language invariants. A viable topological route must first pass to a resource-sensitive localization that removes such artifacts without discarding the cost information required for a lower bound.

## 9. Audit of a claimed homological separation

The preprint arXiv:2510.17829 claims a complete homological proof of \(P\ne NP\). The repository's audit gives independent counterexamples to four indispensable steps:

1. face deletion is not closed on the proposed directed computation paths;
2. ordinary many-one reductions do not supply the claimed additive category or empty-language zero object;
3. the normalized verification-order average is not additive under concatenation; and
4. the proposed contracting homotopy fails on a one-edge computation.

Therefore that manuscript does not establish its stated chain complex or a P-versus-NP separation. This conclusion refutes the published construction, not every possible use of topology in complexity theory.

## 10. Research synthesis and present priority

The most credible combined target remains a pair of bridge theorems:

\[
\text{small circuit}
\Longrightarrow
\text{vanishing or quantitatively bounded invariant},
\]

\[
\text{explicit NP target}
\Longrightarrow
\text{nonvanishing or superpolynomially growing invariant}.
\]

The literature suggests the following priorities:

1. use convergent gate elimination and refuters only as calibrated local components, not as an assumed unrestricted lower bound;
2. extract model-preserving transfer lemmas from the 2026 threshold and range-avoidance advances;
3. investigate whether spread-matching or noncommutative-rank phenomena survive a rigorously proved lifting to richer models;
4. construct the resource-sensitive verifier localization before assigning topological significance to traces; and
5. audit naturalness, relativization, algebrization, uniformity, and hard-function complexity at the first nonstandard lemma.

No surveyed result supplies the missing SAT-versus-general-circuit lower bound or a worst-case polynomial-time SAT algorithm. The central problem therefore remains an explicit proof obligation rather than a conclusion imported from nearby models.

## References

- T. Baker, J. Gill, R. Solovay, “Relativizations of the P =? NP Question,” *SIAM Journal on Computing* 4 (1975).
- S. Cook, “The Complexity of Theorem-Proving Procedures,” STOC (1971).
- L. Levin, “Universal Search Problems,” *Problems of Information Transmission* (1973).
- A. Razborov, S. Rudich, “Natural Proofs,” *Journal of Computer and System Sciences* 55 (1997).
- S. Aaronson, A. Wigderson, “Algebrization: A New Barrier in Complexity Theory,” *ACM Transactions on Computation Theory* 1 (2009).
- R. Williams, “Nonuniform ACC Circuit Lower Bounds,” *Journal of the ACM* 61 (2014).
- J. Li, T. Yang, unrestricted \(\mathcal B_2\) circuit lower bounds, STOC (2022).
- M. Carmosino, N. Dang, T. Jackman, “Convergent Gate Elimination and Constructive Circuit Lower Bounds,” arXiv:2602.17942 (2026).
- L. Chen, A. Tal, Y. Wang, “Superquadratic Lower Bounds for Depth-2 Linear Threshold Circuits,” STOC 2026; ECCC TR26-039.
- H. Ren, R. Williams, “Near-Maximum Circuit Lower Bounds for Exponential Time with Merlin-Arthur Queries,” arXiv:2607.09963; ECCC TR26-118 (2026).
- A. Rao, “Monotone Circuit Lower Bounds from Spread Matchings,” ECCC TR26-129, revision 4 (2026).
- R. Raz, “Polynomial Lower Bounds for Arithmetic Circuits over Non-Commutative Rings,” arXiv:2604.22006; ECCC TR26-061 (2026).
- R. Raz, “A Note on Natural-Proofs for Super-Linear Lower Bounds for Linear Functions,” ECCC TR26-008, revision 1 (2026).
- A. Atserias, M. Müller, “From Gödel Incompleteness to the Consistency of Circuit Lower Bounds,” arXiv:2604.25251 (2026).
- F. Frick, K. Hosseini, A. Vasileuski, “A \(\mathbb Z_2\)-Topological Framework for Sign-rank Lower Bounds,” arXiv:2604.01510 (2026).
- J.-G. Tang, “A Homological Separation of P from NP via Computational Topology and Category Theory,” arXiv:2510.17829v2.
