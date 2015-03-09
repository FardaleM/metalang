let primesfactors n =
  let n = ref n in
  let tab = Array.make ((!n) + 1) 0 in
  let d = ref( 2 ) in
  while (!n) <> 1 && (!d) * (!d) <= (!n)
  do
      if ((!n) mod (!d)) = 0 then
        begin
          tab.((!d)) <- tab.((!d)) + 1;
          n := (!n) / (!d)
        end
      else
        d := (!d) + 1
  done;
  tab.((!n)) <- tab.((!n)) + 1;
  tab

let () =
begin
  let lim = 20 in
  let o = Array.make (lim + 1) 0 in
  for i = 1 to lim do
    let t = primesfactors i in
    for j = 1 to i do
      o.(j) <- (max (o.(j)) (t.(j)))
    done
  done;
  let product = ref( 1 ) in
  for k = 1 to lim do
    for _l = 1 to o.(k) do
      product := (!product) * k
    done
  done;
  Printf.printf "%d\n" (!product)
end
 