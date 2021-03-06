let rec result sum t maxIndex cache =
  if cache.(sum).(maxIndex) <> 0 then
    cache.(sum).(maxIndex)
  else
    if sum = 0 || maxIndex = 0 then
      1
    else
      begin
         let out0 = ref( 0 ) in
         let div = sum / t.(maxIndex) in
         for i = 0 to div do
           out0 := (!out0) + result (sum - i * t.(maxIndex)) t (maxIndex - 1) cache
         done;
         cache.(sum).(maxIndex) <- (!out0);
         (!out0)
      end

let () =
 let t = Array.init 8 (fun _i ->
   0) in
  t.(0) <- 1;
  t.(1) <- 2;
  t.(2) <- 5;
  t.(3) <- 10;
  t.(4) <- 20;
  t.(5) <- 50;
  t.(6) <- 100;
  t.(7) <- 200;
  let cache = Array.init 201 (fun _j ->
    let o = Array.init 8 (fun _k ->
      0) in
    o) in
  Printf.printf "%d" (result 200 t 7 cache) 
 