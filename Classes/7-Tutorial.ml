(* 
Before break:
-machine models of computation
  -mainly: turing machines
    -definition of computable decision problems
    -covered topics including Church-Turing thesis

-example of noncomputable problem:
  -halting problem
    -given a turing machine and input, does m halt on input w
    -given a turing machine and inputs, does m accept on input w
*)


(* 
  called Post Correspondence Problem (PCP)
Consider the problem:
you have a finite # of domino types (over a finite alphabet)
                          |-> (string on top, string on bottom)
Cam you find a sequence of dominoes d1....dn such that (u d1, v d1), (u d2, v d2), ...
  basically that the string described by the top of the dominoes equals the string
  described by the bottom of the dominoes
    u d1, u d2, ... u dn = v d1, v d2, ... v dn


(a, ab), (b, aa), (a, e) organized into:
   a, b, a, a
  ab, aa

(a, ba), (b, a), (b, ab)
  no solution b/c no doable first start prefix

Thm: PCP (if given a set of dominoes, does it have a solution) is undecidable
Pf: (sketch) if PCP were decidable, then you could decide the acceptance problem (ACC)

Check 3 in moleskine
*)

(* 
Computational Model:
Generative grammars
  Idea: generate strings according to REWRITE rules

  e.g. S -> a S b
       S -> e (<-empty string)

       so for example:
       S -> e
       S -> a S b -> a e b -> ab                            \
       S -> a S b -> a a S b b -> aabb                      |-(looks like a^m, b^n)
       S -> a S b -> a a S b b -> a a a S b b b -> aaabbb   /

More info at 3 in moleskine

Claim:
  If A (over some alphabet) is regular, we can construct a grammar G such that
  L(G) = A

  -A is described by a regular expression
  -A is accepted by some DFA

Some cray example: 
  {a^n b^n c^n | n >= 0}

Rules:
S -> A B C
B -> X B' B X
B -> e
B' X -> X B'
A -> A A
A -> e
C -> C C
C -> e

A X -> A'
A' X -> X A'
X C -> C'
X C' -> C' X              <- unavoidable to not use complex left side rules 
A' -> a                                              (5 in this example)
B' -> b
C' -> c

e.g.
S -> A |B| C
  -> A X B' |B| X C
  -> A X B' X B' |B| X X C
  -> A X |B' X| B' X X C
  -> |A| X X B' B' X X C
  -> A |A X| X B' B' X X C
  -> A A' X B' B' X X C
  -> |A X| A' B' B' X X C
  -> A' A' B' B' X X C
  -> A' A' B' B' X |X C| C
  -> A' A' B' B' |X C'| C
  -> A' A' B' B' C' |X C|
  -> A' A' B' B' C' C'
  -> aa bb cc (' characters are a bit redundant, but 
               is nice to only produce terminal characters at end)


A /grammar\ G is *context-free* if every rule of G has the form
                  X -> w
for some X in N

A /language\ is context-free if (backwards E) context-free grammar that generates it

Thm: The problem of deciding, given an unrestrictive grammar G and string w, whether 
     G can generate w is undecidable
     Why? B/c we can implement TMs in unrestricted grammars!


e.g. of first TM where:
M accepts ab, G should generate ab

A1
  -> qs |A2|
  -> qs [|-. |-] A2
  -> qs [|-, |-] [a, a] |A2|
  -> qs [|-, |-] [a, a] [b, b] |A2|
  -> qs [|-, |-] [a, a] [b, b] |A3|
  -> qs [|-, |-] [a, a] [b, b] [e,  ] |A3|
  -> |qs [|-, |-]| [a, a] [b, b] [e,  ]
  -> [|-, |-] |a1 [a, a]| [b, b] [e,  ]
  -> [|-, |-] |[a, a] q_acc| [b, b] [e,  ]
  -> |[|-, |-] q_acc| a q_acc [b, b] [e,  ]
  -> qacc a q_acc [b, b] [e,  ]
  -> a |q_acc| b q_acc [e,  ]
  -> a b |q_acc [e,  ]|
  -> a b |q_acc| q_acc
  -> a b |q_acc|
  -> a b

A language A is grammar-decidable if there exists a grammar G s.t. L(G) = A.
A is grammar-decidable exactly when A is Turing-decidable.
*)

