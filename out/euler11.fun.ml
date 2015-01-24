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

let rec find n m x y dx dy =
  let w () = () in
  (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
   then (- 1)
   else let ba () = (w ()) in
   (if (n = 0)
    then 1
    else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy))))
let main =
  let directions = (Array.init_withenv 8 (fun  i () -> let bc bb = ((), bb) in
  (if (i = 0)
   then let bb = (0, 1) in
   ((), bb)
   else let bd () = (bc ()) in
   (if (i = 1)
    then let bb = (1, 0) in
    ((), bb)
    else let be () = (bd ()) in
    (if (i = 2)
     then let bb = (0, (- 1)) in
     ((), bb)
     else let bf () = (be ()) in
     (if (i = 3)
      then let bb = ((- 1), 0) in
      ((), bb)
      else let bg () = (bf ()) in
      (if (i = 4)
       then let bb = (1, 1) in
       ((), bb)
       else let bh () = (bg ()) in
       (if (i = 5)
        then let bb = (1, (- 1)) in
        ((), bb)
        else let bi () = (bh ()) in
        (if (i = 6)
         then let bb = ((- 1), 1) in
         ((), bb)
         else let bb = ((- 1), (- 1)) in
         ((), bb))))))))) ()) in
  let max0 = 0 in
  let h = 20 in
  let m = (Array.init_withenv 20 (fun  o () -> let s = (Array.init_withenv h (fun  q () -> Scanf.scanf "%d"
  (fun  r -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let bk = r in
               ((), bk)
               )
  )) ()) in
  let bj = s in
  ((), bj)) ()) in
  let bs = 0 in
  let bt = 7 in
  let rec bl j max0 =
    (if (j <= bt)
     then ((fun  (dx, dy) -> let bq = 0 in
     let br = 19 in
     let rec bm x max0 =
       (if (x <= br)
        then let bo = 0 in
        let bp = 19 in
        let rec bn y max0 =
          (if (y <= bp)
           then let v = (find 4 m x y dx dy) in
           let u = ((max (max0) (v))) in
           let max0 = u in
           (bn (y + 1) max0)
           else (bm (x + 1) max0)) in
          (bn bo max0)
        else (bl (j + 1) max0)) in
       (bm bq max0)) directions.(j))
     else (
            (Printf.printf "%d\n" max0)
            )
     ) in
    (bl bs max0)

