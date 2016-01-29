(* 

HOMEWORK 1

Name: Philip Seger

Email: philip.seger@students.olin.edu

Remarks, if any: 

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


let rec euler_helper (n, x, score) = 
   if x > n then
      score
   else
      if is_coprime(x, n) = true then
         euler_helper(n, x + 1, score + 1)
      else
         euler_helper(n, x + 1, score)


let euler (n) = 
    euler_helper(n, 1, 0)


let coprimes (n) = 
   failwith "not implemented"



(* Question 2 *)

let rec append (xs,ys) =
   match xs with [] -> append ([], ys)
            | fst1::[] -> append ()
            | fst1::rst1 -> 


let rec ziplist (l1, l2) =
  match l1 with [] -> [] 
            |   fl1::rl1 -> 
            match l2 with [] -> []
                      |   fl2::rl2 -> fl1::fl2::ziplist(rl1, rl2)


(* let flatten (xss) = 
   match xss with [] -> xss
               | fst::rst -> flatten (rst)
   failwith "not implemented" *)


let last (xs) = 
   failwith "not implemented"


let nth (n,xs) = 
   failwith "not implemented"


let separate (xs) = 
   failwith "not implemented"



(* Question 3 *)

(* let setIn (e,xs) = 
   match xs with [] -> false
               | fst::rst -> if fst = e then
                    true
                else
                    setIn(e,rst) *)


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

