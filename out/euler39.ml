
let () =
 let t = Array.init 1001 (fun _i ->
   0) in
  for a = 1 to 1000 do
    for b = 1 to 1000 do
      let c2 = a * a + b * b in
      let c = ((int_of_float (sqrt (float_of_int ( c2))))) in
      if c * c = c2 then
        let p = a + b + c in
        if p < 1001 then
          t.(p) <- t.(p) + 1
    done
  done;
  let j = ref( 0 ) in
  for k = 1 to 1000 do
    if t.(k) > t.((!j)) then
      j := k
  done;
  Printf.printf "%d" (!j) 
 