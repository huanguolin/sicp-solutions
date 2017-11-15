#lang racket

(provide ch2)

(define ch-1
  (cons "Introduction to Data Abstraction"
        (list "Example: Arithmetic Operations for Rational Numbers"
              "Abstraction Barriers"
              "What Is Meant by Data?"
              "Extended Exercise: Interval Arithmetic")))
(define ch-2
  (cons "Hierarchical Data and the Closure Property"
        (list "Representing Sequences"
              "Hierarchical Structures"
              "Sequences as Conventional Interfaces"
              "Example: A Picture Language")))
(define ch-3
  (cons "Symbolic Data"
        (list "Quotation"
              "Example: Symbolic Differentiation"
              "Example: Representing Sets"
              "Example: Huffman Encoding Trees")))
(define ch-4
  (cons "Multiple Representations for Abstract Data"
        (list "Representations for Complex Numbers"
              "Tagged data"
              "Data-Directed Programming and Additivity")))
(define ch-5
  (cons "Systems with Generic Operations"
        (list "Generic Arithmetic Operations"
              "Combining Data of Different Types"
              "Example: Symbolic Algebra")))

(define ch2
  (cons "Building Abstractions with Data"
        (list ch-1
              ch-2
              ch-3
              ch-4
              ch-5)))


