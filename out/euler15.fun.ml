let main =
  let n = 10 in
  (*  normalement on doit mettre 20 mais là on se tape un overflow  *)
  let n = (n + 1) in
  let tab = (Array.init n (fun  i -> (Array.init n (fun  j -> 0)))) in
  let rec a l =
    (if (l <= (n - 1))
     then (
            tab.((n - 1)).(l) <- 1;
            tab.(l).((n - 1)) <- 1;
            (a (l + 1))
            )
     
     else let rec b o =
            (if (o <= n)
             then let r = (n - o) in
             let rec e p =
               (if (p <= n)
                then let q = (n - p) in
                (
                  tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1)));
                  (e (p + 1))
                  )
                
                else (b (o + 1))) in
               (e 2)
             else let rec c m =
                    (if (m <= (n - 1))
                     then let rec d k =
                            (if (k <= (n - 1))
                             then (
                                    (Printf.printf "%d " tab.(m).(k));
                                    (d (k + 1))
                                    )
                             
                             else (
                                    (Printf.printf "\n");
                                    (c (m + 1))
                                    )
                             ) in
                            (d 0)
                     else (Printf.printf "%d\n" tab.(0).(0))) in
                    (c 0)) in
            (b 2)) in
    (a 0)

