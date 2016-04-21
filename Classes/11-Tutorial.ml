(* 
Recursive data structures (Trees):
  a list is a bunch of elements, every element is followed by other elements
  a tree is a bunch of elements, however no restriction on the number of next elements

  top element is root, other elements are called nodes, children follow parents,
    and last nodes are called leafs
  height of tree based on the number of levels
      (length of the longest path from root to a leaf)
  if every node in a tree has at most 2 children, it's a binary tree

  Uses for trees:
    1) represent hierarchical data
    2) as a data structure, to make solving a problem easier


Hierarchical data -> parse trees

Arithmetic expressions (aexp)
  a number is an aexp
  if e, f are aexps, e + f and e x f are aexps
          10
          20
          (10 + 20) x 30
  if e is an aexp, (e) is an aexp
  if e is an aexp, -e is an aexp

  can represent with tree:
        x
      +   30    => (10 + 20) x 30
    10 20

eval (T) =
  if T is n, return n.
  if T is +   , return eval(e) + eval(f)
        e   f
  if T is x   , return eval(e) x eval(f)
        e   f
  ...
*)

(* type for arithmetic expressions *)

type aexp = 
  | Number of int
  | Plus of aexp * aexp
  | Times of aexp * aexp
  | Minus of aexp
(* loading that is cool. To make values, ```Number 10;;``` *)


(* size (number of nodes) *)

let rec size t = 
  match t with
  | Number (i) -> 1
  | Plus (e, f) -> 1 + size(e) + size(f)
  | Times (e, f) -> 1 + size(e) + size(f)
  | Minus (e) -> 1 + size(e)


(* height *)

let rec height t = 
  match t with
  | Number (i) -> 1
  | Plus (e, f) -> 1 + max (height e) (height f)
  | Times (e, f) -> 1 + max (height e) (height f)
  | Minus (e) -> 1 + height(e)


(* all_numbers *)

let rec all_numbers t = 
  match t with
  | Number (i) -> [i]
  | Plus (e, f) -> (all_numbers e) @ (all_numbers f)
  | Times (e, f) ->  (all_numbers e) @ (all_numbers f)
  | Minus (e) -> (all_numbers e)


(* evaluate *)

let rec eval t = 
  match t with
  | Number (i) -> i
  | Plus (e, f) -> eval(e) + eval(f)
  | Times (e, f) -> eval(e) * eval(f)
  | Minus (e) -> -(eval(e))


(* testing expression: *)
let test = Times (Plus (Number 10, Number 20), Number 30)



(*
Trees as data structures:
  Problem: representing sets of integers
    operations: taking a set and adding an integer to it (insert)
                looking if an integer is in a set (lookup)
                (is the set empty) <- don't care for this now

  Approach 1: use a list

  Approach 2: binary search tree

*)