; Assignment 2 - "Example: Course Selection" (the ex-s2 example)
; Run:  z3 course_selection.smt2
;
; One Boolean per course: true = "I take this course".
(declare-const modeling     Bool)   ; CS Modeling
(declare-const physics      Bool)
(declare-const chemistry    Bool)
(declare-const discrete     Bool)   ; Discrete Math
(declare-const verification Bool)
(declare-const statistics   Bool)

; You have to take CS Modeling, Physics, or Chemistry
(assert (or modeling physics chemistry))
; For CS Modeling, you also need Discrete Math
(assert (=> modeling discrete))
; For Verification, you need CS Modeling
(assert (=> verification modeling))
; For Physics and Chemistry, you need Statistics
(assert (=> physics statistics))
(assert (=> chemistry statistics))
; Statistics and Discrete Math are at the same time
(assert (not (and statistics discrete)))
; CS Modeling and Physics are at the same time
(assert (not (and modeling physics)))
; Verification and Chemistry are at the same time
(assert (not (and verification chemistry)))

; ---- Question 1: Is it possible to take Verification and all preliminaries?
; push/pop = add a temporary assumption, ask, then throw it away again.
(echo "Q1: Verification + all preliminaries?")
(push)
(assert verification)
(check-sat)      ; sat  -> YES
(get-model)      ; verification, modeling, discrete = true; the rest = false
(pop)

; ---- Question 2: Is it possible to take Physics and Discrete Math?
(echo "Q2: Physics + Discrete Math?")
(push)
(assert (and physics discrete))
(check-sat)      ; unsat -> NO (Physics needs Statistics, which clashes with Discrete Math)
(pop)
