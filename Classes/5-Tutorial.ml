(* 
Map, Filter, fold-right ==> higher-order functions
    |
fold-left (variant on fold-right) ~ steps (sort of recurses the same way)
 *)

(* Finite automata
    ~(deterministic) FA
    |||
  accept exactly the regular languages
                      |||
                    languages described by regular expressions

automata for palindrome (impossible), remembering has to be saved in the structure
      |- not regular
{a^n b^n | n>= 0} = {E, ab, aabb, aaabbb} not regular, can't remember n
 *)

(* FA: finite control

Turing machine: finite control + RAM (SAM? sequential, not random)
                                  |- literature calls it "tape" (old school)
tape looks like:
__________________________________
| - | a | b | c | d | _ | _ |  
----------------------------------
              ^  <-tape head pointing at cell with c in it
  Intuition:
    1 - tape starts with the input string on it
    2 - tape head on left most cell
    3 - control starts in start state
    4 - transition based on current state + the symbbol under the tape head
    5 - continue until you reach an accept or reject state

  Transitions:
    from the current state & symbol under the tape head*:
      - move to a new state
      - write a new symbol under the tape head
      - move the tape left or right

    *-(T)uring (M)achines are deterministic

    transitions look like this:
      p ----> q       <-transition
          a/b, L (or R)           <-under tape head, if a converts to b, then moves tape head L (or R)

Example1:
  TM that accepts all strings over {a, b} with an even number of a's
    (tape looks like - a b a b _ _ _ )
                     |- left most tape start, looks like |-
  start -> O -(|-/|-,R) -> O - (a/a,R) -> O - (a/a,R) - < move back to 2nd
                            ^             ^
                            |             |
                          (b/b,R)      (b/b,R)
                            |             |
                            v             v
                       (loop back up)  (loop back up)
      
      ends on space character from tape, which goes from 2nd to accept statement, and (_/_,R)
          else (_/_,R) and reject
      any transition not given in the diagram goes to the reject state
real drawing of ^^^ in moleskin at #1

Example2:
  real drawing in moleskin at #2
    Give a TM that accepts all strings over {a,b} that end with two a's
      REMEMBER: you can move both right and left on the tape, going to the end is possible

Example3:
  real drawing in moleskin at #3
    TM that accepts strings over {a,b} of the form:
      a^n b^n for any n
        1) make sure the tape has a's followed by b's (aaabb...)
        2) make passes left to right Xing out one a and one b everytime

Difference between TA and FA is that stuff is written on the tape and you can overwrite it
*)































