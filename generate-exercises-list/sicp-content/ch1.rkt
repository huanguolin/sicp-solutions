#lang racket

(provide ch1)

(define ch-1
  (cons "The Elements of Programming"
        (list "Expressions"
              "Naming and the Environment"
              "Evaluating Combinations"
              "Compound Procedures"
              "The Substitution Model for Procedure Application"
              "Conditional Expressions and Predicates"
              "Example: Square Roots by Newton’s Method"
              "Procedures as Black-Box Abstractions")))
(define ch-2
  (cons "Procedures and the Processes They Generate"
        (list "Linear Recursion and Iteration"
              "Tree Recursion"
              "Orders of Growth"
              "Exponentiation"
              "Greatest Common Divisors"
              "Example: Testing for Primality")))
(define ch-3
  (cons "Formulating Abstractions with Higher-Order Procedures"
        (list "Procedures as Arguments"
              "Constructing Procedures Using lambda"
              "Procedures as General Methods"
              "Procedures as Returned Valuesn")))

(define ch1
  (cons "Building Abstractions with Procedures"
        (list ch-1
              ch-2
              ch-3)))


