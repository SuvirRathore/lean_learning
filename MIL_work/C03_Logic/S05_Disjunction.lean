import MIL.Common
import Mathlib.Data.Real.Basic

namespace C03S05

section

variable {x y : ℝ}

example (h : y > x ^ 2) : y > 0 ∨ y < -1 := by
  left
  linarith [pow_two_nonneg x]

example (h : -y > x ^ 2 + 1) : y > 0 ∨ y < -1 := by
  right
  linarith [pow_two_nonneg x]

example (h : y > 0) : y > 0 ∨ y < -1 :=
  Or.inl h

example (h : y < -1) : y > 0 ∨ y < -1 :=
  Or.inr h

example : x < |y| → x < y ∨ x < -y := by
  rcases le_or_gt 0 y with h | h
  · rw [abs_of_nonneg h]
    intro h; left; exact h
  · rw [abs_of_neg h]
    intro h; right; exact h

example : x < |y| → x < y ∨ x < -y := by
  cases le_or_gt 0 y
  case inl h =>
    rw [abs_of_nonneg h]
    intro h; left; exact h

  case inr h =>
    rw [abs_of_neg h]
    intro h; right; exact h

example : x < |y| → x < y ∨ x < -y := by
  cases le_or_gt 0 y
  next h =>
    rw [abs_of_nonneg h]
    intro h; left; exact h
  next h =>
    rw [abs_of_neg h]
    intro h; right; exact h

example : x < |y| → x < y ∨ x < -y := by
  match le_or_gt 0 y with
    | Or.inl h =>
      rw [abs_of_nonneg h]
      intro h; left; exact h
    | Or.inr h =>
      rw [abs_of_neg h]
      intro h; right; exact h

namespace MyAbs

theorem le_abs_self (x : ℝ) : x ≤ |x| := by
  cases le_or_gt 0 x
  case inl h =>
    rw [abs_of_nonneg h]

  case inr h =>
    rw [abs_of_neg h]
    linarith

theorem neg_le_abs_self (x : ℝ) : -x ≤ |x| := by
  rw[← abs_neg x]
  apply le_abs_self

theorem abs_add (x y : ℝ) : |x + y| ≤ |x| + |y| := by
  rcases le_or_gt 0 (x + y) with h | h
  · rw [abs_of_nonneg h]
    simp [le_abs_self x, le_abs_self y, add_le_add]
  rw [abs_of_neg h]
  rw [neg_add]
  simp [neg_le_abs_self x, neg_le_abs_self y, add_le_add]


theorem lt_abs : x < |y| ↔ x < y ∨ x < -y := by
  rcases le_or_gt 0 y with h | h
  · rw [abs_of_nonneg h]
    constructor
    · intro h'
      left
      exact h'
    · intro h''
      rcases h'' with h''' | h'''
      · exact h'''
      · linarith
  rw [abs_of_neg h]
  constructor
  · intro h1
    right
    exact h1
  · intro h2
    rcases h2 with h3 | h4
    · linarith
    · exact h4

theorem abs_lt : |x| < y ↔ -y < x ∧ x < y := by
  rcases le_or_gt 0 x with h1 | h2
  · rw [abs_of_nonneg h1]
    constructor
    · intro h3
      constructor
      · linarith
      exact h3
    · intro h4
      rcases h4 with ⟨h5, h6⟩
      exact h6
  · rw [abs_of_neg h2]
    constructor
    · intro h7
      constructor
      · linarith
      · linarith
    · intro h8
      linarith

end MyAbs

end

example {x : ℝ} (h : x ≠ 0) : x < 0 ∨ x > 0 := by
  rcases lt_trichotomy x 0 with xlt | xeq | xgt
  · left
    exact xlt
  · contradiction
  · right; exact xgt

example {m n k : ℕ} (h : m ∣ n ∨ m ∣ k) : m ∣ n * k := by
  rcases h with ⟨a, rfl⟩ | ⟨b, rfl⟩
  · rw [mul_assoc]
    apply dvd_mul_right
  · rw [mul_comm, mul_assoc]
    apply dvd_mul_right

example {z : ℝ} (h : ∃ x y, z = x ^ 2 + y ^ 2 ∨ z = x ^ 2 + y ^ 2 + 1) : z ≥ 0 := by
  rcases h with ⟨ x,y, rfl | rfl ⟩ <;> linarith [sq_nonneg x, sq_nonneg y]

example {x : ℝ} (h : x ^ 2 = 1) : x = 1 ∨ x = -1 := by
  exact sq_eq_one_iff.mp h

example {x y : ℝ} (h : x ^ 2 = y ^ 2) : x = y ∨ x = -y := by
  apply sq_eq_sq_iff_eq_or_eq_neg.mp h

section
variable {R : Type*} [CommRing R] [IsDomain R]
variable (x y : R)

example (h : x ^ 2 = 1) : x = 1 ∨ x = -1 := by
  exact sq_eq_one_iff.mp h

example (h : x ^ 2 = y ^ 2) : x = y ∨ x = -y := by
  apply sq_eq_sq_iff_eq_or_eq_neg.mp h

end

example (P : Prop) : ¬¬P → P := by
  intro h
  cases em P
  · assumption
  · contradiction

example (P : Prop) : ¬¬P → P := by
  intro h
  by_cases h' : P
  · assumption
  contradiction

example (P Q : Prop) : P → Q ↔ ¬P ∨ Q := by

  constructor
  · intro h
    by_cases h' : P
    · right
      tauto
    · left
      tauto

  · intro h
    cases h
    intro h'
    contradiction
    intro h'
    assumption
