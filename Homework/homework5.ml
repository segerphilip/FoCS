(* 

HOMEWORK 5

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
 * Do that in a _fresh_ OCaml shell 
 * It has to load without any errors.
 *
 *)




(* 
 * String <-> characters utility functions:
 *
 *   explode : string -> string list
 *      returns the list of characters making up a string
 *
 *)

let explode str = 
  let rec acc index result = 
    if (index<0) then result
    else acc (index-1) ((String.sub str index 1)::result) in
  acc (String.length(str)-1) []


(*
 * Type for deterministic Turing machines
 *
 * Parameterized by type for states
 *)

type symbol = string

type 'a tm = { states : 'a list;
	       input_alphabet : symbol list;
	       tape_alphabet : symbol list;
	       left_marker : symbol;
	       blank : symbol;
	       delta : ('a * symbol) -> ('a * symbol * int);   (* 0 = Left, 1 = Right *)
	       start : 'a;
	       accept : 'a;
	       reject : 'a }

type 'a config = { state : 'a;
		   before: symbol list;
		   after: symbol list }
      
(*
 * Helper function
 *
 * Pint a configuration (including newline) to standard output
 * and RETURN A VALUE
 * 
 *)

let printConfig m config value = 
    let mw = List.fold_right (fun a r -> max (String.length a) r) m.states 0 in
    let _ = print_string (String.sub (config.state^(String.make mw ' ')) 0 mw) in
    let print_syms = List.iter (Printf.printf " %s ")  in
    let _ = print_string "  "  in
    let _ = print_syms config.before  in
    let _ = (match config.after with 
             | [] -> Printf.printf "[%s]" m.blank
	     | a::v' -> let _ = Printf.printf "[%s]" a  in
	                print_syms v') in
    let _ = print_newline ()  in
    value




(* QUESTION 1 *)


let startConfig m w = 
	{
		state = m.start;
		before = [];
		after = m.left_marker::(explode w)
	}


let acceptConfig m config = 
	m.accept = config.state


let rejectConfig m config = 
	m.reject = config.state


let haltConfig m c = 
	(acceptConfig m c) || (rejectConfig m c)


let step m config = failwith "step not implemented"


let run m w = failwith "run not implemented"




(* 
 * Some sample deterministic Turing machines
 *
 * asbs is the regular language {a^m b^n | m,n >= 0}
 * anbn is the non-regular language {a^n b^n | n >= 0}
 * anbncn is the non-regular language {a^n b^n c^n | n >= 0}
 *
 *)

let asbs = { states = ["start"; "q1"; "acc"; "rej"];
	     input_alphabet = ["a";"b"];
	     tape_alphabet = ["a";"b";"_";">"];
	     blank = "_";
	     left_marker = ">";
	     start = "start";
	     accept = "acc";
	     reject = "rej";
	     delta = (fun inp -> match inp with
	                 | ("start", "a") -> ("start", "a", 1)
     			 | ("start", "b") -> ("q1", "b", 1)
			 | ("start", ">") -> ("start", ">", 1)
			 | ("start", "_") -> ("acc", "_", 1)
			 | ("q1", "b") -> ("q1", "b", 1)
			 | ("q1", "_") -> ("acc", "_", 1)
			 | ("acc", "a") -> ("acc", "a", 1)
			 | ("acc", "b") -> ("acc", "b", 1)
			 | ("acc", ">") -> ("acc", ">", 1)
			 | ("acc", "_") -> ("acc", "_", 1)
			 | (_,c) -> ("rej",c,1))}

let anbn = { states = ["start"; "q1"; "q2"; "q3"; "q4"; "acc"; "rej"];
	     input_alphabet = ["a";"b"];
	     tape_alphabet = ["a";"b";"X";"/";"|"];
	     blank = "/";
	     left_marker = "|";
	     start = "start";
	     accept = "acc";
	     reject = "rej";
	     delta = (fun inp -> match inp with
	                 | ("start", "a") -> ("start", "a", 1)
     			 | ("start", "b") -> ("q1", "b", 1)
			 | ("start", "|") -> ("start", "|", 1)
			 | ("start", "/") -> ("q2", "/", 1)
			 | ("q1", "b") -> ("q1", "b", 1)
			 | ("q1", "/") -> ("q2", "/", 1)
			 | ("q2", "|") -> ("q3", "|", 1)
			 | ("q2", "a") -> ("q2", "a", 0)
			 | ("q2", "b") -> ("q2", "b", 0)
			 | ("q2", "X") -> ("q2", "X", 0)
			 | ("q2", "/") -> ("q2", "/", 0)
			 | ("q3", "X") -> ("q3", "X", 1)
			 | ("q3", "/") -> ("acc", "/", 1)
			 | ("q3", "a") -> ("q4", "X", 1)
			 | ("q4", "a") -> ("q4", "a", 1)
			 | ("q4", "X") -> ("q4", "X", 1)
			 | ("q4", "b") -> ("q2", "X", 1)
			 | ("acc", "a") -> ("acc", "a", 1)
			 | ("acc", "b") -> ("acc", "b", 1)
			 | ("acc", "|") -> ("acc", "|", 1)
			 | ("acc", "X") -> ("acc", "X", 1)
			 | ("acc", "/") -> ("acc", "/", 1)
			 | (_,c) -> ("rej",c,1))}


let anbncn = { states = ["start";"q1";"q2";"q3";"q4";"q5";"q6";"acc";"rej"];
	       input_alphabet = ["a";"b";"c"];
	       tape_alphabet = ["a";"b";"c";"X";"_";">"];
	       blank = "_";
	       left_marker = ">";
	       start = "start";
	       accept = "acc";
	       reject = "rej";
	       delta = (fun inp -> match inp with
	                | ("start", "a") -> ("start", "a", 1)
     			| ("start", "b") -> ("q1", "b", 1)
			| ("start", "c") -> ("q6", "c", 1)
			| ("start", ">") -> ("start", ">", 1)
			| ("start", "_") -> ("q2", "_", 1)
			| ("q1", "b") -> ("q1", "b", 1)
			| ("q1", "c") -> ("q6", "c", 1)
			| ("q1", "_") -> ("q2", "_", 1)
			| ("q2", ">") -> ("q3", ">", 1)
			| ("q2", "a") -> ("q2", "a", 0)
			| ("q2", "b") -> ("q2", "b", 0)
			| ("q2", "c") -> ("q2", "c", 0)
			| ("q2", "_") -> ("q2", "_", 0)
			| ("q2", "X") -> ("q2", "X", 0)
			| ("q3", "X") -> ("q3", "X", 1)
			| ("q3", "_") -> ("acc", "_", 1)
			| ("q3", "a") -> ("q4", "X", 1)
			| ("q4", "a") -> ("q4", "a", 1)
			| ("q4", "X") -> ("q4", "X", 1)
			| ("q4", "b") -> ("q5", "X", 1)
			| ("q5", "b") -> ("q5", "b", 1)
			| ("q5", "X") -> ("q5", "X", 1)
			| ("q5", "c") -> ("q2", "X", 1)
			| ("q6", "c") -> ("q6", "c", 1)
			| ("q6", "_") -> ("q2", "_", 1)
		        | ("acc", "a") -> ("acc", "a", 1)
		        | ("acc", "b") -> ("acc", "b", 1)
		        | ("acc", "c") -> ("acc", "c", 1)
		        | ("acc", ">") -> ("acc", ">", 1)
		        | ("acc", "X") -> ("acc", "X", 1)
		        | ("acc", "_") -> ("acc", "_", 1)
			| (_,c) -> ("rej", c,1))}



(* QUESTION 2 *)

(* THESE ARE PLACEHOLDERS - THEY DEFINE EMPTY TURING MACHINES *)
(* REPLACE BY YOUR OWN DEFINITIONS *)


let tm_q2_a = { states = ["start";"q1";"q2";"q3";"q4";"q5";"q6";"acc";"rej"];
		input_alphabet = ["c";"d"];
		tape_alphabet = ["c";"d";"X";"_";">"];
		blank = "_";
		left_marker = ">";
		start = "start";
		accept = "acc";
		reject = "rej";
		delta = (fun inp -> match inp with
			| ("start", ">") -> ("q1", ">", 1)
(* q1 *)
			| ("q1", "X") -> ("q1", "X", 1)
			| ("q1", "c") -> ("q2", "X", 1)
			| ("q1", "d") -> ("q5", "X", 1)
			| ("q1", "_") -> ("acc", "_", 0)
(* q2 *)
			| ("q2", "c") -> ("q2", "c", 1)
			| ("q2", "d") -> ("q2", "d", 1)
			| ("q2", "X") -> ("q2", "X", 1)
			| ("q2", "_") -> ("q3", "_", 0)
(* q3 *)
			| ("q3", "d") -> ("rej", "d", 0)
			| ("q3", "X") -> ("q3", "X", 0)
			| ("q3", "c") -> ("q4", "X", 0)
			| ("q3", ">") -> ("acc", ">", 1)
(* q4 *)
			| ("q4", "c") -> ("q4", "c", 0)
			| ("q4", "d") -> ("q4", "d", 0)
			| ("q4", "X") -> ("q4", "X", 0)
			| ("q4", ">") -> ("q1", ">", 1)
(* q5 *)
			| ("q5", "c") -> ("q5", "c", 1)
			| ("q5", "d") -> ("q5", "d", 1)
			| ("q5", "X") -> ("q5", "X", 1)
			| ("q5", "_") -> ("q6", "_", 0)
(* q6 *)
			| ("q6", "c") -> ("rej", "c", 0)
			| ("q6", "X") -> ("q6", "X", 0)
			| ("q6", "d") -> ("q4", "X", 0)
			| ("q6", ">") -> ("acc", ">", 1)

			| (_,c) -> ("rej", c,1)
		)}


let tm_q2_b = { states = ["start";"q1";"q2";"q3";"q4";"q5";"q6";"acc";"rej"];
		input_alphabet = ["a";"b"];
		tape_alphabet = ["a";"b";"X";"_";">"];
		blank = "_";
		left_marker = ">";
		start = "start";
		accept = "acc";
		reject = "rej";
		delta = (fun inp -> match inp with
			| ("start", ">") -> ("q1", ">", 1)
(* q1 *)
			| ("q1", "a") -> ("rej", "a", 1)
			| ("q1", "X") -> ("q1", "X", 1)
			| ("q1", "_") -> ("acc", "_", 1)
			| ("q1", "b") -> ("q2", "X", 1)
(* q2 *)
			| ("q2", "a") -> ("q2", "a", 1)
			| ("q2", "b") -> ("q2", "b", 1)
			| ("q2", "X") -> ("q2", "X", 1)
			| ("q2", "_") -> ("q3", "_", 0)
(* q3 *)
			| ("q3", "X") -> ("q3", "X", 0)
			| ("q3", "b") -> ("rej", "b", 0)
			| ("q3", "a") -> ("q4", "X", 0)
(* q4 *)
			| ("q4", "b") -> ("rej", "b", 0)
			| ("q4", "X") -> ("rej", "X", 0)
			| ("q4", "a") -> ("q5", "X", 0)
(* q5 *)
			| ("q5", "b") -> ("rej", "b", 0)
			| ("q5", "X") -> ("rej", "X", 0)
			| ("q5", "a") -> ("q6", "X", 0)
(* q6 *)
			| ("q6", "a") -> ("q6", "a", 0)
			| ("q6", "b") -> ("q6", "b", 0)
			| ("q6", "X") -> ("q6", "X", 0)
			| ("q6", ">") -> ("q1", ">", 1)

			| (_,c) -> ("rej", c,1)

		)}




(* QUESTION 3 *)


let binaryAddition = { states = ["start";"q1";"q2";"q3";"q4";"q5";"q6";"q7";"q8";"q9";"q10";"q11";"q12";"q13";"q14";"q15";"q16";"q17";"q18";"acc";"rej"];
		       input_alphabet = ["0";"1";"#"];
		       tape_alphabet = ["0";"1";"X";"_";">";"@";"$";"%";"&";"#"];
		       blank = "_";
		       left_marker = ">";
		       start = "start";
		       accept = "acc";
		       reject = "rej";
		       delta = (fun inp -> match inp with
							| ("start", ">") -> ("q1", ">", 1)
(* q1 *)
							| ("q1", "1") -> ("q1", "1", 1)
							| ("q1", "0") -> ("q1", "0", 1)
							| ("q1", "#") -> ("q1", "#", 1)
							| ("q1", "_") -> ("q2", "_", 0)
(* q2 *)
							| ("q2", "1") -> ("q3", "X", 0)
							| ("q2", "0") -> ("q3", "X", 0)
							| ("q2", ">") -> ("q5", ">", 1)
(* q3 *)
							| ("q3", "1") -> ("q2", "&", 0)
							| ("q3", "0") -> ("q2", "%", 0)
							| ("q3", "#") -> ("rej", "#", 0)
(* q4 *)
							| ("q4", "1") -> ("q2", "$", 0)
							| ("q4", "0") -> ("q2", "@", 0)
							| ("q4", "#") -> ("q2", "#", 0)
(* q5: comparisons *)
							| ("q5", "X") -> ("q5", "X", 1)
							| ("q5", "#") -> ("q18", "#", 1)
							| ("q5", "&") -> ("q6", "X", 1)
							| ("q5", "%") -> ("q9", "X", 1)
							| ("q5", "$") -> ("q12", "X", 1)
							| ("q5", "@") -> ("q15", "X", 1)
(* q6 & *)
							| ("q6", "@") -> ("q6", "@", 1)
							| ("q6", "$") -> ("q6", "$", 1)
							| ("q6", "%") -> ("q6", "%", 1)
							| ("q6", "&") -> ("q6", "&", 1)
							| ("q6", "0") -> ("q6", "0", 1)
							| ("q6", "1") -> ("q6", "1", 1)
							| ("q6", "X") -> ("q6", "X", 1)
							| ("q6", "#") -> ("q6", "#", 1)
							| ("q6", "_") -> ("q7", "_", 0)
(* q7 *)
							| ("q7", "#") -> ("rej", "#", 0)
							| ("q7", "@") -> ("q7", "@", 0)
							| ("q7", "%") -> ("q7", "%", 0)
							| ("q7", "X") -> ("q7", "X", 0)
							| ("q7", "$") -> ("q7", "$", 0)
							| ("q7", "&") -> ("q8", "X", 0)
(* q8 *)
							| ("q8", "@") -> ("q8", "@", 0)
							| ("q8", "$") -> ("q8", "$", 0)
							| ("q8", "%") -> ("q8", "%", 0)
							| ("q8", "&") -> ("q8", "&", 0)
							| ("q8", "0") -> ("q8", "0", 0)
							| ("q8", "1") -> ("q8", "1", 0)
							| ("q8", "X") -> ("q8", "X", 0)
							| ("q8", "#") -> ("q8", "#", 0)
							| ("q8", ">") -> ("q5", ">", 1)
(* q9 % *)
							| ("q9", "@") -> ("q9", "@", 1)
							| ("q9", "$") -> ("q9", "$", 1)
							| ("q9", "%") -> ("q9", "%", 1)
							| ("q9", "&") -> ("q9", "&", 1)
							| ("q9", "0") -> ("q9", "0", 1)
							| ("q9", "1") -> ("q9", "1", 1)
							| ("q9", "X") -> ("q9", "X", 1)
							| ("q9", "#") -> ("q9", "#", 1)
							| ("q9", "_") -> ("q10", "_", 0)
(* q10 *)
							| ("q10", "#") -> ("rej", "#", 0)
							| ("q10", "@") -> ("q10", "@", 0)
							| ("q10", "&") -> ("q10", "&", 0)
							| ("q10", "X") -> ("q10", "X", 0)
							| ("q10", "$") -> ("q10", "$", 0)
							| ("q10", "%") -> ("q11", "X", 0)
(* q11 *)
							| ("q11", "@") -> ("q11", "@", 0)
							| ("q11", "$") -> ("q11", "$", 0)
							| ("q11", "%") -> ("q11", "%", 0)
							| ("q11", "&") -> ("q11", "&", 0)
							| ("q11", "0") -> ("q11", "0", 0)
							| ("q11", "1") -> ("q11", "1", 0)
							| ("q11", "X") -> ("q11", "X", 0)
							| ("q11", "#") -> ("q11", "#", 0)
							| ("q11", ">") -> ("q5", ">", 1)
(* q12 $ *)
							| ("q12", "@") -> ("q12", "@", 1)
							| ("q12", "$") -> ("q12", "$", 1)
							| ("q12", "%") -> ("q12", "%", 1)
							| ("q12", "&") -> ("q12", "&", 1)
							| ("q12", "0") -> ("q12", "0", 1)
							| ("q12", "1") -> ("q12", "1", 1)
							| ("q12", "X") -> ("q12", "X", 1)
							| ("q12", "#") -> ("q12", "#", 1)
							| ("q12", "_") -> ("q13", "_", 0)
(* q13 *)
							| ("q13", "#") -> ("rej", "#", 0)
							| ("q13", "@") -> ("q13", "@", 0)
							| ("q13", "%") -> ("q13", "%", 0)
							| ("q13", "X") -> ("q13", "X", 0)
							| ("q13", "&") -> ("q13", "&", 0)
							| ("q13", "$") -> ("q14", "X", 0)
(* q14 *)
							| ("q14", "@") -> ("q14", "@", 0)
							| ("q14", "$") -> ("q14", "$", 0)
							| ("q14", "%") -> ("q14", "%", 0)
							| ("q14", "&") -> ("q14", "&", 0)
							| ("q14", "0") -> ("q14", "0", 0)
							| ("q14", "1") -> ("q14", "1", 0)
							| ("q14", "X") -> ("q14", "X", 0)
							| ("q14", "#") -> ("q14", "#", 0)
							| ("q14", ">") -> ("q5", ">", 1)
(* q15 @ *)
							| ("q15", "@") -> ("q15", "@", 1)
							| ("q15", "$") -> ("q15", "$", 1)
							| ("q15", "%") -> ("q15", "%", 1)
							| ("q15", "&") -> ("q15", "&", 1)
							| ("q15", "0") -> ("q15", "0", 1)
							| ("q15", "1") -> ("q15", "1", 1)
							| ("q15", "X") -> ("q15", "X", 1)
							| ("q15", "#") -> ("q15", "#", 1)
							| ("q15", "_") -> ("q16", "_", 0)
(* q16 *)
							| ("q16", "#") -> ("rej", "#", 0)
							| ("q16", "&") -> ("q16", "&", 0)
							| ("q16", "%") -> ("q16", "%", 0)
							| ("q16", "X") -> ("q16", "X", 0)
							| ("q16", "$") -> ("q16", "$", 0)
							| ("q16", "@") -> ("q17", "X", 0)
(* q17 *)
							| ("q17", "@") -> ("q17", "@", 0)
							| ("q17", "$") -> ("q17", "$", 0)
							| ("q17", "%") -> ("q17", "%", 0)
							| ("q17", "&") -> ("q17", "&", 0)
							| ("q17", "0") -> ("q17", "0", 0)
							| ("q17", "1") -> ("q17", "1", 0)
							| ("q17", "X") -> ("q17", "X", 0)
							| ("q17", "#") -> ("q17", "#", 0)
							| ("q17", ">") -> ("q5", ">", 1)
(* q18 *)
							| ("q18", "X") -> ("q18", "X", 1)
							| ("q18", "#") -> ("q18", "#", 1)
							| ("q18", "_") -> ("acc", "_", 1)

							| (_,c) -> ("rej", c,1)
		)}
