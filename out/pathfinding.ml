let min2 a b =
  min a b

let min3 a b c =
  min2 (min2 a b) c

let min4 a b c d =
  let f = min2 a b in
  let e = min2 (min2 f c) d in
  e

let rec pathfind_aux cache tab x y posX posY =
  if posX = x - 1 && posY = y - 1 then
    0
  else if posX < 0 or posY < 0 or posX >= x or posY >= y then
    x * y * 10
  else if tab.(posY).(posX) = '#' then
    x * y * 10
  else if cache.(posY).(posX) <> -1 then
    cache.(posY).(posX)
  else
    begin
      cache.(posY).(posX) <- x * y * 10;
      let val1 = pathfind_aux cache tab x y (posX + 1) posY in
      let val2 = pathfind_aux cache tab x y (posX - 1) posY in
      let val3 = pathfind_aux cache tab x y posX (posY - 1) in
      let val4 = pathfind_aux cache tab x y posX (posY + 1) in
      let h = min2 val1 val2 in
      let k = min2 (min2 h val3) val4 in
      let g = k in
      let out_ = 1 + g in
      cache.(posY).(posX) <- out_;
      out_
    end

let pathfind tab x y =
  let cache = Array.init y (fun _i ->
    let tmp = Array.init x (fun _j ->
      -1) in
    tmp) in
  pathfind_aux cache tab x y 0 0

let () =
begin
  let x = ref( 0 ) in
  let y = ref( 0 ) in
  Scanf.scanf "%d %d " (fun v_0 v_1 -> x := v_0;
                                       y := v_1);
  let tab = Array.init (!y) (fun _i ->
    let tab2 = Array.init (!x) (fun _j ->
      let tmp = ref( '\000' ) in
      Scanf.scanf "%c" (fun v_0 -> tmp := v_0);
      (!tmp)) in
    Scanf.scanf " " (fun () -> ());
    tab2) in
  let result = pathfind tab (!x) (!y) in
  Printf.printf "%d" result
end
 