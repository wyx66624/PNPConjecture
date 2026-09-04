namespace PNPConjecture

/-- The language recognized by a Boolean verifier with existential certificates. -/
def Recognizes {Input Certificate : Type}
    (verifier : Input → Certificate → Bool)
    (x : Input) : Prop :=
  ∃ certificate, verifier x certificate = true

/-- The fiber of accepting certificates above one input. -/
def AcceptingCertificate {Input Certificate : Type}
    (verifier : Input → Certificate → Bool)
    (x : Input) : Type :=
  { certificate : Certificate // verifier x certificate = true }

/-- Add an ignored dummy certificate component. -/
def padVerifier {Input Certificate Dummy : Type}
    (verifier : Input → Certificate → Bool) :
    Input → (Dummy × Certificate) → Bool :=
  fun x paddedCertificate => verifier x paddedCertificate.2

/--
The accepting-certificate fiber of a padded verifier is exactly the product
of the dummy type and the original accepting-certificate fiber. No
nonemptiness assumption is needed for this structural equivalence.
-/
def paddedAcceptingCertificateEquiv
    {Input Certificate Dummy : Type}
    (verifier : Input → Certificate → Bool)
    (x : Input) :
    Equiv
      (AcceptingCertificate (padVerifier (Dummy := Dummy) verifier) x)
      (Dummy × AcceptingCertificate verifier x) where
  toFun padded :=
    (padded.1.1, ⟨padded.1.2, padded.2⟩)
  invFun original :=
    ⟨(original.1, original.2.1), original.2.2⟩
  left_inv padded := by
    rcases padded with ⟨⟨dummy, certificate⟩, accepted⟩
    rfl
  right_inv original := by
    rcases original with ⟨dummy, ⟨certificate, accepted⟩⟩
    rfl

/--
A nonempty ignored certificate component does not change the recognized
language.
-/
theorem padded_verifier_recognizes_iff
    {Input Certificate Dummy : Type}
    [Nonempty Dummy]
    (verifier : Input → Certificate → Bool)
    (x : Input) :
    Recognizes (padVerifier (Dummy := Dummy) verifier) x ↔
      Recognizes verifier x := by
  constructor
  · rintro ⟨⟨dummy, certificate⟩, accepted⟩
    exact ⟨certificate, accepted⟩
  · rintro ⟨certificate, accepted⟩
    let dummy : Dummy := Classical.choice (inferInstance : Nonempty Dummy)
    exact ⟨(dummy, certificate), accepted⟩

def RecognizedLanguage {Input Certificate : Type}
    (verifier : Input → Certificate → Bool) : Input → Prop :=
  fun x => Recognizes verifier x

/-- Extensional equality of the languages recognized before and after padding. -/
theorem padded_verifier_language_eq
    {Input Certificate Dummy : Type}
    [Nonempty Dummy]
    (verifier : Input → Certificate → Bool) :
    RecognizedLanguage (padVerifier (Dummy := Dummy) verifier) =
      RecognizedLanguage verifier := by
  funext x
  apply propext
  exact padded_verifier_recognizes_iff
    (Dummy := Dummy) verifier x

/--
Every invariant that factors through the recognized language ignores dummy
certificate padding.
-/
theorem language_factored_invariant_ignores_padding
    {Input Certificate Dummy Invariant : Type}
    [Nonempty Dummy]
    (languageInvariant : (Input → Prop) → Invariant)
    (verifier : Input → Certificate → Bool) :
    languageInvariant
        (RecognizedLanguage (padVerifier (Dummy := Dummy) verifier)) =
      languageInvariant (RecognizedLanguage verifier) := by
  rw [padded_verifier_language_eq (Dummy := Dummy) verifier]

end PNPConjecture
