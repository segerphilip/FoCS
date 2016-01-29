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
      if is_coprime (x, n) = true then
         euler_helper (n, x + 1, score + 1)
      else
         euler_helper (n, x + 1, score)


let euler (n) = 
    euler_helper (n, 1, 0)


let rec coprimes_helper (n, x, coprms) =
   if x = 0 then
      coprms
   else 
      if is_coprime (x, n) then
         coprimes_helper (n, x - 1, x::coprms)
      else
         coprimes_helper (n, x - 1, coprms)


let coprimes (n) = 
   coprimes_helper (n, n, [])


(* Question 2 *)

let rec append (xs,ys) =
   match xs with [] -> ys
            | fst::rst -> fst::append (rst, ys)


let rec flatten (xss) = 
   match xss with [] -> []
               | fst::rst -> append (fst, flatten (rst))


let rec last (xs) = 
   match xs with [] -> failwith "empty list"
               | fst::rst -> if rst = [] then
                  fst
               else
                  last (rst)


let rec nth (n,xs) = 
   match xs with [] -> failwith "out of bounds"
               | fst::rst -> if n = 0 then
                  fst
               else
                  nth (n - 1, rst)


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

