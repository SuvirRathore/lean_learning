# Lean learning notes

Personal notes for my long-term Lean track. Master schedule lives outside this repo.

---

## Current status

- **Phase:** 1 (Foundations), sub-phase 1.1 (Weeks 1-3)
- **Current focus:** MIL Ch 2 — Basics
- **Repo:** forked from `leanprover-community/mathematics_in_lean`; working copies live in `MIL_work/`

---

## Progress log

### 10-05-2026 (Sun, Week 0)
- Finished Natural Number Game (web version at adam.math.hhu.de)

### 11-05-2026 (Mon, Week 1.1)
- Installed Lean 4.29.1 (ARM-native) via VS Code + lean4 extension
- Forked MIL repo as `lean_learning`, cloned locally, fetched mathlib cache
- Made `MIL_work/` copy
- Verified end-to-end: InfoView shows tactic state on `MIL_work/C02_Basics/S01_Calculating.lean`
- Committed first changes to fork
- *Status vs schedule:* slightly ahead

## 12-05-2026 (Tues, Week 1.2)
- Read MIL §1.1, §1.2 (overview material)
- Worked through all sorrys in MIL_work/C02_Basics/S01_Calculating.lean (§2.1)
- Finished within session budget, no major blockers

## 13-05-2026 (Wed, Week 1.3)
- Worked through §2.2 (S02_Proving_Identities_in_Algebraic_Structures.lean)
- First exposure to typeclass arguments ([CommRing R] etc.) and the ring tactic
- Used group on the last two group-theory exercises (the group-theoretic counterpart to ring) — fine shortcut

## 14-05-2026 (Thu, Week 1.4)
- Completed all §2.3 exercises (S03_Using_Theorems_and_Lemmas.lean)
- Final absolute-value exercise done with abs_le'.mpr + two haves with calc/pow_two_nonneg + constructor + two linariths
- New tools added: apply, linarith, calc, constructor, · … bullets, abs_le', pow_two_nonneg, the have h : P (with proof on indented next lines) pattern, and the <conclusion>_of_<hypotheses> lemma-naming convention


## 15-05-2026 (Fri, Week 1.5)

- Completed §2.4 exercises (S04_More_on_Order_and_Divisibility.lean) covering both order and divisibility
- New tools added: min/max lemmas (min_le_left, min_le_right, le_min, le_max_left, etc.), dvd lemmas, abs_add for triangle inequality, show tactic

## 17-05-2026 (Sun, Week 1.7)

- Completed §2.5 exercises (S05_Proving_Facts_about_Algebraic_Structures.lean), closing out Ch 2
- Worked with lattices and partial orders abstractly via ⊓ (inf) and ⊔ (sup)
- New tools added: inf and sup operations, inf_le_left, inf_le_right, le_inf, le_sup_left, le_sup_right, sup_le, distributivity lemmas (inf_sup_left, sup_inf_right), absorption laws (absorb1, absorb2)

## Week 1 summary

- Setup complete: Lean 4.29.1 installed, MIL repo forked as lean_learning, mathlib cache fetched, MIL_work copy made, git workflow live
- Completed MIL Ch 2 in full (§2.1-2.5): equality rewriting, algebraic structures, ordering, divisibility, lattices
- Pace ~5x ahead of plan's Ch 1-5 / Weeks 1-22 allocation; expected to self-correct in Ch 3+

## 18-05-2026 (Mon, Week 2.1)

- Completed §3.1 exercises (S01_Implication_and_the_Universal_Quantifier.lean)
- Met implicit variables with curly braces {x : α} for arguments Lean infers automatically
- Worked with predicate definitions: FnUb (function upper bound), FnLb (function lower bound), Monotone, Injective, Subset, Even, Odd
- Saw lambda abstraction in term-mode proofs (fun x => ...) as a parallel to tactic-mode intro
- New tools added: dsimp for definitional simplification (unfolds things like fun x ↦ f x + g x to f x + g x), erw as a more permissive variant of rw, the underscore trick (write _ then Cmd+Space) to surface lemma name suggestions
- Gotcha: mul_right_inj fails on variables in a generic ring R with "failed to synthesize IsLeftCancelMul R" — use mul_right_inj' instead, which has the needed hypothesis baked in differently

---

## Useful Tactics and others (running glossary)

# A few starters from Natural Numbers Game:

- `rfl` — proves `a = a`
- `rw [h]` — rewrite using hypothesis or lemma `h`
- `nth_rewrite k` - just rewrites kth appearance
- `rw [← h]` — rewrite using `h` in reverse direction
- `induction n with d hd` — induction on `Nat`, can add `generalizing c`
- `exact h` — close goal exactly matching `h`
- `intro h` — introduce hypothesis for `→` or `∀` goal
- `apply t` — backward reasoning; t : P → Q then replaces goal Q with P, or applied to hypothesis P changes it to Q
- ` ≠ ` - statement for equal implies false
- `symm` - changes goal x = y to y = x
- `simp` - rewrites every lemma tagged with simp as much as it can, can further add simp[lemma], also add algorithms
- `trivial` - solves goal True
- `right` - changes goal P or Q to Q
- `tauto` - solves goal solvable by truth tables (logical)
- `have` - adds new hypothesis

Additional from MIL (so far):

# 2.1: Caluclating, e.g sub_self
- `#check` - shows what follows (useful for checking guess of name of theorem)

# 2.2: Algebraic Structures, e.g  mul_sub
- `ring, group, abel, noncomm_ring` - executes statements obviously true in these structures

# 2.3: Theorems and lemmas, e.g le_trans, exp_le_exp.mp, abs_le'
- `linarith` - handles linear arithmetic using definitions
- `iff` - statements of the form P iff Q, use .mp or .mpr to execute certain direction
- `norm_num` - proves A = B (numerical expressions) using standard operations
- `constructor` - splits conjunction into two goals

# Libraries: (Finding names) e.g A_of_B_of_C
- `Mathlib` - in Github also use API documentation
- `Loogle`
- Standard conventions in Mathlib
- Right click
- `Apply?` - suggested tactic to apply
- AI of course

# 2.4: More Examples, e.g abs_add (tri ineq),
- `min, max, Nat.gcd, lcm, dvd`
- `show` finds first goal equal to t and makes it main goal

# 2.5: Facts in Algebraic Structures, e.g inf_le_inf, sup_inf_right, dist_triangle
- `Lattice` - structure with partial order and inf + sup e.g min + max on total order, intersection + union of subsets with inclusion, and + or with partial order x ≤ y if x False or y True, gcd + lcm on ℕ with divisibility, linear subspaces intersection + sum with inclusion, collection of topologies Union (gen) + intersection with reverse inclusion
- `Distributive lattice` - inf and sup satisfy distribution laws
- Combine axioms e.g strict order ring has mul_pos, add_le_add_left, mul_nonneg
- `Metric Space` - usual laws e.g dist_triangle

# 3.1: Implications and Universal Quantifiers
- curly bracket around variables signify implicit
- Predicates such as function UB/LB, monotone, injective, odd/even fns, subset
- `dsimp` - command to simplify things like fun x ↦ fx + gx applied to x
- Lambda abstraction in type theory temporarily adds objects (and hyp)
- trick of underscroll `_` followed by cmd + space to see whats left to prove
- IsLeftCancel ℝ fails to be verified to use mul_right_inj (as has 0), append `'` to remove 0



---

## Useful commands

```bash
# Update upstream MIL (run in repo root)
git fetch upstream
git merge upstream/master
lake exe cache get

# Refresh mathlib cache if things go weird
lake exe cache get!
```

---

## Parking lot — for future phases

### Phase 3 (Week 53+): mathlib4 PR setup
Before first PR to mathlib4:
1. Fork `leanprover-community/mathlib4` on GitHub
2. In local mathlib4 checkout, rename remotes so `upstream` = official and `origin` = my fork:
```
   git remote rename origin upstream
   git remote add origin https://github.com/MY_USERNAME/mathlib4.git
   git remote -v   # verify
```
Reason: Lake's default clone names origin = official repo, which warns and breaks mathlib tooling assumptions.

### Local paths
- Repo lives at `~/lean_learning` (underscore, not hyphen)
- Lean toolchains: `~/.elan/toolchains/`
- Mathlib cache: `~/.cache/mathlib/`

---

## Resources

- MIL textbook: https://leanprover-community.github.io/mathematics_in_lean/
- Mathlib docs: https://leanprover-community.github.io/mathlib4_docs/
- Loogle (search Mathlib): https://loogle.lean-lang.org
- Zulip chat: https://leanprover.zulipchat.com