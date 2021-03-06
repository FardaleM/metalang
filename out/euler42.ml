let is_triangular n =
  (*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   *)
  let a = ((int_of_float (sqrt (float_of_int ( n * 2))))) in
  a * (a + 1) = n * 2

let score () =
  let len = Scanf.scanf " %d " (fun len -> len) in
  let sum = ref( 0 ) in
  for _i = 1 to len do
    let c = Scanf.scanf "%c" (fun c -> c) in
    sum := (!sum) + (int_of_char (c)) - (int_of_char ('A')) + 1
    (*		print c print " " print sum print " " *)
  done;
  if is_triangular (!sum) then
    1
  else
    0

let () =
 for i = 1 to 55 do
   if is_triangular i then
     Printf.printf "%d " i
  done;
  Printf.printf "\n";
  let sum = ref( 0 ) in
  let n = Scanf.scanf "%d" (fun n -> n) in
  for i = 1 to n do
    sum := (!sum) + score ()
  done;
  Printf.printf "%d\n" (!sum) 
 