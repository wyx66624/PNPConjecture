# Deep research on the four decisive P-versus-NP gaps

Last updated: 2026-09-04

## Executive status

The four gaps identified in `RESEARCH_STATUS.md` have been attacked directly. This pass establishes new resource-sensitive quotient constructions, explicit simulation theorems, a general trace-presentation no-go theorem, a quantitative potential bridge, and a tautological-obstruction diagnostic. All theorem statements listed as **FORMALIZED** below have companion Lean proofs.

This pass does **not** prove `P = NP` or `P ≠ NP`. The remaining central step is still a superpolynomial lower bound for an explicit NP family against unrestricted polynomial-size Boolean circuits, or a worst-case polynomial-time algorithm for SAT.

## 1. Resource-sensitive localization

### 1.1 Constant-factor cost equivalence

A cost profile is a function

\[
T:\mathbb N\to\mathbb N.
\]

Define

\[
T\asymp_c U
\]

when there is one constant \(K\) such that for every input length \(n\),

\[
T(n)\le K U(n),\qquad U(n)\le K T(n).
\]

The relation is reflexive, symmetric, and transitive. Transitivity follows by multiplying the two comparison constants. Therefore same-language equivalence together with \(\asymp_c\) is a setoid on costed verifier presentations.

**Status: FORMALIZED.** See `PNPConjecture/ResourceSensitivePresentation.lean`.

### 1.2 A first resource quotient

A resource presentation is

\[
\mathcal V=(W,V,T),
\]

where \(V(x,w)\) is a Boolean verifier and \(T(n)\) is an explicit worst-case cost profile. Two presentations are placed in the same first resource class when they recognize the same language and their profiles are constant-factor equivalent.

This quotient is stronger than the pure semantic quotient because it retains an asymptotic cost class. Ignored nonempty certificate padding preserves both the language and the supplied cost profile, and hence becomes literal equality in the resource quotient.

**Status: FORMALIZED.** See `ResourceSensitivePresentation.lean`.

### 1.3 Why the pure semantic quotient is too coarse

Let one and the same always-accepting verifier be equipped first with

\[
T_1(n)=1
\]

and then with

\[
T_2(n)=n+1.
\]

The two verifier presentations are literally identical after forgetting cost. However, \(T_1\) and \(T_2\) are not constant-factor equivalent: if a factor \(K\) existed, evaluate the inequality \(n+1\le K\) at \(n=K\), obtaining \(K+1\le K\).

Thus the semantic quotient identifies objects that the resource quotient separates.

**Status: FORMALIZED.** See `PNPConjecture/SemanticCostLoss.lean`.

### 1.4 Explicit constant-overhead simulations

A certificate simulation from \(\mathcal V\) to \(\mathcal W\) is a map on certificates that preserves the verifier answer for every input. A resource simulation additionally requires the target cost profile to be constant-factor dominated by the source profile. Bidirectional resource simulations form an equivalence relation by identity, reversal, and composition.

For ignored nonempty padding,

\[
V_D(x,(d,w))=V(x,w),
\]

the forward simulation chooses one dummy value and the backward simulation projects it away. Both have unit cost overhead. Hence padding is equality in the explicit resource-simulation quotient.

**Status: FORMALIZED.** See `PNPConjecture/ResourceSimulation.lean`.

### 1.5 General trace-gadget no-go theorem

For the current abstract trace semantics,

\[
L_{G,s,t}(x)\iff s\leadsto_G t.
\]

If \(s\leadsto_G t\), the represented language is the universal language, independently of all other graph structure. Consequently, any two reachable trace gadgets recognize the same language.

This generalizes the linear-versus-diamond example. Moreover, the linear and diamond presentations have cost profiles \(1\) and \(2\), which are constant-factor equivalent, but only the diamond has an induced four-cycle in its underlying graph. Therefore raw cycle structure is not invariant even after retaining asymptotic cost up to constant factors.

**Status: FORMALIZED.** See `TracePresentationUniversality.lean` and `ResourceSensitiveTraceNoGo.lean`.

### 1.6 What is still missing from localization

The formalized quotient is a calibration object, not yet the final localization required for a circuit lower bound. Its cost profile is externally supplied. A complete theory must derive cost from a formal machine or circuit semantics and prove that every permitted simulation transforms actual running time or circuit size with the advertised overhead. It must also handle:

- state recoding;
- bounded stuttering;
- branch insertion and merging;
- certificate recoding;
- uniform families indexed by input length;
- circuit sharing and fan-out;
- the distinction between time, size, depth, advice, and uniformity.

The first gap is therefore narrowed, not closed.

## 2. Circuit-soundness bridge

### 2.1 Quantitative accumulation theorem

Let \(S\) be a state of a construction process, let

\[
S\longrightarrow S'
\]

mean that one legal gate or construction step is added, and let

\[
\Phi:S\to\mathbb N
\]

be a potential. Suppose every one-step extension satisfies

\[
\Phi(S')\le \Phi(S)+\delta.
\]

Then every derivation of exactly \(s\) steps satisfies

\[
\boxed{\Phi(S_s)\le \Phi(S_0)+s\delta.}
\]

#### Proof

Induct on \(s\). For \(s=0\), the start and final states coincide. For the induction step, write the last transition as \(S_s\to S_{s+1}\). The local hypothesis and induction hypothesis give

\[
\Phi(S_{s+1})
\le \Phi(S_s)+\delta
\le \Phi(S_0)+s\delta+\delta
=\Phi(S_0)+(s+1)\delta.
\]

Therefore, if a target state has

\[
\Phi(S_{\mathrm{target}})>
\Phi(S_0)+s\delta,
\]

no size-\(s\) construction can reach it.

**Status: FORMALIZED.** See `PNPConjecture/QuantitativePotential.lean`.

### 2.2 Circuit interpretation

Represent a fan-in-two circuit as a sequence of library extensions. Initially the library contains input variables and constants. One step appends the output of a legal Boolean gate whose inputs are already in the library. A concrete circuit-soundness proof must supply a potential satisfying:

1. **Resource invariance:** equivalent encodings and constant-overhead simulations have the same potential, or controlled distortion.
2. **Local Lipschitz bound:** adding one unrestricted binary gate changes the potential by at most \(\delta(n)\).
3. **Target threshold:** every library containing the exact target function has potential at least \(T(n)\).
4. **Initial bound:** the input library has potential at most \(A(n)\).

The theorem then yields

\[
\operatorname{CircuitSize}(f_n)
\ge
\frac{T(n)-A(n)}{\delta(n)}.
\]

To separate NP from `P/poly`, the right side must exceed every polynomial for an explicit NP family.

### 2.3 Resource-Localized Obstruction Profiles

This pass proposes the following refinement of VIOT.

A **Resource-Localized Obstruction Profile (RLOP)** consists of:

- a resource-simulation quotient of presentations;
- a gate-construction category or higher rewriting groupoid;
- a presentation-invariant potential or index \(\Phi_f\);
- a local gate-growth theorem;
- an explicit target-growth theorem.

RLOP separates the two jobs that were conflated in raw trace homology:

- quotienting away implementation artifacts;
- proving quantitative growth under genuine computational operations.

The quantitative accumulation theorem supplies the abstract bridge. The missing theorem is a nontrivial RLOP for the unrestricted binary basis \(\mathcal B_2\).

## 3. SAT nonvanishing

### 3.1 Tautological disagreement obstruction

For a candidate \(C\) and target \(f\), define

\[
D(C,f)\iff \exists x\; C(x)\ne f(x).
\]

Then

\[
C=f
\iff
\neg D(C,f),
\]

and for every candidate class \(\mathcal C\),

\[
\boxed{
\forall C\in\mathcal C\;D(C,f)
\iff
\nexists C\in\mathcal C\text{ computing }f.
}
\]

#### Proof

The forward implication follows because an exact candidate cannot have a disagreement. Conversely, if no exact candidate exists, each candidate fails pointwise somewhere by function extensionality and classical excluded middle.

**Status: FORMALIZED.** See `PNPConjecture/DisagreementObstruction.lean`.

### 3.2 Consequence

Using disagreement itself as the obstruction merely renames the desired lower bound. It does not make SAT nonvanishing easier. A useful obstruction must provide an independently provable structural implication of the form

\[
\text{small circuit structure}
\Longrightarrow
\text{bounded potential},
\]

while a separate, explicit argument gives

\[
\text{SAT structure}
\Longrightarrow
\text{superpolynomial potential}.
\]

The second implication is the unresolved core. No current theorem in this repository proves it for unrestricted circuits.

### 3.3 Candidate-relative refuters

A promising non-tautological orientation is candidate-relative. Given a small circuit \(C\), construct an explicit input \(x_C\) on which it fails. This avoids defining one large property of truth tables and instead studies a relation depending jointly on the target and the candidate.

However, constructivity is not free. Chen, Jin, Santhanam, and Williams showed that constructive separations are closely tied to major complexity separations, and the 2026 gate-elimination work demonstrates refuters only in regimes where a lower-bound argument is already available. Therefore a SAT refuter against unrestricted polynomial-size circuits would itself be a breakthrough, not a routine extraction step.

## 4. Barrier escape

### 4.1 Relativization

The resource quotient and the quantitative accumulation lemma relativize: they remain valid if oracle gates are added. Hence neither can be the decisive nonrelativizing ingredient.

A successful RLOP must use a target-specific fact that fails under arbitrary oracle substitution. Candidates include a proof-theoretic reflection principle, a syntax-sensitive self-reduction, or a uniform construction that cannot be reproduced with an arbitrary oracle. This ingredient must be isolated as an exact lemma rather than asserted rhetorically.

### 4.2 Natural proofs

A truth-table property used against general circuits must be audited for constructivity, largeness, and usefulness. Candidate-relative refuter relations may avoid the standard largeness condition because they are not a single dense property of functions. This is a possible escape route, but the refuter literature shows that strong constructivity can itself encode the hard separation.

Therefore the repository will require every proposed target-growth theorem to state:

- whether its predicate is decidable from the truth table;
- its density among all functions;
- whether it depends on the candidate circuit;
- whether pseudorandom functions would satisfy or fool it.

### 4.3 Algebrization

The current quotient and potential lemmas are compatible with algebraic extensions and therefore do not escape algebrization. A decisive theorem must identify a step destroyed by low-degree algebraic oracle extension. Merely rewriting a Boolean condition as a polynomial does not suffice.

### 4.4 Restricted-model transfer

Results for monotone circuits, threshold circuits of fixed depth, noncommutative arithmetic circuits, formulas, or proof systems cannot be promoted to unrestricted Boolean circuits without an explicit simulation theorem. The transfer overhead and direction must be proved.

## 5. Evidence from the 2026 frontier

The latest results reinforce the model-transfer diagnosis:

- Chen, Tal, and Wang obtain superquadratic lower bounds for depth-two threshold circuits, but for a hard function in a higher exponential-time class, not SAT against unrestricted circuits (`ECCC TR26-039`).
- Rao obtains exponential lower bounds for monotone circuits detecting perfect matching, but negations destroy the monotone argument (`ECCC TR26-129`).
- Raz obtains \(\Omega(n^{1.5})\) lower bounds for noncommutative arithmetic circuits, but no Boolean SAT transfer is supplied (`ECCC TR26-061`).
- Ren and Williams obtain near-maximum lower bounds in \(E^{\mathrm{prMA}}/_1\), not in NP (`ECCC TR26-118`).
- Carmosino, Dang, and Jackman formalize convergent gate elimination for restricted bases and prove that the analogous convergence fails for \(\mathcal U_2\) and \(\mathcal B_2\) (`arXiv:2602.17942`); their follow-up extracts constructive refuters from known gate-elimination arguments (`arXiv:2604.23958`).
- Li and Yang's \(3.1n-o(n)\) bound remains the explicit unrestricted-binary-circuit benchmark (`ECCC TR21-023`).

These results are major advances, but none closes the SAT-versus-`P/poly` gap.

## 6. Exact remaining theorem sequence

The next valid sequence is:

1. derive cost profiles from a formal uniform circuit or machine semantics;
2. formalize constant-overhead state simulation, stuttering, recoding, and branch insertion;
3. define a non-tautological resource-localized potential on gate-construction states;
4. prove a one-gate Lipschitz theorem over the full basis \(\mathcal B_2\);
5. calibrate the potential by recovering a known restricted lower bound;
6. prove explicit superpolynomial growth for an NP-complete family;
7. identify the exact nonrelativizing and nonalgebrizing lemma and audit naturalness;
8. connect the resulting nonuniform lower bound to `P ≠ NP` and formalize the complete bridge in Lean.

The present pass completes rigorous infrastructure for Steps 1--3 only in simplified calibration models and proves no-go theorems that any future candidate must survive. Steps 4--7 remain open.
