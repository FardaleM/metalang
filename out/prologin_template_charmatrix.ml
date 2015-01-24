let programme_candidat tableau taille_x taille_y =
  let out0 = ref( 0 ) in
  for i = 0 to taille_y - 1 do
    for j = 0 to taille_x - 1 do
      out0 := (!out0) + int_of_char (tableau.(i).(j)) * (i + j * 2);
      Printf.printf "%c" tableau.(i).(j)
    done;
    Printf.printf "--\n"
  done;
  (!out0)

let () =
begin
  let taille_x = Scanf.scanf "%d " (fun x -> x) in
  let taille_y = Scanf.scanf "%d " (fun x -> x) in
  let h = Array.init taille_y (fun _k ->
    let p = Array.init taille_x (fun _m ->
      let o = Scanf.scanf "%c" (fun v_0 -> v_0) in
      o) in
    Scanf.scanf " " (fun () -> ());
    p) in
  let tableau = h in
  Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y)
end
 