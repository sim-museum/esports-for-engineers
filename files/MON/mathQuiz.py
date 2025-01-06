#!/usr/bin/python3

import os
import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
from random import randint, choice
from time import time
from sympy import sin, cos, exp, sqrt

class MathQuiz:
    def __init__(self, duration=240):
        self.x, self.y = sp.symbols('x y')
        self.start_time = time()
        self.score = 0
        self.duration = duration
        
    def is_time_remaining(self):
        return (time() - self.start_time) < self.duration
        
    def generate_mult_question(self):
        a, b = randint(0, 19), randint(0, 19)
        print(f"What is {a} * {b}?")
        return a * b, 2
        
    def generate_deriv_question(self):
        a, b, c, d = (randint(0, 8) for _ in range(4))
        f = a * self.x**b + c * self.x**d
        print("What is the derivative df/dx of:")
        print(sp.pretty(f))
        return sp.diff(f, self.x), 4
        
    def generate_int_question(self):
        a, b = (randint(0, 8) for _ in range(2))
        f = a * self.x**b
        print("What is the indefinite integral dx of:")
        print(sp.pretty(f))
        return sp.integrate(f, self.x), 8
        
    def generate_frac_question(self):
        a, b, c, d = (randint(0, 8) for _ in range(4))
        b, d = max(1, b), max(1, d)
        print(f"What is {a}/{b} + {c}/{d}?")
        return sp.Rational(a, b) + sp.Rational(c, d), 4

    def generate_matrix_question(self):
        a, b, c, d, e, f = (randint(0, 9) for _ in range(6))
        e = randint(0, 1)
        A = sp.Matrix([[a * self.x**e + f, b], [c, d]])
        print("Calculate the determinant of the matrix:")
        print(sp.pretty(A))
        return A.det(), 20

    def generate_simultaneous_equations(self):
        a, b, c, d, e, f = (randint(0, 9) for _ in range(6))
        c = -1 if randint(0, 1) < 1 else 1
        f = -1 if randint(0, 1) < 1 else 1
        rhs1 = c * a + d * b
        rhs2 = e * a + f * b
        print(f"Solve: {c}*x + {d}*y = {rhs1}")
        print(f"       {e}*x + {f}*y = {rhs2}")
        print("Enter answer as: [x, y]")
        return [a, b], 20

    def generate_intercept_question(self):
        while True:
            a, c = (randint(1, 2) for _ in range(2))
            b, d = (randint(1, 5) for _ in range(2))
            if b != d:
                f = self.x**a + b
                g = self.x**c + d
                solutions = [sol for sol in sp.solve(f - g, self.x) if sol.is_real]
                if solutions:
                    break

        print("Find the x-coordinates where these functions intersect:")
        print(f"f(x) = {f}")
        print(f"g(x) = {g}")
        print("Enter answer as: [expr1, expr2] or (expr1, expr2)")
        print("You can use 'sqrt' in expressions, e.g., (1-sqrt(5))/2")
        
        x_vals = np.linspace(-3, 3, 100)
        f_lambda = sp.lambdify(self.x, f)
        g_lambda = sp.lambdify(self.x, g)
        
        plt.figure()
        plt.plot(x_vals, f_lambda(x_vals), 'b-', label=str(f))
        plt.plot(x_vals, g_lambda(x_vals), 'r-', label=str(g))
        plt.grid(True)
        plt.legend()
        plt.show()
        
        return solutions, 30

    def generate_function_question(self):
        a, b = (randint(1, 2) for _ in range(2))
        c = randint(-2, 2)
        functions = [
            a * self.x**b + c,
            a * sin(self.x) + b,
            a * cos(self.x) + b,
            a * exp(self.x) + c,
            a * self.x**2 + b * self.x,
            a * cos(self.x) + b * exp(self.x)
        ]
        f = choice(functions)

        print("Given these function values:")
        for i in range(5):
            print(f"f({i}) = {float(f.subs(self.x, i)):.4f}")

        x_vals = np.linspace(0, 5, 100)
        f_lambda = sp.lambdify(self.x, f, modules=['numpy'])
        plt.figure()
        plt.plot(x_vals, f_lambda(x_vals))
        plt.grid(True)
        plt.show()
        
        return f, 20

    def check_answer(self, user_answer, correct_answer):
        # Handle list answers (simultaneous equations and intercepts)
        if isinstance(correct_answer, list):
            try:
                # Parse the user input for intercept answers
                if isinstance(user_answer, str) and "sqrt" in user_answer:
                    # Remove brackets/parentheses and split
                    user_input = user_answer.strip('[]() ').split(',')
                    # Convert each expression to sympy and simplify
                    user_vals = [sp.simplify(sp.sympify(x.strip())) for x in user_input]
                    # Convert to float for comparison
                    user_floats = [float(sp.N(x)) for x in user_vals]
                    correct_floats = [float(sp.N(x)) for x in correct_answer]
                    # Compare sorted values with tolerance
                    return all(abs(u - c) < 1e-6 
                             for u, c in zip(sorted(user_floats), sorted(correct_floats)))
                
                # Handle other list-type answers
                user_list = eval(user_answer) if isinstance(user_answer, str) else user_answer
                if len(user_list) != len(correct_answer):
                    return False
                return all(abs(float(u) - float(c)) < 1e-6 
                          for u, c in zip(sorted(user_list), sorted(correct_answer)))
            except Exception as e:
                print(f"Error checking answer: {e}")
                return False

        # Handle symbolic expressions
        if isinstance(correct_answer, sp.Expr):
            try:
                user_simplified = sp.simplify(sp.sympify(user_answer))
                correct_simplified = sp.simplify(correct_answer)
                return sp.simplify(user_simplified - correct_simplified) == 0
            except:
                return False

        # Handle numerical answers
        try:
            return abs(float(user_answer) - float(correct_answer)) < 1e-6
        except:
            return False

    def run(self):
        question_generators = [
            self.generate_mult_question,
            self.generate_deriv_question,
            self.generate_int_question,
            self.generate_frac_question,
            self.generate_matrix_question,
            self.generate_simultaneous_equations,
            self.generate_intercept_question,
            self.generate_function_question
        ]
        
        while self.is_time_remaining():
            generator = choice(question_generators)
            correct_answer, points = generator()
            
            try:
                user_input = input("Your answer: ")
                if self.check_answer(user_input, correct_answer):
                    self.score += points
                    print(f"Correct! +{points} points")
                else:
                    self.score -=10
                    print(f"Incorrect. -10 points. The answer was {correct_answer}")
            except Exception as e:
                print(f"Invalid input format: {e}")
                self.score -=10
                print(f"Incorrect. -10 points. The answer was {correct_answer}")

                
            time_left = self.duration - (time() - self.start_time)
            if time_left>0:
                print(f"Current score: {self.score} (Time remaining: {int(time_left)} seconds)\n\n")
            
        print(f"\nTime's up! Final score: {self.score}")

if __name__ == "__main__":
    os.system('clear')
    print("Math Quiz: Answer as many questions as possible in 3 minutes\n\n")
    quiz = MathQuiz()
    quiz.run()

