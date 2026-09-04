namespace PNPConjecture

/--
On the one-edge path c0 -> c1, the proposed degree-zero homotopy sends the
nonterminal vertex c0 to the edge (coefficient 1) and the terminal vertex c1
to zero.
-/
def proposedS0 (isTerminal : Bool) : Int :=
  if isTerminal then 0 else 1

/--
For d(e) = c1 - c0 and s1(e) = 0, the edge coefficient of
(ds + sd)(e) is s0(c1) - s0(c0).
-/
def proposedHomotopyOnEdge : Int :=
  proposedS0 true - proposedS0 false

theorem proposed_homotopy_returns_negative_edge :
    proposedHomotopyOnEdge = -1 := by
  decide

/-- The displayed homotopy equation fails already on the unique edge. -/
theorem proposed_homotopy_is_not_identity_on_edge :
    proposedHomotopyOnEdge ≠ 1 := by
  decide

end PNPConjecture
