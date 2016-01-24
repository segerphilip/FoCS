(* 

HOMEWORK 1

Name: Philip Seger

Email: philip.seger@students.olin.edu

Remarks, if any: 
   With 1,b, the simplest solution uses the previous problem's
   answer. Is this acceptable, or should the answers all be
   standalone from each other?

*)


(*
 *
 * Please fill in this file with your solutions and submit it
 *
 * The functions below are stubs that you should replace with your
 * own implementation.
 *
 * Always make sure you can #use this file before submitting it.
 * It has to load without any errors.
 *
 *)



(* Question 1 *)

let rec gcd (a,b) = 
   if a = 0 || b = 0 then
      if a = 0 then
         b
      else
         a
   else
      if a >= b then
         gcd (a - b, b)
      else
         gcd (a, b - a)


let rec is_coprime (a,b) = 
   if gcd (a, b) = 1 then
      true
   else
      false


let rec euler (n) = 
   (* idea: is_coprime (n, n-1) + euler(n - 1) *)
   failwith "not implemented"


let coprimes (n) = 
   failwith "not implemented"



(* Question 2 *)

let rec append (xs,ys) =
   match xs with [] -> []
            | fst::lst -> fst


let flatten (xss) = 
   failwith "not implemented"


let nth (n,xs) = 
   failwith "not implemented"


let last (xs) = 
   failwith "not implemented"


let separate (xs) = 
   failwith "not implemented"



(* Question 3 *)

let setIn (e,xs) = 
   failwith "not implemented"


let setSub (xs,ys) = 
   failwith "not implemented"


let setEqual (xs,ys) = 
   failwith "not implemented"


let setUnion (xs,ys) = 
   failwith "not implemented"


let setInter (xs,ys) = 
   failwith "not implemented"


let setSize (xs) = 
   failwith "not implemented"

