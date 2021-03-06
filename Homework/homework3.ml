(* 

HOMEWORK 3

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



(* 
 * String <-> characters utility functions:
 *
 *   explode : string -> char list
 *      returns the list of characters making up a string
 *
 *   implode : char list -> string
 *      concatenates the list of characters into a string
 *
 *)

let explode (str) = 
  let rec acc (index,result) = 
    if (index<0) then
      result
    else
      acc(index-1, (String.get str index)::result)
  in
    acc(String.length(str)-1, [])

let implode (cs) = 
  let str = String.create(List.length(cs)) in
  let rec loop (cs,index) = 
    match cs with
      [] -> str
    | c::cs -> (String.set str index c; loop(cs,index+1))
  in
    loop(cs,0)



(*
 *  The type of a finite automaton
 * 
 *  When the transition relation is a function
 *  (i.e., every p,a has q such that (p,a,q) is in 
 *  delta) then this is a deterministic finite automaton  
 * 
 *)

type 'a fa = { states: 'a list;
               alphabet: char list;
               delta: ('a * char * 'a) list;
               start : 'a;
               accepting : 'a list }




(* QUESTION 1 *)

let rec findTransitionsHelper (delta, q, a) =
  match delta with [] -> []
                    | (x, y, z)::rst -> if x = q && y = a then 
                      (x, y, z) :: findTransitionsHelper(rst, q, a)
                    else
                      findTransitionsHelper(rst, q, a)


let findTransitions (fa,q,a) = 
  findTransitionsHelper (fa.delta, q, a)


let rec isAcceptingHelper (accepting, s) =
  match accepting with [] -> false
                     | fst::rst -> if fst = s then
                       true
                     else
                       isAcceptingHelper(rst, s) 


let isAccepting (fa,s) = 
  isAcceptingHelper(fa.accepting, s)


let step (fa,q,a) = 
  match findTransitions(fa, q, a) with [] -> failwith "Does not exist"
                                          | [(x, y, z)] -> z
                                          | fst::rst -> failwith "Not deterministic"


let rec steps (fa,q,syms) = 
  match syms with [] -> q
                | fst::rst -> steps(fa, step(fa, q, fst), rst)


let rec isDFAHelper (fa, states, alphabet, a) =
  match states with [] -> true
                  | fst::rst -> match alphabet with [] -> isDFAHelper(fa, rst, a, a)
                                                  | fstt::rstt -> if List.length(findTransitions(fa, fst, fstt)) != 1 then
                                                    false
                                                  else
                                                    isDFAHelper(fa, [fst]@rst, rstt, a)               


let isDFA (fa) = 
  isDFAHelper(fa, fa.states, fa.alphabet, fa.alphabet)


let acceptDFA (fa,input) = 
  if isDFA (fa) then
    isAccepting(fa, steps(fa, fa.start, explode(input)))
  else
    failwith "Not deterministic"




(* QUESTION 2 *)

(* THESE ARE PLACEHOLDERS - THEY DEFINE EMPTY AUTOMATA *)
(* REPLACE BY YOUR OWN DEFINITIONS *)


let dfa_q2_a = { states = [0; 1; 2; 3];
		 alphabet = ['a'; 'b'];
		 delta = [(0, 'a', 0);
              (0, 'b', 1);
              (1, 'a', 0);
              (1, 'b', 2);
              (2, 'a', 0);
              (2, 'b', 3);
              (3, 'a', 3);
              (3, 'b', 3);
              ];
		 start = 0;
		 accepting = [0; 1; 2]}


let dfa_q2_b = { states = [0; 1; 2; 3; 4; 5; 6; 7];
		 alphabet = ['a'; 'b'];
		 delta = [(0, 'a', 1);
              (0, 'b', 4);
              (1, 'a', 2);
              (1, 'b', 4);
              (2, 'a', 3);
              (2, 'b', 4);
              (3, 'a', 7);
              (3, 'b', 4);
              (4, 'a', 1);
              (4, 'b', 5);
              (5, 'a', 1);
              (5, 'b', 6);
              (6, 'a', 1);
              (6, 'b', 7);
              (7, 'a', 7);
              (7, 'b', 7);
              ];
		 start = 0;
		 accepting = [0; 1; 2; 3; 4; 5; 6]}


let dfa_q2_c = { states = [0; 1; 2; 3; 4; 5; 6; 7];
		 alphabet = ['a'; 'b'];
		 delta = [(0, 'a', 1);
              (0, 'b', 4);
              (1, 'a', 2);
              (1, 'b', 7);
              (2, 'a', 3);
              (2, 'b', 7);
              (3, 'a', 3);
              (3, 'b', 4);
              (4, 'a', 7);
              (4, 'b', 5);
              (5, 'a', 7);
              (5, 'b', 6);
              (6, 'a', 1);
              (6, 'b', 6);
              (7, 'a', 7);
              (7, 'b', 7);
              ];
		 start = 0;
		 accepting = [3; 6]}


(* NOT FULLY IMPLEMENTED, come back and fix *)
let nfa_q2_d = { states = [0; 1; 2; 3; 4; 5];
		 alphabet = ['a'; 'b'];
		 delta = [(0, 'a', 2);
              (0, 'b', 1);
              (1, 'a', 1);
              (1, 'b', 2);
              (2, 'a', 3);
              (2, 'b', 1);
              (3, 'a', 4);
              (3, 'b', 1);
              (4, 'a', 4);
              (4, 'b', 5);
              (5, 'a', 4);
              (5, 'b', 5);
              ];
		 start = 0;
		 accepting = []}




(* QUESTION 3 *)


let rec keepTarget (trs) = 
  List.sort_uniq compare (List.rev_map (fun (x, y, z) -> z) trs)


let isAcceptingAny (fa,qs) = 
  List.exists (fun x -> isAccepting(fa, x)) qs


let rec stepAll (fa,qs,a) = 
  match qs with [] -> []
              | fst::rst -> keepTarget(findTransitions(fa, fst, a)) @ stepAll(fa, rst, a)


let rec stepsAll (fa,qs,syms) = 
  match qs with [] -> qs
              | fst::rst -> stepsAll(fa, stepAll(fa, qs, fst), rst)


let acceptNFA (fa,input) = 
  isAcceptingAny(fa, stepsAll(fa, [fa.start], explode(input)))




(* 
 * A sample DFA for testing
 *
 * It accepts the language of all strings over {a,b} with a
 * multiple-of-3 number of a's.
 *
 *)

let dfaThreeA = { 
  states = ["start";"one";"two"];
  alphabet = ['a';'b'];
  delta = [ ("start",'a',"one");
	    ("one",'a',"two");
	    ("two",'a',"start");
	    ("start",'b',"start");
	    ("one",'b',"one");
	    ("two",'b',"two") ];
  start = "start";
  accepting = ["start"]
} 



(* A sample NFA for testing
 *
 * It accepts the language of all strings over {a,b,c} 
 * whose last three symbols are b's.
 *
 *)

let nfaLastThreeB = {
  states = [0;1;2;3];
  alphabet = ['a';'b';'c'];
  delta = [ (0,'a',0);
	    (0,'b',0);
	    (0,'c',0);
	    (0,'b',1);
	    (1,'b',2);
	    (2,'b',3); ];
  start = 0;
  accepting = [3]
} 




(* This function is the base function that langDFA and
 * langNFA use -- it basically loops through all the strings
 * of length up to n, and prints those that are accepted by the
 * finite automaton.
 *
 * This is being way too clever to try to not blow the stack 
 * while enumerating all strings up to a given length. Basically.
 * we enumerate all integer, convert them to base K (where K is the
 * size of the alphabet) and then replace every digit base K by the
 * letter of the alphabet at the corresponding index in the alphabet. 
 *
 * The key is that we can enumerate integers super easily
 *
 *)

let langFA accept (fa,n) = 

  let rec expt a n = if n <= 0 then 1 else a*(expt a (n-1)) in
  
  let rec take n default l = 
    if n <= 0 then []
    else (match l with
          | [] -> default::(take (n-1) default l)
          | x::xs -> x::(take (n-1) default xs)) in
  
  let to_base_n base size n = 
    let rec loop n = 
      if n <= 0 then []
      else if n mod base = 0 then 0::(loop (n / base))
      else (n mod base)::(loop ((n - n mod base) / base))  in
    take size 0 (loop n)  in
  
  let to_string alphabet size n = 
    let base = List.length alphabet in
    let num_base = to_base_n base size n in
    implode (List.map (fun i -> List.nth alphabet i) num_base) in
  
  if n < 0 then ()
  else
    let print_str s = if s = "" then print_string "  <epsilon>\n"
  	              else print_string ("  "^s^"\n")  in
    let rec loop i = 
        if i <= n then 
  	  let ts = to_string fa.alphabet i  in
  	  let bound = expt (List.length fa.alphabet) i in
  	  let rec loop2 j = 
  	    if j < bound then (if accept(fa,ts j) 
                                 then print_str (ts j)
                               else ();
  			       loop2 (j+1))
  	    else ()  in
  	  (loop2 0; loop (i+1))
        else ()  in
    loop 0


(* 
 * Tester functions that dump the language accepted by a
 * finite automaton, either deterministic or not
 *
 *)
 
let langDFA x = langFA acceptDFA x
let langNFA x = langFA acceptNFA x

