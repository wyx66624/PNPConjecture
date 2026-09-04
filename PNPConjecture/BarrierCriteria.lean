namespace PNPConjecture

universe u

/-- Pointwise inclusion of abstract complexity classes. -/
def Included {Problem : Type u} (A B : Problem → Prop) : Prop :=
  ∀ problem, A problem → B problem

/--
An NP problem outside P separates the two classes.
This is an abstract logical form of the final Cook--Levin bridge.
-/
theorem separation_from_np_problem
    {Problem : Type u}
    (P NP : Problem → Prop)
    (target : Problem)
    (target_in_np : NP target)
    (target_not_in_p : ¬ P target) :
    P ≠ NP := by
  intro classes_equal
  apply target_not_in_p
  rw [classes_equal]
  exact target_in_np

/--
Because P is contained in P/poly, an NP problem outside P/poly also separates
P from NP.  The containment is supplied explicitly as a hypothesis.
-/
theorem separation_from_nonuniform_lower_bound
    {Problem : Type u}
    (P NP Ppoly : Problem → Prop)
    (target : Problem)
    (p_sub_p_poly : Included P Ppoly)
    (target_in_np : NP target)
    (target_not_in_p_poly : ¬ Ppoly target) :
    P ≠ NP := by
  intro classes_equal
  apply target_not_in_p_poly
  apply p_sub_p_poly target
  rw [classes_equal]
  exact target_in_np

end PNPConjecture
