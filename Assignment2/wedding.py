# Assignment 2 - Exercise: three chairs, Alice, Bob, Charlie - Z3Py version
# Run:  python wedding.py
from z3 import Bool, Solver, Or, And, Not, sat, is_true

people = ["Alice", "Bob", "Charlie"]
chairs = ["left", "middle", "right"]          # index 0, 1, 2

# sits[p][c] is true  <=>  person p sits on chair c
sits = {p: [Bool(f"{p}_{c}") for c in chairs] for p in people}

# ---------- basic rules of seating ----------
basic = []
for p in people:                               # everybody gets at least one chair
    basic.append(Or(sits[p]))
for c in range(3):                             # at most one person per chair
    for i in range(3):
        for j in range(i + 1, 3):
            basic.append(Not(And(sits[people[i]][c], sits[people[j]][c])))

# ---------- the three wishes ----------
A, B, C = sits["Alice"], sits["Bob"], sits["Charlie"]

wishes = {
    "Alice does not sit next to Charlie":
        And(Not(And(A[0], C[1])), Not(And(A[1], C[0])),
            Not(And(A[1], C[2])), Not(And(A[2], C[1]))),
    "Alice does not sit on the leftmost chair":
        Not(A[0]),
    "Bob does not sit to the right of Charlie":
        And(Not(And(C[0], B[1])), Not(And(C[0], B[2])), Not(And(C[1], B[2]))),
}


def solve(active_wishes):
    s = Solver()
    s.add(basic)
    s.add(active_wishes)
    if s.check() != sat:
        return None
    m = s.model()
    return {c: p for p in people for i, c in enumerate(chairs)
            if is_true(m.evaluate(sits[p][i], model_completion=True))}


# The exercise itself: all three wishes together
result = solve(list(wishes.values()))
print("All three wishes:", "sat " + str(result) if result else "unsat -> no such seating exists")

# Extra: drop one wish at a time to show that each of them is really needed
for dropped in wishes:
    rest = [w for name, w in wishes.items() if name != dropped]
    result = solve(rest)
    print(f"Without '{dropped}':", result if result else "unsat")
