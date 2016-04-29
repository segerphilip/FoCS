(* 

HOMEWORK 10

Name: Philip Seger

Email: philip.seger@students.olin.edu

Remarks, if any: all this stuff made a lot of sense
  (mostly because I just finished learning this in my Java course)

*)


(*
 *
 * Please fill in this file with your solutions and submit it
 *
 * The functions below are stubs that you should replace with your
 * own implementation.
 *
 * Always make sure you can #use this file before submitting it.
 * Do that in a _fresh_ OCaml shell 
 * It has to load without any errors.
 *
 *)


type 'a bintree =
  | Empty
  | Node of 'a * 'a bintree * 'a bintree


let sample = Node(10,Node(3,Node(7,Empty,Empty),
                            Node(5,Empty,Empty)),
                     Node(6,Node(99,Empty,
                                 Node(66,Empty,Empty)),
                          Empty))


(* Printing an integer binary tree *)

let pbt bt =
  let rec loop bt depth = 
    match bt with
    | Empty -> ()
    | Node(n,left,right) ->
	(loop right (depth^"    ");
         print_endline (depth^(string_of_int n));
         loop left (depth^"    ")) in
  loop bt ""





(* Q1 *)

let rec size t = 
  match t with
  | Empty -> 0
  | Node(n, left, right) -> 1 + size(right) + size(left)


let rec sum t = 
  match t with
  | Empty -> 0
  | Node(n, left, right) -> n + sum(left) + sum(right)


let rec height t = 
  match t with
  | Empty -> 0
  | Node(n, left, right) -> 1 + max (height(left)) (height(right))


let rec fringe t = 
  match t with
  | Empty -> []
  | Node(n, left, right) -> 
    if (left = Empty && right = Empty) then
      [n]
    else
      fringe(left) @ fringe(right)


let rec map f t = 
  match t with
  | Empty -> Empty
  | Node(n, left, right) -> Node(f n, map f left, map f right)


let rec fold f t b = 
  match t with
  | Empty -> b
  | Node(n, left, right) -> f n (fold f left b) (fold f right b)


let preorder t = 
  fold(fun n left right -> [n] @ left @ right) t []


let postorder t = 
  fold(fun n left right -> left @ right @ [n]) t []


let inorder t = 
  fold(fun n left right -> left @ [n] @ right) t []


let rec bst_insert t x =
  match t with
  | Empty -> Node(x, Empty, Empty)
  | Node(n, left, right) -> 
    if (x < n) then
      Node(n, (bst_insert left x), right)
    else
      Node(n, left, (bst_insert right x))


let rec bst_lookup t x = 
  match t with
  | Empty -> false
  | Node(n, left, right) -> 
    if (n = x) then
      true
    else
      if (n > x) then
        bst_lookup left x
      else
        bst_lookup right x


let rec bstify t =  failwith ("bstify not implemented")
(* fold left/right? *)


let avl_insert t x = failwith ("avl_insert not implemented")
