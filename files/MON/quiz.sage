import sympy as sp
from random import randint, choice
from time import time

start_time = time()
start_flag = True
score = 0
duration = 240
question_value = 10
correct_answer = -1
x, y = sp.symbols('x y')

def my_mult():
    global question_value
    question_value = 2
    a = randint(0, 19)
    b = randint(0, 19)
    print(f"What is {a} * {b}? Write your answer as answer(<number>)")
    return a * b

def my_deriv():
    global question_value
    question_value = 4
    a, b, c, d = (randint(0, 8) for _ in range(4))
    f = a * x**b + c * x**d
    print("What is the derivative df/dx of the following function? Write your answer as answer(<formula>)")
    sp.pprint(f)
    return sp.diff(f, x)

def my_int():
    global question_value
    question_value = 8
    a, b = (randint(0, 8) for _ in range(2))
    f = a * x**b
    print("What is the indefinite integral dx of the following function? Write your answer as answer(<formula>)")
    sp.pprint(f)
    return sp.integrate(f, x)

def my_frac():
    global question_value
    question_value = 4
    a, b, c, d = (randint(0, 8) for _ in range(4))
    b, d = (max(1, n) for n in [b, d])
    print(f"What is {a}/{b} + {c}/{d}? Write your answer as answer(<formula>)")
    return a / b + c / d

def my_intercept():
    global question_value
    question_value = 30
    solutions = []
    while not solutions:
        a, b, c, d = (randint(1, 2) if i < 2 else randint(1, 5) for i in range(4))
        while b == d:
            d = randint(1, 5)
        f = x**a + b
        g = x**c + d
        sols = sp.solve(f - g, x)
        for sol in sols:
            if isinstance(sol, sp.CRootOf) or not sol.is_real:
                # If solution involves CRootOf or is not real, skip
                print("No real intercepts found. Choosing new functions...")
                solutions = []
                break
            else:
                solutions.append(sol)
    print("What are the intercept(s) of the two functions below?")
    print("Write your answer as, e.g., answer([0,1] or answer([]))")
    print("Type your answer, then close the plot window to continue ...")
    show(f)
    show(g)
    sp.plot(f, g, (x, -3, 3), ylim=(-3, 3), line_color='blue', show=False).show()
    return solutions

def my_simultaneous_equations():
    global question_value
    question_value = 20
    a, b, c, d, e, f = (randint(0, 9) for _ in range(6))
    c = -1 if randint(0, 1) < 1 else 1
    f = -1 if randint(0, 1) < 1 else 1
    rhs1 = c * a + d * b
    rhs2 = e * a + f * b
    print(f"Solve [{c}*x + {d}*y == {rhs1}, {e}*x + {f}*y == {rhs2}]")
    print("Write your answer in the form, e.g., answer([{x: 5}, {y: 3})")
    return [{x: a}, {y: b}]

def my_function():
    global question_value
    question_value = 20
    a, b, d = (randint(1, 2) for _ in range(3))
    c = randint(-2, 2)
    options = {
        0: a * x**b + c,
        1: a * sp.sin(x) + b,
        2: a * sp.cos(x) + b,
        3: a * sp.exp(x) + c,
        4: a * x**2 + b * x,
    }
    f = options[d]

    for i in range(5):
        print(f"f({i}) = {f.subs(x, i).evalf():.4f}")
    print("Determine the function by looking at the plot. Write your answer as answer(<formula>)")
    print("then close the plot to continue ...")
    sp.plot(f, (x, 0, 5), show=False).show()    
    return f

def my_matrix():
    global question_value
    question_value = 20
    a, b, c, d, e, f = (randint(0, 9) for _ in range(6))
    e = randint(0, 1)
    A = sp.Matrix([[a * x**e + f, b], [c, d]])
    print("Calculate the determinant of the matrix below; report your answer as answer(<formula>)")
    sp.pprint(A)
    return A.det()

def answer(user_answer):
    global correct_answer, score, question_value, start_flag
    if start_flag:
        start_flag = False
    else:
        if correct_answer == user_answer:
            score += question_value
            print("Correct!")
        else:
            print(f"Incorrect, answer was {correct_answer}")

    options = [my_matrix, my_deriv, my_int, my_frac, my_simultaneous_equations, my_intercept, my_mult, my_function]
    
    if (time() - start_time) < duration:
        correct_answer = options[randint(0, 7)]()
    else:
        print(f"{duration} seconds have elapsed. Your score is {score}")

answer(0)

