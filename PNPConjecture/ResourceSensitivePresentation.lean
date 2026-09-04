import PNPConjecture.VerifierSemanticQuotient

namespace PNPConjecture

universe u v w

/-- A worst-case resource profile indexed by input length. -/
def CostProfile : Type := Nat → Nat

/--
Two cost profiles are equivalent when a single multiplicative constant bounds
each by the other at every input length.
-/
def ConstantFactorEquivalent (left right : CostProfile) : Prop :=
  ∃ factor : Nat, ∀ n,
    left n ≤ factor * right n ∧
    right n ≤ factor * left n

theorem constantFactorEquivalent_refl (profile : CostProfile) :
    ConstantFactorEquivalent profile profile := by
  refine ⟨1, ?_⟩
  intro n
  simp

theorem constantFactorEquivalent_symm
    {left right : CostProfile}
    (equivalent : ConstantFactorEquivalent left right) :
    ConstantFactorEquivalent right left := by
  rcases equivalent with ⟨factor, bounds⟩
  refine ⟨factor, ?_⟩
  intro n
  exact ⟨(bounds n).2, (bounds n).1⟩

theorem constantFactorEquivalent_trans
    {first second third : CostProfile}
    (firstSecond : ConstantFactorEquivalent first second)
    (secondThird : ConstantFactorEquivalent second third) :
    ConstantFactorEquivalent first third := by
  rcases firstSecond with ⟨firstFactor, firstBounds⟩
  rcases secondThird with ⟨secondFactor, secondBounds⟩
  refine ⟨firstFactor * secondFactor, ?_⟩
  intro n
  constructor
  · calc
      first n ≤ firstFactor * second n := (firstBounds n).1
      _ ≤ firstFactor * (secondFactor * third n) :=
        Nat.mul_le_mul_left firstFactor (secondBounds n).1
      _ = (firstFactor * secondFactor) * third n := by
        simp [Nat.mul_assoc]
  · calc
      third n ≤ secondFactor * second n := (secondBounds n).2
      _ ≤ secondFactor * (firstFactor * first n) :=
        Nat.mul_le_mul_left secondFactor (firstBounds n).2
      _ = (firstFactor * secondFactor) * first n := by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]

/-- A verifier presentation together with an explicit resource profile. -/
structure ResourcePresentation (Input : Type u) where
  presentation : VerifierPresentation.{u, v} Input
  cost : CostProfile

/--
Resource equivalence retains the recognized language and the asymptotic cost
profile up to a constant multiplicative factor.
-/
def SameResourceClass {Input : Type u}
    (left right : ResourcePresentation.{u, v} Input) : Prop :=
  SameLanguage left.presentation right.presentation ∧
    ConstantFactorEquivalent left.cost right.cost

theorem sameResourceClass_refl {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input) :
    SameResourceClass resource resource := by
  exact ⟨sameLanguage_refl resource.presentation,
    constantFactorEquivalent_refl resource.cost⟩

theorem sameResourceClass_symm {Input : Type u}
    {left right : ResourcePresentation.{u, v} Input}
    (equivalent : SameResourceClass left right) :
    SameResourceClass right left := by
  exact ⟨sameLanguage_symm equivalent.1,
    constantFactorEquivalent_symm equivalent.2⟩

theorem sameResourceClass_trans {Input : Type u}
    {first second third : ResourcePresentation.{u, v} Input}
    (firstSecond : SameResourceClass first second)
    (secondThird : SameResourceClass second third) :
    SameResourceClass first third := by
  exact ⟨sameLanguage_trans firstSecond.1 secondThird.1,
    constantFactorEquivalent_trans firstSecond.2 secondThird.2⟩

/-- Resource equivalence is a setoid on costed verifier presentations. -/
def resourcePresentationSetoid (Input : Type u) :
    Setoid (ResourcePresentation.{u, v} Input) where
  r := SameResourceClass
  iseqv := {
    refl := sameResourceClass_refl
    symm := sameResourceClass_symm
    trans := sameResourceClass_trans
  }

/--
A first resource-sensitive quotient.  It is deliberately only a calibration
object: the cost profile is supplied explicitly rather than derived from a
formal machine semantics.
-/
def ResourceVerifier (Input : Type u) :=
  Quotient (resourcePresentationSetoid.{u, v} Input)

/-- The resource-equivalence class of one costed presentation. -/
def resourceClass {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input) :
    ResourceVerifier.{u, v} Input :=
  Quotient.mk _ resource

/-- Add an ignored dummy certificate factor without changing the cost profile. -/
def padResourcePresentation {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v) : ResourcePresentation.{u, v} Input where
  presentation := padPresentation resource.presentation Dummy
  cost := resource.cost

/-- Nonempty dummy padding preserves the resource-equivalence class. -/
theorem padResourcePresentation_sameResourceClass {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    SameResourceClass (padResourcePresentation resource Dummy) resource := by
  exact ⟨padPresentation_sameLanguage resource.presentation Dummy,
    constantFactorEquivalent_refl resource.cost⟩

/-- Nonempty padding becomes literal equality in the resource quotient. -/
theorem padResourcePresentation_resourceClass_eq {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    resourceClass (padResourcePresentation resource Dummy) =
      resourceClass resource := by
  apply Quotient.sound
  exact padResourcePresentation_sameResourceClass resource Dummy

/-- Every invariant defined on the resource quotient ignores dummy padding. -/
theorem resource_quotient_invariant_ignores_padding
    {Input : Type u}
    {Invariant : Type w}
    (invariant : ResourceVerifier.{u, v} Input → Invariant)
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    invariant (resourceClass (padResourcePresentation resource Dummy)) =
      invariant (resourceClass resource) := by
  rw [padResourcePresentation_resourceClass_eq]

end PNPConjecture
