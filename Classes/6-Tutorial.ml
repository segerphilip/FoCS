(*  
Next lecture: March 10, small inclass midterm (email w/ details soon)
is a language regular. if regular, design a expression for this language.
  that level of complexity
*)

(* 
limits of undecideability/decidability - church-turing thesis

question is are there decision problems that are not computable: answer is YES
  there must be at least one, b/c there are more languages than turing machines

Def: 
  Two sets A, B are equipollent (have the same "size") if you can match 
  the elements of A with the elements of B 
  (i.e. there exists a function F from A to -> B that is 1 to 1 and onto)

Def:
  A <~(smaller or equal) B if there is a C subset of B such that A ~~ C 
      =_ there is a one to one function from A -> B
      =_ there is an onto function from B -> A

Check notebook @ 2

*)

(* 
Consider a new TM I:
  on input x:
    1 - rewrite x into <Mx>#x
    2 - simulates K on <Mx>#x (<- this input)
          accept if K rejects, go into infinite loop if K accepts

I is a Turing Machine.
We can ask if I halts on any given input.
  Does I halt on input <I>?
    Yes? - When K rejects <I>#<I>
          When I does not halt on <I>. WTF?!?
    No?  - When I does not halt on <I> 
          then K accepts <I>#<I>
          then I halts on <I>       WTF?!?

 


*)
