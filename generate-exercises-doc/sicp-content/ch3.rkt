#lang racket

(provide ch3)

(define ch-1
  (cons "Assignment and Local State"
        (list "Local State Variables"
              "The Benefits of Introducing Assignment"
              "The Costs of Introducing Assignment")))
(define ch-2
  (cons "The Environment Model of Evaluation"
        (list "The Rules for Evaluation"
              "Applying Simple Procedures"
              "Frames as the Repository of Local State"
              "Internal Definitions")))
(define ch-3
  (cons "Modeling with Mutable Data"
        (list "Mutable List Structure"
              "Representing Queues"
              "Representing Tables"
              "A Simulator for Digital Circuits"
              "Propagation of Constraints")))
(define ch-4
  (cons "Concurrency: Time Is of the Essence"
        (list "The Nature of Time in Concurrent Systems"
              "Mechanisms for Controlling Concurrency")))
(define ch-5
  (cons "Streams"
        (list "Streams Are Delayed Lists"
              "Infinite Streams"
              "Exploiting the Stream Paradigm"
              "Streams and Delayed Evaluation"
              "Modularity of Functional Programs and Modularity of Objects")))

(define ch3
  (cons "Modularity, Objects, and State"
        (list ch-1
              ch-2
              ch-3
              ch-4
              ch-5)))


