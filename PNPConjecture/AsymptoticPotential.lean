import PNPConjecture.QuantitativePotential

namespace PNPConjecture

universe u

/-- A size profile is polynomially bounded with an explicit coefficient and degree. -/
def PolynomiallyBounded (size : Nat → Nat) : Prop :=
  ∃ coefficient degree : Nat, ∀ n,
    size n ≤ coefficient * (n + 1) ^ degree

/--
A family-level quantitative circuit-soundness bridge.

Assume each length-`n` target is constructed from a start state in
`derivationSize n` legal steps. If every step raises a potential by at most
`delta n`, while the target potential eventually exceeds the entire budget of
every polynomial step bound, then the derivation-size family is not
polynomially bounded.
-/
theorem superpolynomial_potential_rules_out_polynomial_derivation_family
    {State : Type u}
    (step : Nat → State → State → Prop)
    (potential : Nat → State → Nat)
    (delta : Nat → Nat)
    (start finish : Nat → State)
    (derivationSize : Nat → Nat)
    (localBound : ∀ n {before after},
      step n before after →
        potential n after ≤ potential n before + delta n)
    (derivations : ∀ n,
      StepDerivation (step n) (derivationSize n)
        (start n) (finish n))
    (targetGrowth : ∀ coefficient degree : Nat,
      ∃ n,
        potential n (start n) +
            (coefficient * (n + 1) ^ degree) * delta n <
          potential n (finish n)) :
    ¬ PolynomiallyBounded derivationSize := by
  intro polynomialBound
  rcases polynomialBound with
    ⟨coefficient, degree, sizeBound⟩
  rcases targetGrowth coefficient degree with
    ⟨n, growth⟩
  have constructionBound :
      potential n (finish n) ≤
        potential n (start n) +
          derivationSize n * delta n :=
    derivation_potential_bound
      (step n) (potential n) (delta n)
      (localBound n) (derivations n)
  have multipliedSizeBound :
      derivationSize n * delta n ≤
        (coefficient * (n + 1) ^ degree) * delta n := by
    calc
      derivationSize n * delta n =
          delta n * derivationSize n := by
        simp [Nat.mul_comm]
      _ ≤ delta n *
          (coefficient * (n + 1) ^ degree) :=
        Nat.mul_le_mul_left (delta n) (sizeBound n)
      _ = (coefficient * (n + 1) ^ degree) *
          delta n := by
        simp [Nat.mul_comm]
  have fullBudgetBound :
      potential n (start n) +
          derivationSize n * delta n ≤
        potential n (start n) +
          (coefficient * (n + 1) ^ degree) * delta n :=
    Nat.add_le_add_left multipliedSizeBound
      (potential n (start n))
  have targetWithinPolynomialBudget :
      potential n (finish n) ≤
        potential n (start n) +
          (coefficient * (n + 1) ^ degree) * delta n :=
    Nat.le_trans constructionBound fullBudgetBound
  have impossible :
      potential n (start n) +
          (coefficient * (n + 1) ^ degree) * delta n <
        potential n (start n) +
          (coefficient * (n + 1) ^ degree) * delta n :=
    Nat.lt_of_lt_of_le growth targetWithinPolynomialBudget
  exact (Nat.lt_irrefl _) impossible

/--
Contrapositive audit form: if a target family has polynomial-size
derivations, no potential satisfying the stated local bound can have the
claimed superpolynomial target-growth property.
-/
theorem polynomial_derivation_family_blocks_superpolynomial_potential_growth
    {State : Type u}
    (step : Nat → State → State → Prop)
    (potential : Nat → State → Nat)
    (delta : Nat → Nat)
    (start finish : Nat → State)
    (derivationSize : Nat → Nat)
    (localBound : ∀ n {before after},
      step n before after →
        potential n after ≤ potential n before + delta n)
    (derivations : ∀ n,
      StepDerivation (step n) (derivationSize n)
        (start n) (finish n))
    (polynomialBound : PolynomiallyBounded derivationSize) :
    ¬ (∀ coefficient degree : Nat,
      ∃ n,
        potential n (start n) +
            (coefficient * (n + 1) ^ degree) * delta n <
          potential n (finish n)) := by
  intro allegedGrowth
  exact
    (superpolynomial_potential_rules_out_polynomial_derivation_family
      step potential delta start finish derivationSize
      localBound derivations allegedGrowth)
      polynomialBound

end PNPConjecture
