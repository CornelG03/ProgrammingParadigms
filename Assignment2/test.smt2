; Installation test from the slide.
; Run:  z3 test.smt2
; Expected output: unsat   (p and not p can never both be true)
(declare-const p Bool)
(assert (and p (not p)))
(check-sat)
