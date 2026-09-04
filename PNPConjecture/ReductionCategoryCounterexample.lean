namespace PNPConjecture

/-- An extensional many-one reduction, with complexity bounds abstracted away. -/
def ManyOneReduction {X Y : Type}
    (A : X → Prop) (B : Y → Prop) : Prop :=
  ∃ f : X → Y, ∀ x, A x ↔ B (f x)

/--
There is no many-one reduction from the universal language on Unit to the
empty language on Unit.  In particular, the corresponding hom-set is empty,
so it cannot carry an abelian-group structure or a zero morphism.
-/
theorem no_reduction_from_universal_to_empty :
    ¬ ManyOneReduction
      (fun _ : Unit => True)
      (fun _ : Unit => False) := by
  intro alleged_reduction
  rcases alleged_reduction with ⟨f, correctness⟩
  have contradiction := correctness ()
  simp at contradiction

end PNPConjecture
