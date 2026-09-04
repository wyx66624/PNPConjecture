import PNPConjecture.VerifierPadding

namespace PNPConjecture

universe u v w

/-- A verifier together with its (possibly presentation-specific) certificate type. -/
structure VerifierPresentation (Input : Type u) where
  Certificate : Type v
  verifier : Input → Certificate → Bool

/-- The language recognized by a verifier presentation. -/
def PresentationRecognizes {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input)
    (x : Input) : Prop :=
  Recognizes presentation.verifier x

/-- Two presentations are semantically equivalent when they recognize the same language. -/
def SameLanguage {Input : Type u}
    (left right : VerifierPresentation.{u, v} Input) : Prop :=
  ∀ x, PresentationRecognizes left x ↔ PresentationRecognizes right x

theorem sameLanguage_refl {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input) :
    SameLanguage presentation presentation := by
  intro x
  exact Iff.rfl

theorem sameLanguage_symm {Input : Type u}
    {left right : VerifierPresentation.{u, v} Input}
    (equivalent : SameLanguage left right) :
    SameLanguage right left := by
  intro x
  exact (equivalent x).symm

theorem sameLanguage_trans {Input : Type u}
    {first second third : VerifierPresentation.{u, v} Input}
    (first_second : SameLanguage first second)
    (second_third : SameLanguage second third) :
    SameLanguage first third := by
  intro x
  exact (first_second x).trans (second_third x)

/-- Semantic equality is an equivalence relation on verifier presentations. -/
def presentationSetoid (Input : Type u) :
    Setoid (VerifierPresentation.{u, v} Input) where
  r := SameLanguage
  iseqv := {
    refl := sameLanguage_refl
    symm := sameLanguage_symm
    trans := sameLanguage_trans
  }

/-- The coarse semantic quotient that remembers only the recognized language. -/
def SemanticVerifier (Input : Type u) : Type (max u (v + 1)) :=
  Quotient (presentationSetoid (v := v) Input)

/-- The semantic class of one presentation. -/
def semanticClass {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input) :
    SemanticVerifier (v := v) Input :=
  Quotient.mk _ presentation

/-- Add an ignored dummy factor to a verifier presentation. -/
def padPresentation {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input)
    (Dummy : Type v) : VerifierPresentation.{u, v} Input where
  Certificate := Dummy × presentation.Certificate
  verifier := padVerifier (Dummy := Dummy) presentation.verifier

/-- Nonempty dummy padding is semantic equivalence. -/
theorem padPresentation_sameLanguage {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    SameLanguage (padPresentation presentation Dummy) presentation := by
  intro x
  exact padded_verifier_recognizes_iff
    (Dummy := Dummy) presentation.verifier x

/-- Nonempty dummy padding becomes literal equality in the semantic quotient. -/
theorem padPresentation_semanticClass_eq {Input : Type u}
    (presentation : VerifierPresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    semanticClass (padPresentation presentation Dummy) =
      semanticClass presentation := by
  apply Quotient.sound
  exact padPresentation_sameLanguage presentation Dummy

/-- Every invariant defined on the semantic quotient ignores dummy padding. -/
theorem semantic_quotient_invariant_ignores_padding
    {Input : Type u}
    {Invariant : Type w}
    (invariant : SemanticVerifier (v := v) Input → Invariant)
    (presentation : VerifierPresentation.{u, v} Input)
    (Dummy : Type v)
    [Nonempty Dummy] :
    invariant (semanticClass (padPresentation presentation Dummy)) =
      invariant (semanticClass presentation) := by
  rw [padPresentation_semanticClass_eq]

end PNPConjecture
