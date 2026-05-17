import MIL.Common
import Mathlib.Topology.MetricSpace.Basic

section
variable {α : Type*} [PartialOrder α]
variable (x y z : α)

#check x ≤ y
#check (le_refl x : x ≤ x)
#check (le_trans : x ≤ y → y ≤ z → x ≤ z)
#check (le_antisymm : x ≤ y → y ≤ x → x = y)


#check x < y
#check (lt_irrefl x : ¬ (x < x))
#check (lt_trans : x < y → y < z → x < z)
#check (lt_of_le_of_lt : x ≤ y → y < z → x < z)
#check (lt_of_lt_of_le : x < y → y ≤ z → x < z)

example : x < y ↔ x ≤ y ∧ x ≠ y :=
  lt_iff_le_and_ne

end

section
variable {α : Type*} [Lattice α]
variable (x y z : α)

#check x ⊓ y
#check (inf_le_left : x ⊓ y ≤ x)
#check (inf_le_right : x ⊓ y ≤ y)
#check (le_inf : z ≤ x → z ≤ y → z ≤ x ⊓ y)
#check x ⊔ y
#check (le_sup_left : x ≤ x ⊔ y)
#check (le_sup_right : y ≤ x ⊔ y)
#check (sup_le : x ≤ z → y ≤ z → x ⊔ y ≤ z)

example : x ⊓ y = y ⊓ x := by --inf_comm
  apply le_antisymm
  repeat
    apply le_inf
    exact inf_le_right
    exact inf_le_left


example : x ⊓ y ⊓ z = x ⊓ (y ⊓ z) := by
  apply inf_assoc

example : x ⊔ y = y ⊔ x := by
  apply sup_comm

example : x ⊔ y ⊔ z = x ⊔ (y ⊔ z) := by
  apply sup_assoc

theorem absorb1 : x ⊓ (x ⊔ y) = x := by --inf_sup_self
  apply le_antisymm
  apply inf_le_left
  apply le_inf
  apply le_refl
  apply le_sup_left

theorem absorb2 : x ⊔ x ⊓ y = x := by --sup_inf_self
  apply sup_inf_self

end

section
variable {α : Type*} [DistribLattice α]
variable (x y z : α)

#check (inf_sup_left x y z : x ⊓ (y ⊔ z) = x ⊓ y ⊔ x ⊓ z)
#check (inf_sup_right x y z : (x ⊔ y) ⊓ z = x ⊓ z ⊔ y ⊓ z)
#check (sup_inf_left x y z : x ⊔ y ⊓ z = (x ⊔ y) ⊓ (x ⊔ z))
#check (sup_inf_right x y z : x ⊓ y ⊔ z = (x ⊔ z) ⊓ (y ⊔ z))
end

section
variable {α : Type*} [Lattice α]
variable (a b c : α)

example (h : ∀ x y z : α, x ⊓ (y ⊔ z) = x ⊓ y ⊔ x ⊓ z) : a ⊔ b ⊓ c = (a ⊔ b) ⊓ (a ⊔ c) := by
  rw[h, inf_comm (a ⊔ b) a, inf_sup_self, inf_comm (a ⊔ b) c, h, ← sup_assoc, inf_comm c a, sup_inf_self, inf_comm]


example (h : ∀ x y z : α, x ⊔ y ⊓ z = (x ⊔ y) ⊓ (x ⊔ z)) : a ⊓ (b ⊔ c) = a ⊓ b ⊔ a ⊓ c := by
  rw [h, sup_comm (a ⊓ b) a, sup_inf_self , sup_comm (a ⊓ b) c, h, ← inf_assoc, sup_comm c a, inf_sup_self, sup_comm]

end

section
variable {R : Type*} [Ring R] [PartialOrder R] [IsStrictOrderedRing R]
variable (a b c : R)

#check (add_le_add_left : a ≤ b → ∀ c, c + a ≤ c + b)
#check (mul_pos : 0 < a → 0 < b → 0 < a * b)

#check (mul_nonneg : 0 ≤ a → 0 ≤ b → 0 ≤ a * b)

example (h : a ≤ b) : 0 ≤ b - a := by
  rw[← sub_self a]
  apply sub_le_sub_right
  exact h

example (h: 0 ≤ b - a) : a ≤ b := by
  have h2: a ≤ a + (b - a) := by
    nth_rewrite 1 [← add_zero a]
    exact add_le_add_left h a
  calc
    a ≤ a + (b - a) := h2
    _ = b := by
      rw[← add_sub_assoc, add_comm, add_sub_assoc, sub_self, add_zero]


example (h : a ≤ b) (h' : 0 ≤ c) : a * c ≤ b * c := by
  have h2 : 0 ≤ (b - a) := by
    rw[← sub_self a]
    apply sub_le_sub_right
    exact h
  have h3 : 0 ≤ (b - a) * c := mul_nonneg h2 h'
  rw[sub_mul] at h3
  have h4: a * c ≤ a * c + (b * c - a * c) := by
      nth_rewrite 1 [← add_zero (a * c)]
      apply add_le_add_left h3

  rw[← add_sub_assoc, add_comm, add_sub_assoc, sub_self, add_zero] at h4
  exact h4

end

section
variable {X : Type*} [MetricSpace X]
variable (x y z : X)

#check (dist_self x : dist x x = 0)
#check (dist_comm x y : dist x y = dist y x)
#check (dist_triangle x y z : dist x z ≤ dist x y + dist y z)

example (x y : X) : 0 ≤ dist x y := by
have h: 0 ≤ 2 * dist x y := by
  calc
    0 = dist x x := by
      symm
      exact dist_self x
    _ ≤ dist x y + dist y x := dist_triangle x y x
    _ = dist x y + dist x y := by
      rw[dist_comm]
    _ = 2 * dist x y := by rw[two_mul]

apply nonneg_of_mul_nonneg_right h (by norm_num)


end
