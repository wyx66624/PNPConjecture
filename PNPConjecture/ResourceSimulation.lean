import PNPConjecture.ResourceSensitivePresentation

namespace PNPConjecture

universe u v w

/--
A certificate simulation maps every source certificate to a target certificate
while preserving the verifier's Boolean answer on every input.
-/
structure CertificateSimulation {Input : Type u}
    (source target : VerifierPresentation.{u, v} Input) where
  mapCertificate : source.Certificate → target.Certificate
  preserves : ∀ x certificate,
    target.verifier x (mapCertificate certificate) =
      source.verifier x certificate

/-- Identity certificate simulation. -/
def CertificateSimulation.identity {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input) :
    CertificateSimulation presentation presentation where
  mapCertificate := fun certificate => certificate
  preserves := by
    intro x certificate
    rfl

/-- Composition of certificate simulations. -/
def CertificateSimulation.comp {Input : Type u}
    {first second third : VerifierPresentation.{u, v} Input}
    (firstSecond : CertificateSimulation first second)
    (secondThird : CertificateSimulation second third) :
    CertificateSimulation first third where
  mapCertificate := fun certificate =>
    secondThird.mapCertificate
      (firstSecond.mapCertificate certificate)
  preserves := by
    intro x certificate
    exact Eq.trans
      (secondThird.preserves x
        (firstSecond.mapCertificate certificate))
      (firstSecond.preserves x certificate)

/-- A certificate simulation gives one-way inclusion of recognized languages. -/
theorem certificateSimulation_language_inclusion
    {Input : Type u}
    {source target : VerifierPresentation.{u, v} Input}
    (simulation : CertificateSimulation source target)
    (x : Input)
    (accepted : PresentationRecognizes source x) :
    PresentationRecognizes target x := by
  rcases accepted with ⟨certificate, sourceAccepts⟩
  refine ⟨simulation.mapCertificate certificate, ?_⟩
  calc
    target.verifier x
        (simulation.mapCertificate certificate) =
      source.verifier x certificate :=
        simulation.preserves x certificate
    _ = true := sourceAccepts

/-- Bidirectional certificate simulation. -/
structure CertificateBisimulation {Input : Type u}
    (left right : VerifierPresentation.{u, v} Input) where
  forward : CertificateSimulation left right
  backward : CertificateSimulation right left

/-- Bidirectional certificate simulation implies semantic language equality. -/
theorem certificateBisimulation_sameLanguage
    {Input : Type u}
    {left right : VerifierPresentation.{u, v} Input}
    (bisimulation : CertificateBisimulation left right) :
    SameLanguage left right := by
  intro x
  constructor
  · exact certificateSimulation_language_inclusion
      bisimulation.forward x
  · exact certificateSimulation_language_inclusion
      bisimulation.backward x

/-- A target profile is constant-factor dominated by a source profile. -/
def CostDominatedBy (target source : CostProfile) : Prop :=
  ∃ factor : Nat, ∀ n, target n ≤ factor * source n

theorem costDominatedBy_refl (profile : CostProfile) :
    CostDominatedBy profile profile := by
  refine ⟨1, ?_⟩
  intro n
  simp

theorem costDominatedBy_trans
    {first second third : CostProfile}
    (firstBySecond : CostDominatedBy first second)
    (secondByThird : CostDominatedBy second third) :
    CostDominatedBy first third := by
  rcases firstBySecond with ⟨firstFactor, firstBound⟩
  rcases secondByThird with ⟨secondFactor, secondBound⟩
  refine ⟨firstFactor * secondFactor, ?_⟩
  intro n
  calc
    first n ≤ firstFactor * second n := firstBound n
    _ ≤ firstFactor * (secondFactor * third n) :=
      Nat.mul_le_mul_left firstFactor (secondBound n)
    _ = (firstFactor * secondFactor) * third n := by
      simp [Nat.mul_assoc]

/--
A resource simulation preserves certificate answers and increases the supplied
cost profile by at most a constant factor.
-/
structure ResourceSimulation {Input : Type u}
    (source target : ResourcePresentation.{u, v} Input) where
  certificate :
    CertificateSimulation source.presentation target.presentation
  targetCostBound : CostDominatedBy target.cost source.cost

/-- Identity resource simulation. -/
def ResourceSimulation.identity {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input) :
    ResourceSimulation resource resource where
  certificate := CertificateSimulation.identity resource.presentation
  targetCostBound := costDominatedBy_refl resource.cost

/-- Composition of resource simulations. -/
def ResourceSimulation.comp {Input : Type u}
    {first second third : ResourcePresentation.{u, v} Input}
    (firstSecond : ResourceSimulation first second)
    (secondThird : ResourceSimulation second third) :
    ResourceSimulation first third where
  certificate := CertificateSimulation.comp
    firstSecond.certificate secondThird.certificate
  targetCostBound := costDominatedBy_trans
    secondThird.targetCostBound firstSecond.targetCostBound

/-- Bidirectional resource simulation. -/
structure ResourceBisimulation {Input : Type u}
    (left right : ResourcePresentation.{u, v} Input) where
  forward : ResourceSimulation left right
  backward : ResourceSimulation right left

/-- Identity resource bisimulation. -/
def ResourceBisimulation.identity {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input) :
    ResourceBisimulation resource resource where
  forward := ResourceSimulation.identity resource
  backward := ResourceSimulation.identity resource

/-- Symmetry of resource bisimulation. -/
def ResourceBisimulation.symm {Input : Type u}
    {left right : ResourcePresentation.{u, v} Input}
    (bisimulation : ResourceBisimulation left right) :
    ResourceBisimulation right left where
  forward := bisimulation.backward
  backward := bisimulation.forward

/-- Transitivity of resource bisimulation. -/
def ResourceBisimulation.trans {Input : Type u}
    {first second third : ResourcePresentation.{u, v} Input}
    (firstSecond : ResourceBisimulation first second)
    (secondThird : ResourceBisimulation second third) :
    ResourceBisimulation first third where
  forward := ResourceSimulation.comp
    firstSecond.forward secondThird.forward
  backward := ResourceSimulation.comp
    secondThird.backward firstSecond.backward

/-- Existence of a bidirectional resource simulation. -/
def ResourceSimulationEquivalent {Input : Type u}
    (left right : ResourcePresentation.{u, v} Input) : Prop :=
  Nonempty (ResourceBisimulation left right)

theorem resourceSimulationEquivalent_refl {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input) :
    ResourceSimulationEquivalent resource resource :=
  ⟨ResourceBisimulation.identity resource⟩

theorem resourceSimulationEquivalent_symm {Input : Type u}
    {left right : ResourcePresentation.{u, v} Input}
    (equivalent : ResourceSimulationEquivalent left right) :
    ResourceSimulationEquivalent right left := by
  rcases equivalent with ⟨bisimulation⟩
  exact ⟨ResourceBisimulation.symm bisimulation⟩

theorem resourceSimulationEquivalent_trans {Input : Type u}
    {first second third : ResourcePresentation.{u, v} Input}
    (firstSecond : ResourceSimulationEquivalent first second)
    (secondThird : ResourceSimulationEquivalent second third) :
    ResourceSimulationEquivalent first third := by
  rcases firstSecond with ⟨firstBisimulation⟩
  rcases secondThird with ⟨secondBisimulation⟩
  exact ⟨ResourceBisimulation.trans
    firstBisimulation secondBisimulation⟩

/-- Resource-simulation equivalence is a setoid. -/
def resourceSimulationSetoid (Input : Type u) :
    Setoid (ResourcePresentation.{u, v} Input) where
  r := ResourceSimulationEquivalent
  iseqv := {
    refl := resourceSimulationEquivalent_refl
    symm := resourceSimulationEquivalent_symm
    trans := resourceSimulationEquivalent_trans
  }

/-- A quotient by explicit bidirectional constant-overhead simulations. -/
def SimulatedResourceVerifier (Input : Type u) :=
  Quotient (resourceSimulationSetoid.{u, v} Input)

/-- Quotient class of a resource presentation. -/
def simulatedResourceClass {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input) :
    SimulatedResourceVerifier.{u, v} Input :=
  Quotient.mk _ resource

/-- Forward simulation from an original presentation to its padded version. -/
def paddingForwardSimulation {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    ResourceSimulation resource
      (padResourcePresentation resource Dummy) where
  certificate := {
    mapCertificate := fun certificate =>
      (Classical.choice (inferInstance : Nonempty Dummy), certificate)
    preserves := by
      intro x certificate
      rfl
  }
  targetCostBound := costDominatedBy_refl resource.cost

/-- Backward simulation projects away the ignored dummy certificate. -/
def paddingBackwardSimulation {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v) :
    ResourceSimulation
      (padResourcePresentation resource Dummy) resource where
  certificate := {
    mapCertificate := fun padded => padded.2
    preserves := by
      intro x padded
      rfl
  }
  targetCostBound := costDominatedBy_refl resource.cost

/-- Nonempty dummy padding is an explicit resource bisimulation. -/
def paddingResourceBisimulation {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    ResourceBisimulation resource
      (padResourcePresentation resource Dummy) where
  forward := paddingForwardSimulation resource Dummy
  backward := paddingBackwardSimulation resource Dummy

/-- Padding becomes equality in the explicit simulation quotient. -/
theorem padding_simulatedResourceClass_eq {Input : Type u}
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    simulatedResourceClass
        (padResourcePresentation resource Dummy) =
      simulatedResourceClass resource := by
  apply Quotient.sound
  exact ⟨ResourceBisimulation.symm
    (paddingResourceBisimulation resource Dummy)⟩

/-- Every invariant on the simulation quotient ignores dummy padding. -/
theorem simulated_resource_invariant_ignores_padding
    {Input : Type u}
    {Invariant : Type w}
    (invariant : SimulatedResourceVerifier.{u, v} Input → Invariant)
    (resource : ResourcePresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    invariant
        (simulatedResourceClass
          (padResourcePresentation resource Dummy)) =
      invariant (simulatedResourceClass resource) := by
  rw [padding_simulatedResourceClass_eq]

end PNPConjecture
