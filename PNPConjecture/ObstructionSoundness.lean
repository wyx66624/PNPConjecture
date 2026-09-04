namespace PNPConjecture

universe u v w

/--
Abstract soundness principle for a lower-bound obstruction.

If exact computation forces the obstruction to be zero, while every candidate
has nonzero obstruction against the target, then no candidate computes it.
-/
theorem obstruction_rules_out_all_candidates
    {Candidate : Type u}
    {Target : Type v}
    {Obstruction : Type w}
    [Zero Obstruction]
    (computes : Candidate → Target → Prop)
    (obstruction : Candidate → Target → Obstruction)
    (soundness :
      ∀ candidate target,
        computes candidate target → obstruction candidate target = 0)
    (target : Target)
    (nonvanishing :
      ∀ candidate, obstruction candidate target ≠ 0) :
    ¬ ∃ candidate, computes candidate target := by
  rintro ⟨candidate, computes_target⟩
  exact nonvanishing candidate
    (soundness candidate target computes_target)

end PNPConjecture
