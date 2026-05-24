import MIL.Common
import Mathlib.Data.Real.Basic

namespace C03S06

def ConvergesTo (s : ℕ → ℝ) (a : ℝ) :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n - a| < ε

example : (fun x y : ℝ ↦ (x + y) ^ 2) = fun x y : ℝ ↦ x ^ 2 + 2 * x * y + y ^ 2 := by
  ext u v
  ring

example (a b : ℝ) : |a| = |a - b + b| := by
  congr
  ring

example {a : ℝ} (h : 1 < a) : a < a * a := by
  convert (mul_lt_mul_right _).2 h
  · rw [one_mul]

  exact lt_trans zero_lt_one h

theorem convergesTo_const (a : ℝ) : ConvergesTo (fun x : ℕ ↦ a) a := by
  intro ε εpos
  use 0
  intro n npos
  dsimp
  rw [sub_self, abs_zero]
  apply εpos

theorem convergesTo_add {s t : ℕ → ℝ} {a b : ℝ}
      (cs : ConvergesTo s a) (ct : ConvergesTo t b) :
    ConvergesTo (fun n ↦ s n + t n) (a + b) := by
  intro ε εpos
  dsimp -- this line is not needed but cleans up the goal a bit.
  have ε2pos : 0 < ε / 2 := by linarith

  rcases cs (ε / 2) ε2pos with ⟨Ns, hs⟩
  rcases ct (ε / 2) ε2pos with ⟨Nt, ht⟩
  use max Ns Nt
  intro n nmin
  have nmin_s : n ≥ Ns := by simp[le_of_max_le_left nmin]
  have nmin_t : n ≥ Nt := by simp[le_of_max_le_right nmin]
  have h1: |s n - a| < ε / 2 := hs n nmin_s
  have h2: |t n - b| < ε / 2 := ht n nmin_t

  calc |s n + t n - (a + b)| = |(s n - a) + (t n - b)| := by ring
    _ ≤ |s n - a| + |t n - b| := by apply abs_add
    _ < ε / 2 + ε / 2 := by linarith
    _ = ε := by norm_num


theorem convergesTo_mul_const {s : ℕ → ℝ} {a : ℝ} (c : ℝ) (cs : ConvergesTo s a) :
    ConvergesTo (fun n ↦ c * s n) (c * a) := by
  by_cases h : c = 0
  · convert convergesTo_const 0
    · rw [h]
      ring
    rw [h]
    ring
  have acpos : 0 < |c| := abs_pos.mpr h
  intro ε εpos
  dsimp
  have ε2pos : 0 < ε / |c| := by apply div_pos εpos acpos
  rcases cs (ε / |c|) ε2pos with ⟨N, hN⟩
  use N
  intro n nmin
  have h1 : |s n - a| < ε / |c| := hN n nmin
  calc |c * s n - c * a| = |c * (s n - a)| := by ring_nf
    _ = |c| * |s n - a| := by apply abs_mul
    _ < |c| * (ε / |c|) := by
      apply mul_lt_mul_of_pos_left h1 acpos

    _ = ε := mul_div_cancel₀ _ (ne_of_lt acpos).symm

theorem exists_abs_le_of_convergesTo {s : ℕ → ℝ} {a : ℝ} (cs : ConvergesTo s a) :
    ∃ N b, ∀ n, N ≤ n → |s n| < b := by
  rcases cs 1 zero_lt_one with ⟨N, h⟩
  use N, |a| + 1
  intro n nmin
  have h1 : |s n - a| < 1 := h n nmin

  calc |s n| = |s n - a + a| := by ring_nf
     _ ≤ |s n - a| + |a| := by apply abs_add
      _ < 1 + |a| := by linarith
      _ = |a| + 1 := by ring


theorem aux {s t : ℕ → ℝ} {a : ℝ} (cs : ConvergesTo s a) (ct : ConvergesTo t 0) :
    ConvergesTo (fun n ↦ s n * t n) 0 := by
  intro ε εpos
  dsimp
  rcases exists_abs_le_of_convergesTo cs with ⟨N₀, B, h₀⟩
  have Bpos : 0 < B := lt_of_le_of_lt (abs_nonneg _) (h₀ N₀ (le_refl _))
  have pos₀ : ε / B > 0 := div_pos εpos Bpos
  rcases ct _ pos₀ with ⟨N₁, h₁⟩
  use max N₀ N₁
  intro n nmin
  have nmin₀ : n ≥ N₀ := by simp[le_of_max_le_left nmin]
  have nmin₁ : n ≥ N₁ := by simp[le_of_max_le_right nmin]
  have h₁' : |t n - 0| < ε / B := h₁ n nmin₁
  have h₀' : |s n| < B := h₀ n nmin₀
  calc |s n * t n - 0| = |s n * t n| := by ring_nf
    _ = |s n| * |t n| := by apply abs_mul
    _ = |s n| * |t n - 0| := by rw [sub_zero]
    _ < B * (ε / B) := (mul_lt_mul'' (h₀ n nmin₀) (h₁ n nmin₁) (abs_nonneg _) (abs_nonneg _))
    _ = ε := mul_div_cancel₀ _ (ne_of_lt Bpos).symm


theorem convergesTo_mul {s t : ℕ → ℝ} {a b : ℝ}
      (cs : ConvergesTo s a) (ct : ConvergesTo t b) :
    ConvergesTo (fun n ↦ s n * t n) (a * b) := by
  have h₁ : ConvergesTo (fun n ↦ s n * (t n + -b)) 0 := by
    apply aux cs
    convert convergesTo_add ct (convergesTo_const (-b))
    ring
  have := convergesTo_add h₁ (convergesTo_mul_const b cs)
  convert convergesTo_add h₁ (convergesTo_mul_const b cs) using 1
  · ext; ring
  ring

theorem convergesTo_unique {s : ℕ → ℝ} {a b : ℝ}
      (sa : ConvergesTo s a) (sb : ConvergesTo s b) :
    a = b := by
  by_contra abne
  have : |a - b| > 0 := by
    apply abs_pos.mpr
    contrapose! abne
    linarith
  let ε := |a - b| / 2
  have εpos : ε > 0 := by
    change |a - b| / 2 > 0
    linarith
  rcases sa ε εpos with ⟨Na, hNa⟩
  rcases sb ε εpos with ⟨Nb, hNb⟩
  let N := max Na Nb
  have absa : |s N - a| < ε := by
    exact hNa N (le_of_max_le_left (le_refl _))
  have absb : |s N - b| < ε := by
    exact hNb N (le_of_max_le_right (le_refl _))
  have : |a - b| < |a - b| := by
    calc |a - b| = |(a - s N) + (s N - b)| := by ring_nf
      _ ≤ |a - s N| + |s N - b| := by apply abs_add
      _ = |-(s N - a)| + |s N - b| := by
        congr
        ring
      _ = |s N - a| + |s N - b| := by rw [abs_neg]
      _ < ε + ε := (add_lt_add absa absb)
      _ = |a - b| := by norm_num[ε]
  exact lt_irrefl _ this


section
variable {α : Type*} [LinearOrder α]

def ConvergesTo' (s : α → ℝ) (a : ℝ) :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n - a| < ε

end
