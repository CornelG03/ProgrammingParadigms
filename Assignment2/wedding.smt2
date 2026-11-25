; Assignment 2 - Exercise: three chairs (left, middle, right), Alice, Bob, Charlie
; Modelled as a SAT problem: only Boolean variables.
; Run:  z3 wedding.smt2          Expected output: unsat
;
; Variable naming:  <person><chair>
;   al = "Alice sits on the left chair",  bm = "Bob sits in the middle", ...
(declare-const al Bool) (declare-const am Bool) (declare-const ar Bool)
(declare-const bl Bool) (declare-const bm Bool) (declare-const br Bool)
(declare-const cl Bool) (declare-const cm Bool) (declare-const cr Bool)

; ---------- basic rules of seating ----------
; 1. Everybody gets at least one chair
(assert (or al am ar))
(assert (or bl bm br))
(assert (or cl cm cr))

; 2. At most one person per chair
(assert (not (and al bl))) (assert (not (and al cl))) (assert (not (and bl cl)))
(assert (not (and am bm))) (assert (not (and am cm))) (assert (not (and bm cm)))
(assert (not (and ar br))) (assert (not (and ar cr))) (assert (not (and br cr)))

; (3 people, 3 chairs, everyone seated, no chair shared
;  => nobody can sit on two chairs, so no extra "at most one chair" rule needed)

; ---------- the three wishes ----------
; A. Alice does not sit next to Charlie
;    neighbours are (left, middle) and (middle, right)
(assert (not (and al cm)))
(assert (not (and am cl)))
(assert (not (and am cr)))
(assert (not (and ar cm)))

; B. Alice does not sit on the leftmost chair
(assert (not al))

; C. Bob does not sit to the right of Charlie
(assert (not (and cl bm)))
(assert (not (and cl br)))
(assert (not (and cm br)))

(check-sat)
; unsat  ->  NO, such a seating does not exist.
;
; Why (by hand):
;   B  => Alice is in the middle or on the right.
;   Alice in the middle => she is next to Charlie wherever he sits (breaks A).
;   So Alice is on the right, then A forces Charlie to the left, Bob gets the middle.
;   But then Bob sits to the right of Charlie (breaks C).  Contradiction.
