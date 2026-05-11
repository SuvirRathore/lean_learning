# Lean learning notes

Personal notes for my long-term Lean track. Master schedule lives outside this repo.

---

## Current status

- **Phase:** 1 (Foundations), sub-phase 1.1 (Weeks 1-3)
- **Current focus:** MIL Ch 2 — Basics
- **Repo:** forked from `leanprover-community/mathematics_in_lean`; working copies live in `MIL_work/`

---

## Progress log

### 2026-05-10 (Sun, Week 0)
- Finished Natural Number Game (web version at adam.math.hhu.de)

### 2026-05-11 (Mon, Week 1)
- Installed Lean 4.29.1 (ARM-native) via VS Code + lean4 extension
- Forked MIL repo as `lean_learning`, cloned locally, fetched mathlib cache
- Made `MIL_work/` copy
- Verified end-to-end: InfoView shows tactic state on `MIL_work/C02_Basics/S01_Calculating.lean`
- Committed first changes to fork
- *Status vs schedule:* slightly ahead

---

## Tactics learned (running glossary)

From NNG:
- `rfl` — proves `a = a`
- `rw [h]` — rewrite using hypothesis or lemma `h`
- `rw [← h]` — rewrite using `h` in reverse direction
- `induction n with d hd` — induction on `Nat`
- `exact h` — close goal exactly matching `h`
- `intro h` — introduce hypothesis for `→` or `∀` goal
- `apply h` — backward reasoning
- (extend as I encounter new ones in MIL)

From MIL so far:
- (to fill in)

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