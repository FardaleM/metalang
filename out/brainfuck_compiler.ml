
(*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*)
let () =
begin
  let _input = ' ' in
  let current_pos = ref( 500 ) in
  let a = 1000 in
  let mem = Array.init (a) (fun _i ->
    0) in
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  current_pos := (!current_pos) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  mem.((!current_pos)) <- mem.((!current_pos)) + 1;
  while mem.((!current_pos)) <> 0
  do
      mem.((!current_pos)) <- mem.((!current_pos)) - 1;
      current_pos := (!current_pos) - 1;
      mem.((!current_pos)) <- mem.((!current_pos)) + 1;
      let b = char_of_int (mem.((!current_pos))) in
      Printf.printf "%c" b;
      current_pos := (!current_pos) + 1
  done
end
 