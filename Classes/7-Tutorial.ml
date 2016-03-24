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
*)





















