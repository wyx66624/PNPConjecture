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

/-- The designated initial configuration. -/
def Initial : Vertex → Prop
  | .c0 => True
  | _ => False

/-- The designated terminal configuration. -/
def Terminal : Vertex → Prop
  | .c2 => True
  | _ => False

/-- A one-step computation path starts initially, follows an edge, and ends terminally. -/
def ValidOneStep (a b : Vertex) : Prop :=
  Initial a ∧ Edge a b ∧ Terminal b

/-- A two-step computation path with the same endpoint conditions. -/
def ValidTwoStep (a b c : Vertex) : Prop :=
  Initial a ∧ Edge a b ∧ Edge b c ∧ Terminal c

theorem path_c0_c1_c2_is_valid :
    ValidTwoStep .c0 .c1 .c2 := by
  simp [ValidTwoStep, Initial, Edge, Terminal]

theorem first_face_c1_c2_is_invalid :
    ¬ ValidOneStep .c1 .c2 := by
  simp [ValidOneStep, Initial, Edge, Terminal]

theorem middle_face_c0_c2_is_invalid :
    ¬ ValidOneStep .c0 .c2 := by
  simp [ValidOneStep, Initial, Edge, Terminal]

theorem last_face_c0_c1_is_invalid :
    ¬ ValidOneStep .c0 .c1 := by
  simp [ValidOneStep, Initial, Edge, Terminal]

/--
Every ordinary face of this valid directed computation path is absent from the
stated group of one-step computation paths: one loses the initial endpoint,
one skips a nonexistent transition, and one loses the terminal endpoint.
-/
theorem directed_computation_paths_not_closed_under_faces :
    ValidTwoStep .c0 .c1 .c2 ∧
      ¬ ValidOneStep .c1 .c2 ∧
      ¬ ValidOneStep .c0 .c2 ∧
      ¬ ValidOneStep .c0 .c1 := by
  exact ⟨path_c0_c1_c2_is_valid,
    first_face_c1_c2_is_invalid,
    middle_face_c0_c2_is_invalid,
    last_face_c0_c1_is_invalid⟩

end PNPConjecture
