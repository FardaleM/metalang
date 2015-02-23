module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let devine0 nombre tab len =
  let min0 = tab.(0) in
  let max0 = tab.(1) in
  let c = (len - 1) in
  let rec b i max0 min0 =
    (if (i <= c)
     then (if ((tab.(i) > max0) || (tab.(i) < min0))
           then false
           else let min0 = (if (tab.(i) < nombre)
                            then let min0 = tab.(i) in
                            min0
                            else min0) in
           let max0 = (if (tab.(i) > nombre)
                       then let max0 = tab.(i) in
                       max0
                       else max0) in
           (if ((tab.(i) = nombre) && (len <> (i + 1)))
            then false
            else (b (i + 1) max0 min0)))
     else true) in
    (b 2 max0 min0)
let main =
  Scanf.scanf "%d"
  (fun  nombre -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    Scanf.scanf "%d"
                    (fun  len -> (
                                   (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                   ((fun  (e, tab) -> (
                                                        e;
                                                        let a = (devine0 nombre tab len) in
                                                        (if a
                                                         then (Printf.printf "True")
                                                         else (Printf.printf "False"))
                                                        )
                                   ) (Array.init_withenv len (fun  i () -> Scanf.scanf "%d"
                                   (fun  tmp -> (
                                                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                  let d = tmp in
                                                  ((), d)
                                                  )
                                   )) ()))
                                   )
                    )
                    )
  )

