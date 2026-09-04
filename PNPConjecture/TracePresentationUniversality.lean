import PNPConjecture.DiamondTraceNoGo

namespace PNPConjecture

universe u v w

/--
Every reachable start-to-accept trace graph presents the universal language,
because `TraceLanguage` asks only whether that fixed reachability fact holds.
-/
theorem traceLanguage_eq_universal_of_reachable
    {Input : Type u}
    {State : Type v}
    (step : State → State → Prop)
    (start accept : State)
    (reachable : TraceReachable step start accept) :
    TraceLanguage (Input := Input) step start accept =
      (fun _ : Input => True) := by
  funext input
  apply propext
  constructor
  · intro _
    trivial
  · intro _
    exact reachable

/--
Any two reachable trace presentations recognize the same universal language,
regardless of their raw graph structure.
-/
theorem reachable_trace_presentations_recognize_same_language
    {Input : Type u}
    {FirstState : Type v}
    {SecondState : Type w}
    (firstStep : FirstState → FirstState → Prop)
    (firstStart firstAccept : FirstState)
    (secondStep : SecondState → SecondState → Prop)
    (secondStart secondAccept : SecondState)
    (firstReachable :
      TraceReachable firstStep firstStart firstAccept)
    (secondReachable :
      TraceReachable secondStep secondStart secondAccept) :
    TraceLanguage (Input := Input)
        firstStep firstStart firstAccept =
      TraceLanguage (Input := Input)
        secondStep secondStart secondAccept := by
  rw [traceLanguage_eq_universal_of_reachable
      firstStep firstStart firstAccept firstReachable]
  rw [traceLanguage_eq_universal_of_reachable
      secondStep secondStart secondAccept secondReachable]

/-- The previously defined linear and diamond presentations are an instance. -/
theorem linear_diamond_same_language_from_generic_reachability :
    linearLanguage = diamondLanguage := by
  exact reachable_trace_presentations_recognize_same_language
    (Input := Unit)
    linearStep LinearState.start LinearState.accept
    diamondStep DiamondState.start DiamondState.accept
    linear_accepts diamond_accepts

end PNPConjecture
