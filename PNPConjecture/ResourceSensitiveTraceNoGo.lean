import PNPConjecture.DiamondTraceNoGo
import PNPConjecture.ResourceSensitivePresentation

namespace PNPConjecture

universe u

/-- A one-step constant worst-case cost profile. -/
def linearTraceCost : CostProfile :=
  fun _ => 1

/-- A two-step constant worst-case cost profile. -/
def diamondTraceCost : CostProfile :=
  fun _ => 2

/-- The two constant profiles differ only by a multiplicative factor of two. -/
theorem linear_diamond_cost_profiles_equivalent :
    ConstantFactorEquivalent linearTraceCost diamondTraceCost := by
  refine ⟨2, ?_⟩
  intro n
  simp [linearTraceCost, diamondTraceCost]

/-- Same recognized language and equivalent asymptotic cost profile. -/
def SameLanguageAndResourceClass {Input : Type u}
    (leftLanguage rightLanguage : Input → Prop)
    (leftCost rightCost : CostProfile) : Prop :=
  leftLanguage = rightLanguage ∧
    ConstantFactorEquivalent leftCost rightCost

/--
The linear and diamond computations are resource-equivalent at the level of
recognized language and constant-factor cost profiles.
-/
theorem linear_diamond_same_language_and_resource_class :
    SameLanguageAndResourceClass
      linearLanguage diamondLanguage
      linearTraceCost diamondTraceCost := by
  exact ⟨linear_and_diamond_recognize_same_language,
    linear_diamond_cost_profiles_equivalent⟩

/--
Even after retaining the running-time profile up to constant factors, the raw
induced-cycle property changes.  Thus the property cannot descend to this
resource-equivalence class.
-/
theorem resource_equivalent_traces_have_different_cycle_structure :
    SameLanguageAndResourceClass
        linearLanguage diamondLanguage
        linearTraceCost diamondTraceCost ∧
      ¬ HasInducedFourCycle linearStep ∧
      HasInducedFourCycle diamondStep := by
  exact ⟨linear_diamond_same_language_and_resource_class,
    linear_has_no_induced_four_cycle,
    diamond_has_induced_four_cycle⟩

/--
It is inconsistent to require induced-four-cycle structure to be preserved by
all same-language, constant-factor-equivalent presentation changes.
-/
theorem induced_four_cycle_not_invariant_under_resource_equivalence :
    ¬ (
      SameLanguageAndResourceClass
          linearLanguage diamondLanguage
          linearTraceCost diamondTraceCost →
        (HasInducedFourCycle linearStep ↔
          HasInducedFourCycle diamondStep)) := by
  intro allegedInvariant
  have cycleEquivalence :=
    allegedInvariant linear_diamond_same_language_and_resource_class
  exact linear_has_no_induced_four_cycle
    (cycleEquivalence.mpr diamond_has_induced_four_cycle)

end PNPConjecture
