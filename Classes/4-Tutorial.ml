(* 2/11/16
Warmup exercise
Code with direct recursion (no helper function):

squares : int list -> int list    squares [1;2;3] = [1;4;9]

diags : 'a list -> ('a * 'a) list       diags [1;2;3] = [(1,1);(2,2);(3,3)]

lengths : 'a list list -> int list      lengths [[1;2];[];[3]] = [2;0;1]
 *)

let rec squares (xs) = 
  match xs with [] -> []
              | fst::rst -> fst * fst :: squares (rst)


let rec diags (xs) =
  match xs with [] -> []
              | fst::rst -> (fst, fst) :: diags (rst)


let rec lengths (xs) =
  match xs with [] -> []
              | fst::rst -> List.length fst :: lengths (rst)

(* 
Structurally, they all look practically the same.
e.x.
let rec NAME xs =
  match xs with [] -> []
            | fst::rst -> ZZZ x :: NAME rst
 
So we use a function map to generalize this for any function f
 *)

let rec map (f, xs) = 
  match xs with [] -> []
              | fst::rst -> f fst :: map (f, rst)

(* 
So can call it with e.x.
 let square x = x * x 

  map (square, [1;2;3])

So looking for something like the function that let's us do this...
e.x.
let f = fun x -> x + 1;;

With this, we can:
map ( (fun x -> x * 3), [1;2;3;4]);;


Next warmup (use map function probably)

daigs3 : 'a list -> ('a * 'a * 'a) list     diags3 [1;2;3] = [(1,1,1);(2,2,2);(3,3,3)]

thirds : ('a * 'b * 'c) list -> 'c list     thirds [(1,2,3);(4,5,6)] = [3;6]

distribute : 'a * ('b list) -> ('a * 'b) list   distribute ("h", [1;2;3]) = [("h", 1); ("h", 2); ("h", 3)]
 *)

let diags3 (xs) =
  map ( (fun x -> (x, x, x)), xs)

let thirds (xs) =
  map ( (fun x -> match x with (a, b, c) -> c), xs)

let distribute (a, xs) =
  map ( (fun x -> (a, x)), xs)

(* another interesting way for distribute with helper: *)

let distribute2 (y, xs) = 
  let mkPair x = (y, x) in
    map (mkPair, xs)


let distribute3 (y, xs) = 
  map (create_mkPair y, xs)

let create_mkPair y = (fun x -> (y, x))
(* which could also be written as: *)
let create_mkPair2 y x = (y, x)
(* but mind you, arrows associate to the right e.x. a->b->c =is actually=> a->(b->c) *)
(* with that idea, we can simplify a lot *)
let add x y = x + y  (* but don't use parenthesis around x y *)
let incr = add 1     (* when written as let fun x y -> curried function *)

























