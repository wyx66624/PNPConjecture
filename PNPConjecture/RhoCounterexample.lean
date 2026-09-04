namespace PNPConjecture

/-- Sign of one adjacent change in a verification order. -/
def adjacentSign (a b : Int) : Int :=
  if a < b then 1 else if b < a then -1 else 0

/-- The manuscript's normalized score for an order of length two. -/
def rho2 (a b : Int) : Int :=
  adjacentSign a b

/--
For the concrete all-increasing length-four order, integer division agrees
with the rational average because the numerator is divisible by three.
-/
def rho4 (a b c d : Int) : Int :=
  (adjacentSign a b + adjacentSign b c + adjacentSign c d) / 3

theorem rho_first_segment :
    rho2 1 2 = 1 := by
  decide

theorem rho_second_segment :
    rho2 3 4 = 1 := by
  decide

theorem rho_concatenation :
    rho4 1 2 3 4 = 1 := by
  decide

/--
The average adjacent-sign score is not additive under concatenation:
rho(1,2,3,4) = 1, whereas rho(1,2) + rho(3,4) = 2.
-/
theorem rho_is_not_additive_under_concatenation :
    rho4 1 2 3 4 ≠ rho2 1 2 + rho2 3 4 := by
  decide

end PNPConjecture
