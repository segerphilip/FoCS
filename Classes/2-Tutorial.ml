(* Review of Discrete:
  sets
    0 - empty set
    A U B - union
    A n B - intersection
    a e A - member of set
    A _c B - every element of A is an element of B
    A = B iff A _c B, B _c A
    A X B = {(a,b | a e A, b e B)}   ---> form of {x | P(x)}
    A is a finitie set if you can count the amount of n elements
    A is an infinite set otherwise

  functions
    f: A --> B    
      not an algorithm, just says mapping between A to some 1 element of B

  interesting function things
    f: A --> B is one-to-one
      if it maps distinct elements to distinct elements
    f: A --> B is onto
      if every element in B is mapped to at least one element in A
    f: A --> B is a correspondence if it is ont-to-one and onto

  functions are complex
  mathematicians do more math (wow)
  computer scientists try decision problems
    yes/no, 1/0, true/false, good/bad

  look at specifically f:A --> {yes, no}
                     | fix a _finite, nonempty alphabelt (sigma)
                     | we'll look at strings over (sigma)
                     | A string (small sigma) over alphabet (sigma)
                       is a finite sequence of elements of (sigma)
                       e.g. if (sigma) = {0,1}, then 011001 is a string
                     | | empty string (epsilon)
                     | | order is important
    The set of all strings over (sigma) is (sigma)*
        (sigma)* is going to be infinite

  operations on strings
    if (small sigma)1 and (small sigma)2 are strings in (sigma)*,
      then (sigma)1 . (sigma)2 is a string in (sigma)*
    (small sigma)^0 = empty set

  A is a set (as part of) a universe U
  C_A: U --> {yes, no}        A <= U
       x --> Yes if x e A
             no if x e A
  from example: f: (sigma)* --> {yes, no}     <-classifying these into bins
                |
                V                       V- classifying these into bins instead
      A_f = {(small sigma) e (sigma)* | f((small sigma)) = yes}

pause
------
pause

A set A of strings over (sigma) (A e (sigma)* ) is called a language over (sigma)

e.g. if (sigma) = {0,1,2,3...,9} then {2,3,5,7,11,13,17,...}
 is a language over {0,1,...,9}
languages inherit operations from their "set-ness"
if "A, B" are languages, A U B, A n B,...

A^2 = A . A (mid dot, not period)
A^3 = A . A . A
A^1 = A
A ^ 0 = {e}
A* = A^0 U A^2 u A^3 U ... = U(where k >= 0) of A^k

Called the Regular Operations

Given (sigma), start with 0 and {a} for a e (sigma)
  apply the regular operations
The resulting languages are called the regular languages

Regular expressions
REGEXP ::= 1   (empty regular expressions)
           0   (never matches)
           a   (for a e (sigma))
           REGEXP1 + REGEXP2   (or)
           REGEXP1 REGEXP2   (sequential)
           REGEXP *   (repeated)
           (REGEXP)   (group with parenthesis)
    e.g. ab(c)*
    ab, abc, abcc, abccc, abccccc...
    ab + ac = a(b + c)

Define L(R) to be the set of all strings matched by R
                                                    |->regular expression
    L(1) = {e}
    L(0) = empty set 0
    L(a) = {a}
    L(R_1 + R_2) = L(R_1) U L(R_2)
    L(R_1 R_2) = L(R_1) . L(R_2)
    L(R* ) = (L(R))*

Shows that:
  The regular languages are exactly the languages that correspond to
  regular expressions

Given a regular expression R
  match_R: (sigma)* --> {yes, no}
      (small sigma) --> {yes if (small sigma) matches R,
                         no otherwise}

Lang(abc) = Lang(a) . Lang(bc)
          = Lang(a) . (Lang(b) . Lang(c))
          = {a} . ({b} . {c})
          = {a} . ({bc})
          = {abc}

Lang(a(b+c)) = Lang(a) . Lang(b + c)
             = Lang(a) . (Lang(b) U Lang(c))
             = {a} . ({b} U {c})
             = {a} . ({b,c})
             = {ab,ac}
*)

