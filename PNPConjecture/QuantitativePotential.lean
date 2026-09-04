import Std

namespace PNPConjecture

universe u

/-- A sequence of exactly `steps` valid construction steps. -/
inductive StepDerivation {State : Type u}
    (step : State → State → Prop) : Nat → State → State → Prop where
  | zero (state : State) : StepDerivation step 0 state state
  | tail {steps : Nat} {start middle finish : State} :
      StepDerivation step steps start middle →
      step middle finish →
      StepDerivation step (steps + 1) start finish

/--
Quantitative accumulation lemma.

If one legal construction step increases a potential by at most `delta`, then
`steps` construction steps increase it by at most `steps * delta`.  A Boolean
circuit represented as a sequence of gate additions is an intended instance.
-/
theorem derivation_potential_bound
    {State : Type u}
    (step : State → State → Prop)
    (potential : State → Nat)
    (delta : Nat)
    (localBound : ∀ {before after},
      step before after →
        potential after ≤ potential before + delta)
    {steps : Nat} {start finish : State}
    (derivation : StepDerivation step steps start finish) :
    potential finish ≤ potential start + steps * delta := by
  induction derivation with
  | zero state =>
      simp
  | tail previous edge inductionHypothesis =>
      calc
        potential _ ≤ potential _ + delta := localBound edge
        _ ≤ (potential _ + _ * delta) + delta :=
          Nat.add_le_add_right inductionHypothesis delta
        _ = potential _ + (_ + 1) * delta := by
          simp [Nat.add_mul, Nat.add_assoc]

/--
A target whose potential exceeds the accumulated budget cannot be constructed
in the stated number of steps.
-/
theorem potential_gap_rules_out_short_derivation
    {State : Type u}
    (step : State → State → Prop)
    (potential : State → Nat)
    (delta : Nat)
    (localBound : ∀ {before after},
      step before after →
        potential after ≤ potential before + delta)
    {steps : Nat} {start finish : State}
    (gap : potential start + steps * delta < potential finish) :
    ¬ StepDerivation step steps start finish := by
  intro derivation
  have bound := derivation_potential_bound
    step potential delta localBound derivation
  exact (not_lt_of_ge bound) gap

/--
Threshold form of the same bridge: if the target has potential at least
`threshold`, but the entire `steps`-step budget is below that threshold, no
such derivation exists.
-/
theorem threshold_rules_out_short_derivation
    {State : Type u}
    (step : State → State → Prop)
    (potential : State → Nat)
    (delta threshold : Nat)
    (localBound : ∀ {before after},
      step before after →
        potential after ≤ potential before + delta)
    {steps : Nat} {start finish : State}
    (targetLarge : threshold ≤ potential finish)
    (budgetSmall : potential start + steps * delta < threshold) :
    ¬ StepDerivation step steps start finish := by
  intro derivation
  have bound := derivation_potential_bound
    step potential delta localBound derivation
  have thresholdBound :
      threshold ≤ potential start + steps * delta :=
    le_trans targetLarge bound
  exact (not_lt_of_ge thresholdBound) budgetSmall

end PNPConjecture
