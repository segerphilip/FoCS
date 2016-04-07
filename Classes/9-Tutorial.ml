(* 
definitions can refer to one anthoer, but only ones before them, order matters

                          |-> resource usage
Metrics for difficulty/complexity:
  - time (most relevant on a day to day basis)
  - space
  - power (more modern problem, especially mobile)
  - communication

Time complexity in Turing Machines:
  Time unit = a transition of a turing machine
    (given a total TM [one that always halts])
  turing M on (w) = # of transitions before M halts on w.
    |->length of the sequence of configurations
    |->running time of M on input w

  T _M (n) = max {t_M(w) | |w| = n}
    |->running time of M on inputs of length n
    |-> this is TsubM, or my attempt at that notation

examples:
  TM that decides even # of a's
    (two states, loop back, one we've seen before)
    T_M1 (n) = n + 2

  TM that accepts {a^k b^k | k >= 0}
    (check for a's followed by b's, then go back and cross out a b s until none left and equal)
    T_M2 (n) = 3 + 5n/2 + 3n^2/4
              ~ essentially behaves as n^2

Theory of "growth of functions"
  (equivalent to O(n) time complexity)
  f(n) is O(g_(n))
    where some constant c0n0 such that f(n) <= c0g(n) for all n >= n0

ex/rules:
  f is O(f)
  f(n) + c is O(f)
  a0 + a1n + a2n^2 + ... akn^k is O(n^k)
  c is O(1)

  all follow from 2 rules:
    if F is O(f) and G is O(g)
      F(n) + G(n) is O(max(F(n), G(n)))
      F(n) * G(n) is O(F(n)G(n))

The key:
  We care about running time of TMs up to O(-)

  so:
  runtime of M1 is O(n) <--linear complexity (double input, double time required)
  runtime of m2 is O(n^2) <--quadratic (double input, four times as much time required)


              |->language over Σ
Time(F(n)) = {A | there is a TM with running time O(f) ... }

e.x.
  {w | w has even # of a's} == TIME(n)
  {re1#re2 | L(re1) = L(re2)} == TIME(2^n)


PTIME = P = U Time(n^k)   |-> very resistant to changes in models of computation
EXPTIME = U Time(2^n^k)
DEXPTIME = U Time(2^2^n^k)
*)

(* 
RUNNING TIME IN PRACTICE:
  the computational model =_ your PL (programming language)
  subtleties: 
    what unit of time do we use?
      a primitive operation in ocaml
        (+, *, /, a::xs, ...)


    what size of inputs?
      interesting question, let's look at examples


let c_to_f (c) = (9.0 /. 5.0) *. (float c) +. 32.0
(functions that take integer as input)

on input c, T _c_to_f (n) = 4 ~> O(1)

let rec fact (n) = if n <= 0 then 1 else n * fact(n - 1)
(function that takes an integer as input)

T _fact (n) = 1 + 1 + T _fact (n - 1) + 1 = 3 + T _fact (n - 1) ~> O()
          this is a recurrence equation, some hard to solve, some easier
T _fact (n) = 3 + T _fact(n - 1)
            = 3 + 3 + T _fact(n - 2)
            = 3 + 3 + 3 + ...
            = 3 + 3 + ... + 3 + 1
            = 3n + 1
which is ~> O(n)
  (linear on the size of the input which is defined as the magnitude of the size of the integer)

Lists:
  size of input is length of list

let rec length (xs) = match xs with [] -> 0
                              | x::xs' -> length(xs') + 1

T _length (0) = 1
T _length (n) = 2 + T _length (n - 1) = 2n + 1 (eventually) so ~> O(n)

let rec sumFact (xs) = match xs with [] -> 0
                              | x::xs' -> fact(x) + sumFact(xs')

T _sumFact (0) = 1
T _sumFact (n) = 2 + T _sumFact (n - 1) + T _fact (n) ... = 
                                            |->this contributes to time non-trivially


let rec append (xs, ys) = match xs with [] -> ys
                                  | x::xs' -> x :: (append xs' ys)

T _append (0, m) = 1
T _append (n, m) = 2 + T _append (n - 1, m) = 2n + 1 ~> O(n) where n is size of first list
 so input order matters, especially for []               |supposed to be O(n^2), but I messed up

let reverse xs = match xs with [] -> []
                             | x::xs' -> append(reverse(xs'), [x]) 

T _reverse (0) = 1
T _reverse (n) = 2 + T _reverse (n - 1) + append (n - 1, 1)
               = 2 + T _reverse (n - 1) + 2n - 2 + 1
               = 1 + 2n + T _reverse (n - 1)
               = 1 + 2n + 1 + 2(n - 1) + 1 + 2(n - 2) + ...
               = n + 2(n + (n - 1) + (n - 2) + (...)) + 1
               = n + n(n - 1) + 1
               = n^2 + 1


let fast_reverse xs =
  let rec loop xs result = match xs with [] -> result
                                       | x::xs' -> loop xs' (x::result)

loop xs []

T _fast_reverse (n) = T _loop (n, 0)
     T _loop (0, m) = 1
     T _loop (n, m) = 1 + 1 + T _loop (n - 1, m + 1)
                    = 2n + 1 ~> O(n)
*)


















