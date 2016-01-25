(* return max int in a list of ints *)
let rec listmax xs =
  match xs with [] -> failwith "empty"
            |   h::[] -> h
            |   h::t -> max h (listmax t)


(* zip two lists together, ex. a1 b1 a2 b2 from a1 a2... b1 b2... *)
let rec ziplist (l1, l2) =
  match l1 with [] -> [] 
            |   fl1::rl1 -> 
            match l2 with [] -> []
                      |   fl2::rl2 -> fl1::fl2::ziplist(rl1, rl2)


(* compress removes consecutive duplicates *)
let rec compress lst = 
  match lst with
  | [] -> []
  | [x] -> [x]
  | [x;y] -> if x = y then [x] else [x;y]
  | x1::x2::rest -> if x1 = x2 then compress(x2::rest) else x1::compress(x2::rest)
