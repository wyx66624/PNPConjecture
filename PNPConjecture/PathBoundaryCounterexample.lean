namespace PNPConjecture

/-- The smallest configuration graph needed for the face-closure counterexample. -/
inductive Vertex where
  | c0
  | c1
  | c2
  deriving DecidableEq, Repr

/-- Exactly the directed edges c0 -> c1 and c1 -> c2. -/
def Edge : Vertex → Vertex → Prop
  | .c0, .c1 => True
  | .c1, .c2 => True
  | _, _ => False

def ValidOneStep (a b : Vertex) : Prop :=
  Edge a b

def ValidTwoStep (a b c : Vertex) : Prop :=
  Edge a b ∧ Edge b c

theorem path_c0_c1_c2_is_valid :
    ValidTwoStep .c0 .c1 .c2 := by
  simp [ValidTwoStep, Edge]

theorem middle_face_c0_c2_is_invalid :
    ¬ ValidOneStep .c0 .c2 := by
  simp [ValidOneStep, Edge]

/--
Deleting the middle vertex from a valid directed two-step path need not
produce a valid directed one-step path.  Thus ordinary simplicial face
deletion is not closed on the proposed generators.
-/
theorem directed_paths_not_closed_under_middle_face :
    ValidTwoStep .c0 .c1 .c2 ∧ ¬ ValidOneStep .c0 .c2 :=
  ⟨path_c0_c1_c2_is_valid, middle_face_c0_c2_is_invalid⟩

end PNPConjecture
