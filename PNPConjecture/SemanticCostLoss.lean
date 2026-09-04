import PNPConjecture.ResourceSensitivePresentation

namespace PNPConjecture

/-- A constant unit resource profile. -/
def constantOneCost : CostProfile :=
  fun _ => 1

/-- A genuinely growing resource profile. -/
def linearGrowingCost : CostProfile :=
  fun n => n + 1

/-- Constant and linearly growing profiles are not constant-factor equivalent. -/
theorem constantOne_not_equivalent_linearGrowing :
    ¬ ConstantFactorEquivalent constantOneCost linearGrowingCost := by
  intro equivalent
  rcases equivalent with ⟨factor, bounds⟩
  have impossible := (bounds factor).2
  simp [constantOneCost, linearGrowingCost] at impossible
  have factor_lt_itself : factor < factor :=
    Nat.lt_of_lt_of_le (Nat.lt_succ_self factor) impossible
  exact (Nat.lt_irrefl factor) factor_lt_itself

/-- A fixed verifier for the universal language on `Unit`. -/
def alwaysAcceptPresentation : VerifierPresentation Unit where
  Certificate := Unit
  verifier := fun _ _ => true

/-- The same verifier annotated with constant cost. -/
def constantCostPresentation : ResourcePresentation Unit where
  presentation := alwaysAcceptPresentation
  cost := constantOneCost

/-- The same verifier annotated with linearly growing cost. -/
def growingCostPresentation : ResourcePresentation Unit where
  presentation := alwaysAcceptPresentation
  cost := linearGrowingCost

/-- The pure semantic quotient identifies the two presentations literally. -/
theorem semantic_classes_equal_despite_cost_gap :
    semanticClass constantCostPresentation.presentation =
      semanticClass growingCostPresentation.presentation := by
  rfl

/-- The resource-sensitive relation distinguishes the two cost annotations. -/
theorem resource_classes_distinguish_cost_gap :
    ¬ SameResourceClass
      constantCostPresentation growingCostPresentation := by
  intro sameClass
  exact constantOne_not_equivalent_linearGrowing sameClass.2

/--
The semantic quotient loses asymptotic cost information: two objects can be
identical semantically while lying in different resource classes.
-/
theorem semantic_quotient_forgets_asymptotic_cost :
    semanticClass constantCostPresentation.presentation =
        semanticClass growingCostPresentation.presentation ∧
      ¬ SameResourceClass
        constantCostPresentation growingCostPresentation := by
  exact ⟨semantic_classes_equal_despite_cost_gap,
    resource_classes_distinguish_cost_gap⟩

end PNPConjecture
