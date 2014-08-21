module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let read_int_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let b = (Array.init_withenv x (fun  c () -> Scanf.scanf "%d"
  (fun  d -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let q = d in
               ((), q)
               )
  )) ()) in
  let a = b in
  let p = a in
  ((), p)) ()) in
  tab
let programme_candidat tableau x y =
  let out_ = 0 in
  let m = 0 in
  let o = (y - 1) in
  let rec g i out_ =
    (if (i <= o)
     then let k = 0 in
     let l = (x - 1) in
     let rec h j out_ =
       (if (j <= l)
        then let out_ = (out_ + (tableau.(i).(j) * ((i * 2) + j))) in
        (h (j + 1) out_)
        else (g (i + 1) out_)) in
       (h k out_)
     else out_) in
    (g m out_)
let main =
  let e = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_x = e in
  let f = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = f in
  let tableau = (read_int_matrix taille_x taille_y) in
  (
    (Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y))
    )
  

