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
(* can be called as add 1 3;; or (add 1) 3;; *)


(* 
Code the following functions by direct recursion

removeEmpty: 'a list list -> 'a list list     removeEmpty [[1;2;3];[];3] = [[1;2];[3]] 

filter : ('a -> bool) -> 'a list -> 'a list   filter odd [1;2;3;4;5;6] = [1;3;5]
*)

let rec removeEmpty xs = 
  match xs with [] -> []
              | fst::rst -> if List.length fst > 0 then
                              fst :: removeEmpty (rst)
                            else
                              removeEmpty (rst)


let odd n = (n mod 2 = 1)

let rec filter p xs = 
  match xs with [] -> []
              | fst::rst -> if (p fst) then 
                              fst :: filter p rst
                            else
                              filter p rst
(* only thing with ^ to be aware of, watch parentheses, they can break everything *)

let rec map_append f xs =   (* takes 1 after other arguments, takes ('a -> b' list) -> 'a list -> 'b list  *)
  match xs with [] -> []
              | fst::rst -> (f fst) @ (map_append f rst)
(* example: map_append (fun x -> [x;x+1;x+2]) [10;20;30];; *)

(* 
Code with map_append
  flatten : 'a list list -> 'a list       flatten [[1;2];[];[3]] = [1;2;3]

  filter : ('a -> bool) -> 'a list -> 'a list   filter odd [1;2;3;4] = [1;3]
*)

let flatten2 xs =
  map_append (fun x -> x) xs

let filter2 p xs =
  map_append (fun x -> if p x then [x] else []) xs

(* First map used ::, map_append used @, map_general1 uses comb function *)
let rec map_general1 comb f xs = 
  match xs with [] -> []
              | fst::rst -> comb (f fst) (map_general1 comb f rst)
(* V same as before, just now using map_general1 *)
let map2 f xs = map_general1 (fun x y -> x::y) f xs
let map_append2 f xs = map_general1 (fun x y -> x@y) f xs

(* Even better V *)
let rec map_general comb xs = 
  match xs with [] -> []
              | fst::rst -> comb fst (map_general comb rst)
(* V same as before, now using better map_general *)
let map3 f xs = map_general (fun x y -> (f x) :: y) xs
let map_append3 f xs = map_general (fun x y -> (f x) @ y) xs

(* map_general can't deal with: *)
let rec sum xs =
  match xs with [] -> 0   (* map_general returns the list, doesn't work with sum *)
              | fst::rst -> fst + sum (rst)
(* we can make it (sum) better *)
let rec sum_general comb xs =
  match xs with [] -> 0
              | fst::rst -> comb fst (sum_general comb rst)

(* well why don't we make the base case a parameter!!! *)

(* legit name is    **fold_right**   *)
let rec general comb xs base = 
  match xs with [] -> base
              | fst::rst -> comb fst (general comb rst base)
(* ^^^ LITERALLY the most general of all cases *)
(* e.x. general (fun x y -> (x + 1)::y) [1;2;3;4] [];; *)