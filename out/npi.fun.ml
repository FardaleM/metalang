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

let is_number =
  (fun c ->
      (((int_of_char (c)) <= (int_of_char ('9'))) && ((int_of_char (c)) >= (int_of_char ('0')))));;
let npi_ =
  (fun str len ->
      let stack = (Array.init_withenv len (fun i ->
                                              (fun () -> let a = 0 in
                                              ((), a))) ()) in
      let ptrStack = 0 in
      let ptrStr = 0 in
      let rec d ptrStack ptrStr =
        (if (ptrStr < len)
         then ((fun (ptrStack, ptrStr) ->
                   (d ptrStack ptrStr)) (if (str.(ptrStr) = ' ')
                                         then let ptrStr = (ptrStr + 1) in
                                         (ptrStack, ptrStr)
                                         else ((fun (ptrStack, ptrStr) ->
                                                   (ptrStack, ptrStr)) (
                                         if (is_number str.(ptrStr))
                                         then let num = 0 in
                                         let rec f num ptrStr =
                                           (if (str.(ptrStr) <> ' ')
                                            then let num = (((num * 10) + (int_of_char (str.(ptrStr)))) - (int_of_char ('0'))) in
                                            let ptrStr = (ptrStr + 1) in
                                            (f num ptrStr)
                                            else (
                                                   stack.(ptrStack) <- num;
                                                   let ptrStack = (ptrStack + 1) in
                                                   (ptrStack, ptrStr)
                                                   )
                                            ) in
                                           (f num ptrStr)
                                         else ((fun (ptrStack, ptrStr) ->
                                                   (ptrStack, ptrStr)) (
                                         if (str.(ptrStr) = '+')
                                         then (
                                                stack.((ptrStack - 2)) <- (stack.((ptrStack - 2)) + stack.((ptrStack - 1)));
                                                let ptrStack = (ptrStack - 1) in
                                                let ptrStr = (ptrStr + 1) in
                                                (ptrStack, ptrStr)
                                                )
                                         
                                         else (ptrStack, ptrStr)))))))
         else stack.(0)) in
        (d ptrStack ptrStr));;
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun j ->
      let len = j in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i ->
      (fun () -> let tmp = '\000' in
      Scanf.scanf "%c"
      (fun h ->
          let tmp = h in
          let g = tmp in
          ((), g)))) ()) in
      let result = (npi_ tab len) in
      (Printf.printf "%d" result))));;

