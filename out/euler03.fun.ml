let main =
  let maximum = 1 in
  let b0 = 2 in
  let a = 408464633 in
  let sqrtia = ((int_of_float (sqrt (float_of_int ( a))))) in
  let rec g a b0 sqrtia =
    (if (a <> 1)
     then let b = b0 in
     let found = false in
     let rec i a b b0 found sqrtia =
       (if (b <= sqrtia)
        then ((fun  (a, b, b0, found, sqrtia) -> let b = (b + 1) in
        (i a b b0 found sqrtia)) (if ((a mod b) = 0)
                                  then let a = (a / b) in
                                  let b0 = b in
                                  let b = a in
                                  let e = ((int_of_float (sqrt (float_of_int ( a))))) in
                                  let sqrtia = e in
                                  let found = true in
                                  (a, b, b0, found, sqrtia)
                                  else (a, b, b0, found, sqrtia)))
        else let a = (if (not found)
                      then (
                             (Printf.printf "%d\n" a);
                             let a = 1 in
                             a
                             )
                      
                      else a) in
        (g a b0 sqrtia)) in
       (i a b b0 found sqrtia)
     else ()) in
    (g a b0 sqrtia)

