import Std

namespace PNPConjecture

universe u v

/-- Pointwise exact computation of a Boolean target. -/
def ComputesFunction {Input : Type u}
    (candidate target : Input → Bool) : Prop :=
  ∀ x, candidate x = target x

/-- The canonical pointwise disagreement obstruction. -/
def HasDisagreement {Input : Type u}
    (candidate target : Input → Bool) : Prop :=
  ∃ x, candidate x ≠ target x

/-- Exact computation is equivalent to the absence of a disagreement. -/
theorem computesFunction_iff_no_disagreement
    {Input : Type u}
    (candidate target : Input → Bool) :
    ComputesFunction candidate target ↔
      ¬ HasDisagreement candidate target := by
  classical
  constructor
  · intro computes disagreement
    rcases disagreement with ⟨x, differs⟩
    exact differs (computes x)
  · intro noDisagreement x
    by_contra differs
    exact noDisagreement ⟨x, differs⟩

/-- Failure to compute is equivalent to a pointwise disagreement. -/
theorem not_computesFunction_iff_disagreement
    {Input : Type u}
    (candidate target : Input → Bool) :
    ¬ ComputesFunction candidate target ↔
      HasDisagreement candidate target := by
  classical
  constructor
  · intro notComputes
    by_contra noDisagreement
    apply notComputes
    exact (computesFunction_iff_no_disagreement
      candidate target).2 noDisagreement
  · intro disagreement computes
    exact (computesFunction_iff_no_disagreement
      candidate target).1 computes disagreement

/--
For the canonical disagreement obstruction, universal nonvanishing over a
candidate class is exactly the desired lower-bound statement.  Therefore this
obstruction alone provides no independent structural leverage.
-/
theorem all_candidates_disagree_iff_no_exact_candidate
    {Input : Type u}
    {Candidate : Type v}
    (admissible : Candidate → Prop)
    (semantics : Candidate → Input → Bool)
    (target : Input → Bool) :
    (∀ candidate, admissible candidate →
      HasDisagreement (semantics candidate) target) ↔
      ¬ ∃ candidate,
        admissible candidate ∧
          ComputesFunction (semantics candidate) target := by
  classical
  constructor
  · intro allDisagree
    rintro ⟨candidate, candidateAdmissible, computes⟩
    rcases allDisagree candidate candidateAdmissible with
      ⟨x, differs⟩
    exact differs (computes x)
  · intro noExactCandidate candidate candidateAdmissible
    have notComputes :
        ¬ ComputesFunction (semantics candidate) target := by
      intro computes
      exact noExactCandidate
        ⟨candidate, candidateAdmissible, computes⟩
    exact (not_computesFunction_iff_disagreement
      (semantics candidate) target).1 notComputes

end PNPConjecture
