(* 
Conceptual:
  recursive processes (solve in terms of smaller problems) 1

  iterative processes (for loops) 2

Concrete (programming):
  1:
    recursion (functions that can call themselves and not break)

  2:
    while/for loops

in ocaml, both recursive and iterative processes linked to recursion
in python, is a bit more close to iterative processes with while/for loops over lists instead of recursion
*)

let rec length_recur l =
  match l with
  | [] -> 0
  | _::xs -> 1 + length xs

(* 
through recursion, this is straightforward. thinking through iterative, it's more interesting

possible iterative implementation:
*)

let length_iter l =
  let rec loop l current = 
    match l with
    | [] -> current
    | _::xs -> loop xs (current + 1) 
  in loop l 0

(* 
still recursive, but does something completely different than first length

length_recur [1;2;3;4]
= 1 + length [2;3;4]
= 1 + (1 + length [3;4])
= 1 + (1 + (1 + length [4]))
= 1 + (1 + (1 + (1 + length [])))
= 1 + (1 + (1 + (1 + 0)))
= 4

length_iter [1;2;3;4]
= loop [1;2;3;4] 0
= loop [2;3;4] 1
= loop [3;4] 2
= loop [4] 3
= loop [] 4
= 4

*)

(* And so now DFS and BFS in OCAML *)


(* let search_dfs next start goal =
  let rec dfs current seen =
    if current = goal then 
      true
    else if  *)


let iter_search_dfs next start goal =
  let rec dfs stack seen =
    match stack with
    | [] -> false
    | current::rest -> 
      if current = goal then true
      else if List.mem current seen then dfs rest seen
      else let _ = print_endline ("Visiting "^current) in
          dfs ((next current)@ rest) (current::seen) in
    dfs [start] []


(* And now for something completely different *)

(* Dynamic programming *)
let rec fib1 n =
  if n < 2 then 1
  else fib1(n - 2) + fib1(n - 1)

(* slow, so use memoization (remembering previously computed values in a table) to speed it up *)

let make_table () = []
let mem x t = List.exists (fun (y, _) -> x = y) t
let lookup x t = match List.find (fun (y, _) -> x = y) t with (_, v) -> v
let insert x v t = (x, v)::t

let rec fib2 =
  let rtable = ref (make_table ()) in
  let rec fib n =
    if mem n (!rtable) then lookup n (!rtable)
    else if n < 2 then 1
    else
      let v = fib(n - 2) + fib(n - 1) in
      let _ = rtable := insert n v (!rtable) in
        v   in
  fib


(* recursion when there are "overlapping instances"

  fib(n-1) and fib(n-2) have comminality between the two
    subproblems are in common

In this case, straight recursion will be slow
  -using memoization speeds it up considerably (avoids duplication)
    -"dynamic programming"


*)










