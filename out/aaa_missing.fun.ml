let result len tab =
  let tab2 = Array.init len (fun i -> false) in
  let rec c i1 =
    if i1 <= len - 1
    then ( Printf.printf "%d " tab.(i1);
           tab2.(tab.(i1)) <- true;
           c (i1 + 1))
    else ( Printf.printf "%s" "\n";
           let rec d i2 =
             if i2 <= len - 1
             then if not tab2.(i2)
                  then i2
                  else d (i2 + 1)
             else - 1 in
             d 0) in
    c 0

let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  ( Printf.printf "%d\n" len;
    let tab = Array.init len (fun a -> Scanf.scanf "%d"
    (fun b -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                b))) in
    Printf.printf "%d\n" (result len tab))

