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


let rec separate (xs) = 
(*    match xs with [] -> ([],[])
               | fst::rst ->  *)
               (* WTS: return -> x1::x2, y1::y2
                     not sure how to proceed *)
   failwith "tried to implement"


(* Question 3 *)

let rec setIn (e,xs) = 
   match xs with [] -> false
               | fst::rst -> if fst = e then
                    true
                else
                    setIn (e,rst)


let rec setSub (xs,ys) = 
   match xs with [] -> true
               | fst::rst -> 
               if setIn (fst, ys) then
                  setSub (rst, ys)
               else
                  false


let setEqual (xs,ys) = 
   if setSub (xs, ys) && setSub (ys, xs) then
      true
   else
      false


let rec setUnion_helper (xs, ys, union) =
   match xs with [] -> append (ys, union)
               | fst::rst -> 
               if setIn (fst, union) then
                  setUnion_helper (rst, ys, union)
               else
                  setUnion_helper (rst, ys, fst::union)


let setUnion (xs,ys) = 
   setUnion_helper (xs, ys, [])


let rec setInter_helper (xs, ys, inter) = 
   match xs with [] -> inter
               | fst::rst -> 
               if setIn (fst, ys) then
                  setInter_helper (rst, ys, fst::inter)
               else
                  setInter_helper (rst, ys, inter)


let setInter (xs,ys) = 
   setInter_helper (xs, ys, [])


let rec setSize_helper (xs, n, total) =
   match xs with [] -> total
               | fst::rst -> 
               if setIn (fst, n) then
                  setSize_helper (rst, n, total)
               else
                  setSize_helper (rst, fst::n, total + 1)

let setSize (xs) = 
   setSize_helper (xs, [], 0)

