let is_leap =
  (fun year ->
      (((year mod 400) = 0) || (((year mod 100) <> 0) && ((year mod 4) = 0))));;
let ndayinmonth =
  (fun month year ->
      let a = (fun () -> 0) in
      (if (month = 0)
       then 31
       else let b = (fun () -> (a ())) in
       (if (month = 1)
        then let c = (fun () -> (b ())) in
        (if (is_leap year)
         then 29
         else 28)
        else let d = (fun () -> (b ())) in
        (if (month = 2)
         then 31
         else let e = (fun () -> (d ())) in
         (if (month = 3)
          then 30
          else let f = (fun () -> (e ())) in
          (if (month = 4)
           then 31
           else let g = (fun () -> (f ())) in
           (if (month = 5)
            then 30
            else let h = (fun () -> (g ())) in
            (if (month = 6)
             then 31
             else let i = (fun () -> (h ())) in
             (if (month = 7)
              then 31
              else let j = (fun () -> (i ())) in
              (if (month = 8)
               then 30
               else let k = (fun () -> (j ())) in
               (if (month = 9)
                then 31
                else let l = (fun () -> (k ())) in
                (if (month = 10)
                 then 30
                 else (if (month = 11)
                       then 31
                       else (l ()))))))))))))));;
let main =
  let month = 0 in
  let year = 1901 in
  let dayofweek = 1 in
  (*  01-01-1901 : mardi  *)
  let count = 0 in
  let rec n count dayofweek month year =
    (if (year <> 2001)
     then let ndays = (ndayinmonth month year) in
     let dayofweek = ((dayofweek + ndays) mod 7) in
     let month = (month + 1) in
     ((fun (month, year) ->
          let count = (if ((dayofweek mod 7) = 6)
                       then let count = (count + 1) in
                       count
                       else count) in
          (n count dayofweek month year)) (if (month = 12)
                                           then let month = 0 in
                                           let year = (year + 1) in
                                           (month, year)
                                           else (month, year)))
     else (
            (Printf.printf "%d" count);
            (Printf.printf "%s" "\n")
            )
     ) in
    (n count dayofweek month year);;

