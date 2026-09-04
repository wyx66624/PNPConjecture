import Std

namespace PNPConjecture

universe u v

/-- Reflexive-transitive reachability for a directed trace graph. -/
inductive TraceReachable {State : Type v}
    (step : State → State → Prop) : State → State → Prop where
  | refl (state : State) : TraceReachable step state state
  | tail {start middle finish : State} :
      TraceReachable step start middle →
      step middle finish →
      TraceReachable step start finish

/-- The language recognized by a fixed start and accepting state. -/
def TraceLanguage {Input : Type u} {State : Type v}
    (step : State → State → Prop)
    (start accept : State) : Input → Prop :=
  fun _ => TraceReachable step start accept

/-- A direct one-step presentation of the universal language on `Unit`. -/
inductive LinearState where
  | start
  | accept
  deriving DecidableEq, Repr

def linearStep : LinearState → LinearState → Prop
  | .start, .accept => True
  | _, _ => False

def linearRank : LinearState → Nat
  | .start => 0
  | .accept => 1

/-- A constant-time dummy branching presentation of the same language. -/
inductive DiamondState where
  | start
  | left
  | right
  | accept
  deriving DecidableEq, Repr

def diamondStep : DiamondState → DiamondState → Prop
  | .start, .left => True
  | .start, .right => True
  | .left, .accept => True
  | .right, .accept => True
  | _, _ => False

def diamondRank : DiamondState → Nat
  | .start => 0
  | .left => 1
  | .right => 1
  | .accept => 2

/-- Every edge of the linear presentation strictly increases its time rank. -/
theorem linear_step_increases_rank {a b : LinearState}
    (edge : linearStep a b) :
    linearRank a < linearRank b := by
  cases a <;> cases b <;> simp_all [linearStep, linearRank]

/-- Every edge of the diamond presentation strictly increases its time rank. -/
theorem diamond_step_increases_rank {a b : DiamondState}
    (edge : diamondStep a b) :
    diamondRank a < diamondRank b := by
  cases a <;> cases b <;> simp_all [diamondStep, diamondRank]

/-- The direct presentation accepts. -/
theorem linear_accepts :
    TraceReachable linearStep LinearState.start LinearState.accept := by
  exact TraceReachable.tail
    (TraceReachable.refl LinearState.start)
    (by simp [linearStep])

/-- The dummy branching presentation accepts through its left branch. -/
theorem diamond_accepts :
    TraceReachable diamondStep DiamondState.start DiamondState.accept := by
  have firstStep :
      TraceReachable diamondStep DiamondState.start DiamondState.left := by
    exact TraceReachable.tail
      (TraceReachable.refl DiamondState.start)
      (by simp [diamondStep])
  exact TraceReachable.tail firstStep (by simp [diamondStep])

def linearLanguage : Unit → Prop :=
  TraceLanguage linearStep LinearState.start LinearState.accept

def diamondLanguage : Unit → Prop :=
  TraceLanguage diamondStep DiamondState.start DiamondState.accept

/-- Both constant-time presentations recognize exactly the same language. -/
theorem linear_and_diamond_recognize_same_language :
    linearLanguage = diamondLanguage := by
  funext input
  apply propext
  constructor
  · intro _
    exact diamond_accepts
  · intro _
    exact linear_accepts

/-- Adjacency after forgetting edge orientation. -/
def UndirectedAdjacent {State : Type v}
    (step : State → State → Prop)
    (a b : State) : Prop :=
  step a b ∨ step b a

/-- Four distinct vertices forming a chordless cycle in the underlying graph. -/
def HasInducedFourCycle {State : Type v}
    (step : State → State → Prop) : Prop :=
  ∃ a b c d,
    a ≠ b ∧ b ≠ c ∧ c ≠ d ∧ d ≠ a ∧
    a ≠ c ∧ b ≠ d ∧
    UndirectedAdjacent step a b ∧
    UndirectedAdjacent step b c ∧
    UndirectedAdjacent step c d ∧
    UndirectedAdjacent step d a ∧
    ¬ UndirectedAdjacent step a c ∧
    ¬ UndirectedAdjacent step b d

/-- The two-state direct presentation has no induced four-cycle. -/
theorem linear_has_no_induced_four_cycle :
    ¬ HasInducedFourCycle linearStep := by
  rintro ⟨a, b, c, d, hypotheses⟩
  cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [UndirectedAdjacent, linearStep]

/-- The underlying graph of the dummy branching presentation is a chordless square. -/
theorem diamond_has_induced_four_cycle :
    HasInducedFourCycle diamondStep := by
  refine ⟨DiamondState.start, DiamondState.left,
    DiamondState.accept, DiamondState.right, ?_⟩
  simp [UndirectedAdjacent, diamondStep]

/--
A constant-time, acyclic change of presentation preserves the recognized
language but changes a basic cycle property of the underlying trace graph.
Therefore raw trace-cycle structure is not a language invariant.
-/
theorem same_language_but_different_trace_cycle_structure :
    linearLanguage = diamondLanguage ∧
      ¬ HasInducedFourCycle linearStep ∧
      HasInducedFourCycle diamondStep := by
  exact ⟨linear_and_diamond_recognize_same_language,
    linear_has_no_induced_four_cycle,
    diamond_has_induced_four_cycle⟩

end PNPConjecture
