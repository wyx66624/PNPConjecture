import PNPConjecture.VerifierPadding

namespace PNPConjecture

/-- An easy verifier with exactly one possible original certificate. -/
def trivialVerifier : Unit → Unit → Bool :=
  fun _ _ => true

/-- The unique accepting certificate before padding. -/
def originalWitness :
    AcceptingCertificate trivialVerifier () :=
  ⟨(), rfl⟩

/-- The original accepting-certificate fiber is a subsingleton. -/
theorem original_accepting_certificate_subsingleton :
    Subsingleton (AcceptingCertificate trivialVerifier ()) := by
  constructor
  intro left right
  apply Subtype.ext
  cases left.1
  cases right.1
  rfl

/-- One accepting certificate after padding by `Bool`. -/
def paddedFalseWitness :
    AcceptingCertificate
      (padVerifier (Dummy := Bool) trivialVerifier) () :=
  ⟨(false, ()), rfl⟩

/-- A second accepting certificate after padding by `Bool`. -/
def paddedTrueWitness :
    AcceptingCertificate
      (padVerifier (Dummy := Bool) trivialVerifier) () :=
  ⟨(true, ()), rfl⟩

theorem padded_witnesses_distinct :
    paddedFalseWitness ≠ paddedTrueWitness := by
  intro allegedEquality
  have false_eq_true : false = true :=
    congrArg (fun witness => witness.1.1) allegedEquality
  cases false_eq_true

/-- The padded accepting-certificate fiber is not a subsingleton. -/
theorem padded_accepting_certificate_not_subsingleton :
    ¬ Subsingleton
      (AcceptingCertificate
        (padVerifier (Dummy := Bool) trivialVerifier) ()) := by
  intro allegedSubsingleton
  rcases allegedSubsingleton with ⟨allEqual⟩
  exact padded_witnesses_distinct
    (allEqual paddedFalseWitness paddedTrueWitness)

/--
The recognized language is unchanged although the accepting-certificate
structure changes from a subsingleton to a type with two distinct elements.
This is a concrete no-go theorem for raw witness multiplicity as a language
complexity invariant.
-/
theorem same_language_but_witness_structure_changes :
    RecognizedLanguage
        (padVerifier (Dummy := Bool) trivialVerifier) =
      RecognizedLanguage trivialVerifier ∧
    Subsingleton (AcceptingCertificate trivialVerifier ()) ∧
    ¬ Subsingleton
      (AcceptingCertificate
        (padVerifier (Dummy := Bool) trivialVerifier) ()) := by
  exact ⟨padded_verifier_language_eq
      (Dummy := Bool) trivialVerifier,
    original_accepting_certificate_subsingleton,
    padded_accepting_certificate_not_subsingleton⟩

end PNPConjecture
