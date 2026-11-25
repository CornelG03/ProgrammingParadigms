# Assignment 2 - "Example: Course Selection", Z3Py version
# Run:  python course_selection.py
from z3 import Bools, Solver, Or, And, Not, Implies, sat

modeling, physics, chemistry = Bools("modeling physics chemistry")
discrete, verification, statistics = Bools("discrete verification statistics")

s = Solver()
s.add(Or(modeling, physics, chemistry))        # must take one of the three
s.add(Implies(modeling, discrete))             # CS Modeling needs Discrete Math
s.add(Implies(verification, modeling))         # Verification needs CS Modeling
s.add(Implies(physics, statistics))            # Physics needs Statistics
s.add(Implies(chemistry, statistics))          # Chemistry needs Statistics
s.add(Not(And(statistics, discrete)))          # same time slot
s.add(Not(And(modeling, physics)))             # same time slot
s.add(Not(And(verification, chemistry)))       # same time slot


def ask(question, extra):
    s.push()                 # temporary assumption
    s.add(extra)
    result = s.check()
    print(question, "->", "YES" if result == sat else "NO", f"({result})")
    if result == sat:
        m = s.model()
        taken = [str(c) for c in (modeling, physics, chemistry, discrete, verification, statistics)
                 if m.evaluate(c, model_completion=True)]
        print("   courses taken:", ", ".join(taken))
    s.pop()                  # forget the assumption again


ask("Q1: Verification and all preliminaries?", verification)
ask("Q2: Physics and Discrete Math?", And(physics, discrete))
