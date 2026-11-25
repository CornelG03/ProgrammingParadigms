# Programming Paradigms - seminar assignments, solved

There are **4 assignments** (one per seminar PDF), not 3.
Every file here was machine-checked: all `.vpr` files verify with 0 errors in
Viper (both backends, Silicon and Carbon), and all Z3 files print the expected answer.

## What to install

| Assignment | Needs | Install |
|---|---|---|
| 1, 3, 4 | Viper | 1. Java 11 or newer, 64-bit (e.g. from adoptium.net). 2. Visual Studio Code. 3. In VS Code: Extensions -> search "Viper" -> install. Open any `.vpr` file and the extension downloads the Viper tools by itself (first time takes a minute). |
| 2 | Z3 + Z3Py | 1. Z3 binary: github.com/Z3Prover/z3/releases -> the zip for your OS (slide links 4.11.0, any newer one works) -> unzip -> the program is `bin/z3` (`bin\z3.exe`). 2. Python 3 from python.org (tick "Add python.exe to PATH" on Windows). 3. `pip install z3-solver` |

## How to run

**Viper (1, 3, 4):** open the `.vpr` file in VS Code. It verifies when you open or
save it (or press F5). Green check in the status bar at the bottom = verified.
A red underline = the line that fails.

**Z3 (2):** in a terminal inside the `Assignment2` folder:

    z3 test.smt2                  -> unsat   (this is the installation test)
    z3 course_selection.smt2      -> sat (+ model), then unsat
    z3 wedding.smt2               -> unsat
    python course_selection.py
    python wedding.py

If `z3` is "not recognized", use the full path to `z3.exe`, or copy the `.smt2`
file next to `z3.exe`.

## What is in each folder

### Assignment1 (present at Seminar 2) - Viper basics
| File | Task | Answer in one line |
|---|---|---|
| `1_max.vpr` | 2+ implementations of `max`, one that is not the max | real max; max + 1; \|x\| + \|y\|. The contract never says `r == x \|\| r == y` |
| `2_maxSum.vpr` | maxSum a)-f) | contract needs `max == x \|\| max == y`; reconstruct needs `requires sum <= 2 * max` |
| `3_forward_reasoning.vpr` | strongest postconditions | (a) `z == y - x` (b) `0 <= x && x <= 198 && x % 2 == 0` (c) `x > 23 && y > -2 * x - 23` (d) `!y ==> x == 42` |
| `4_backward_reasoning.vpr` | weakest preconditions | (a) `true` (b) `(y < 1 && x + y > 0) \|\| (y > 1 && x + y < 0)` (c) `(y > 5 ==> x > 7) && (y <= 5 ==> y - x > 7)` (d) `x <= 3 \|\| x >= 17` |

### Assignment2 (present at Seminar 3) - Z3
| File | Task | Answer |
|---|---|---|
| `test.smt2` | installation test | `unsat` |
| `course_selection.smt2` / `.py` | course selection example | Verification + preliminaries: **yes** (Verification, CS Modeling, Discrete Math). Physics + Discrete Math: **no** |
| `wedding.smt2` / `.py` | three chairs, Alice / Bob / Charlie | **unsat**, no such seating exists |

### Assignment3 (present at Seminar 5) - loop invariants
| File | Invariant |
|---|---|
| `1_division.vpr` | `M == res * N + m` (and `m >= 0`) |
| `2_multiplication.vpr` | `x >= 0` and `res + x * y == n * m` |
| `3_int_sqrt.vpr` | `res * res <= n` |
| `4_int_sqrt_fast.vpr` | `x == (res + 1) * (res + 1)` and `res * res <= n` |
| `5_square.vpr` | two nested `+ 1` loops; outer `res == i * n`, inner `res == i * n + j` |

### Assignment4 (present in the last 2 weeks) - recursion, termination, domains
| File | Key line |
|---|---|
| `1_sum.vpr` | `ensures res == n * (n + 1) / 2` |
| `2_mccarthy91.vpr` | `decreases 101 - n` |
| `3_trees_domain.vpr` | `size` and `sum` as domain functions + 2 axioms each |
| `4_fib.vpr` | `ensures res == fib(n)`; invariants `res == fib(i)`, `next == fib(i + 1)` |
| `5_trees_size_function.vpr` | recursive function `size` with `ensures result >= 1` |

## Things you still have to do yourself

1. **Course files I did not have.** The slides refer to files on Teams:
   `ex-s*.smt2`, `ex-p*.py`, `wedding.smt2`, `wedding.py`, `03-trees.vpr`,
   `07-fib.vpr`, `10-trees.vpr`. My versions are written from scratch and are
   complete on their own. For the two tree files the professor may expect his
   skeleton: in that case copy the block between the `ADDED` markers into his
   file and rename `leaf` / `node` / `is_leaf` / `node_left` / `node_right` if
   his file spells them differently.
2. **You have to present these.** Every file starts with a comment explaining
   why the answer is what it is. Read those before the seminar.
3. Seminar 1: write your group in `Group.xlsx` on Teams (code `oqyaf30`).
