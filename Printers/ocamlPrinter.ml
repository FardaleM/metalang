(*
 * Copyright (c) 2012, Prologin
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

(** Ocaml Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer

(** returns true if a list of instructions contains a return *)
let contains_return li =
  List.exists (Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
  | Instr.Return _ -> true
  | Instr.AllocArray _ -> acc
  | _ -> acc) false) li

(** returns true if a list of instructions contains a return that
    ocaml cannot execute (it's compiled into an exception) *)
let rec contains_sad_return instrs =
  let rec f tra acc i = match Instr.unfix i with
    | Instr.AllocArray _ -> acc
    | Instr.Loop(_, _, _, li) -> acc || ( contains_return li)
    | Instr.While (_, li) -> acc || (contains_return li)
    | Instr.If (_, li1, li2) ->
      acc ||
        (contains_sad_return li1) || (contains_sad_return li2) ||
        (( contains_return li1) && not( contains_return li2)) ||
        (( contains_return li2) && not( contains_return li1))
    | _ -> tra acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) false instrs

let collect_sad_returns ty instrs =
  let add acc l type_ =
    if contains_sad_return l then TypeSet.add type_ acc
    else acc
  in
  let rec f tra acc i = match Instr.unfix i with
    | Instr.AllocArray (_binding, type_, _len, Some (_b, l), _) ->
      add (tra acc i) l type_
    | _ -> tra acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f))
  (add TypeSet.empty instrs ty)
  instrs


(* TODO
   virer plus de refs
   virer plus de nopending : inliner un peu
*)

(** the main class : the ocaml printer *)
class camlPrinter = object(self)
  inherit printer as super

  (** bindings by reference *)
  val mutable refbindings = BindingSet.empty
  (** sad return in the current function *)
  val mutable sad_returns = false
  val mutable printed_exn = TypeMap.empty
  (** true if we are processing an expression *)
  val mutable in_expr = false
  val mutable exn_count = 0

  method lang () = "ml"

  method untuple f li e =
    Format.fprintf f "@[<h>let (%a) = %a in@]"
      (print_list self#binding
         (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)
      ) (List.map snd li)
      self#expr e


  method record f li =
    Format.fprintf f "{@\n  @[<v>%a@]@\n}"
      (self#def_fields "") li

  (** show a type *)
  method ptype f (t : Ast.Type.t ) =
    match Type.Fixed.unfix t with
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "string"
    | Type.Array a -> Format.fprintf f "%a array" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "bool"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> Format.fprintf f "%s" n
    | Type.Struct li ->
      Format.fprintf f "record{%a}"
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%s : %a;" name self#ptype type_
           )
           (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
        ) li
    | Type.Enum li ->
      Format.fprintf f "%a"
        (print_list
           (fun t name ->
             Format.fprintf t "%s" name
           )
           (fun t fa a fb b -> Format.fprintf t "%a@\n| %a" fa a fb b)
        ) li
    | Type.Lexems -> assert false
    | Type.Auto -> assert false

  (** read spaces from stdin *)
  method stdin_sep f =
    Format.fprintf f
      "@[<h>Scanf.scanf \"%%[\\n \\010]\" (fun _ -> ())@]"

  (** show a binary operator *)
  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "mod"
      | Expr.Or -> "or"
      | Expr.And -> "&&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "="
      | Expr.Diff -> "<>"
      )

  (** show unary operators *)
  method unop f op a =
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "not "
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a%a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a

  (** show the main *)
  method main f main =
    sad_returns <- contains_sad_return main;
    self#calc_refs main;
    self#calc_used_variables main;
    Format.fprintf f "@[<v 2>@[<h>let () =@\nbegin@\n@[<v 2>  %a@]@\nend@\n"
      self#instructions main

  (** show all the programm *)
  method prog f prog =
    Format.fprintf f "%a%a"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  (** print recursive prefix *)
  method rec_ f b =
    if b then Format.fprintf f "rec@ "

  (** show the prototype of a recursive function *)
  method print_rec_proto f triplet = self#print_proto_aux f true triplet

  (** show the prototype of a function*)
  method print_proto f triplet = self#print_proto_aux f false triplet

  (** util method to print a function prototype*)
  method print_proto_aux f rec_ ((funname:string), (t:Ast.Type.t), li) =
    match li with
    | [] -> Format.fprintf f "let@ %a%a@ () ="
      self#rec_ rec_
      self#funname funname
    | _ ->
      Format.fprintf f "let@ %a%a@ %a ="
        self#rec_ rec_
        self#funname funname
        (print_list
           (fun t (a, b) -> self#binding t a)
           (fun t f1 e1 f2 e2 -> Format.fprintf t
             "%a@ %a" f1 e1 f2 e2)) li

  (** show an if then else *)
  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]"
        self#expr e
        self#bloc ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse %a"
        self#expr e
        self#bloc ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method nocomment li = List.filter (fun i -> match Instr.unfix i with
  | Instr.Comment _ -> false
  | _ -> true
  ) li

  method ends_with_stop instr1 instrs2 =
    let instrs2 = self#nocomment instrs2 in
    if instrs2 = [] then false else
    if self#is_stdin instr1
    then false
    else match Instr.unfix instr1 with
    | Instr.AllocRecord _  (* letin -> pas de ; *)
    | Instr.AllocArray _
    | Instr.Declare _ 
    | Instr.Untuple _
    | Instr.DeclRead _
    | Instr.Comment _  (* le ; a déjà été mis *)
    | Instr.Return _ (* return -> pas de ; *)
      -> false
    | _ -> true

  (** show an instruction *)
  method instructions0 f instrs =
    if List.for_all self#is_stdin instrs then
      self#multiread f instrs
    else if (match instrs with [_] -> false | _ -> true) (* TODO factoriser ça *)
      && List.for_all self#is_print instrs then
      let li = List.map (fun i -> match Instr.unfix i with
        | Instr.Print (t, i) -> format_type t, (t, i)
        | _ -> assert false
      ) instrs in
      let li =
        if self#combine_formats () then
          List.map ( fun (format, (ty, e)) -> match Expr.unfix e with
          | Expr.Lief (Expr.String s) ->
            let s = self#noformat s in
            (String.sub s 1 ((String.length s) - 2)  , (ty, e))
          | _ -> (format, (ty, e))
          ) li else li in
      let formats, exprs = List.unzip li in
      let rec g acc = function
        | [] -> acc
        | hd::tl -> g (acc ^ hd) tl
      in
      let format = g "" formats in
      let exprs =
        if self#combine_formats () then
          List.filter (fun (ty, e) -> match Expr.unfix e with
          | Expr.Lief (Expr.String _) -> false
          | _ -> true
          ) exprs
        else exprs
      in
      self#multi_print f format exprs
    else
      let rec g f = function
        | [] -> ()
        | [hd] -> self#instr f hd
        | hd::tl ->
          if self#ends_with_stop hd tl then
            Format.fprintf f "%a;@\n%a" self#instr hd g tl
          else
            Format.fprintf f "%a@\n%a" self#instr hd g tl
      in Format.fprintf f "%a" g instrs

  (** show an instruction *)
  method instructions f instrs =
    let rec g kind acc1 acc2 = function
      | hd::tl ->
        let kind2 = (self#is_print hd, self#is_stdin hd) in
        if kind2 = kind
        then g kind acc1 (hd::acc2) tl
        else g kind2 ((List.rev acc2)::acc1) [hd] tl
      | [] -> List.rev ( (List.rev acc2) :: acc1 )
    in
    let lili = g (false, false) [] [] instrs in
    let lili = List.filter ( (<>) [] ) lili in
    Format.fprintf f "%a%s"
      (print_list
         self#instructions0
         (fun t print1 item1 print2 item2 ->
           if not (self#need_unit item1) then (* oui je sais c'est sale *)
             Format.fprintf t "%a;@\n%a" print1 item1 print2 item2
           else
             Format.fprintf t "%a@\n%a" print1 item1 print2 item2
         )
      ) lili
      (if self#need_unit instrs then " ()" else "")



  (** returns true if the function need to returns unit *)
  method need_unit instrs =
    let instrs = self#nocomment instrs in
    if instrs = [] then true
    else if (List.for_all self#is_stdin instrs) && List.exists (fun i -> match Instr.unfix i with
    | Instr.DeclRead _ -> true
    | _ -> false
    ) instrs
    then true
    else match List.map Instr.unfix instrs |> List.rev with
    | (Instr.AllocArray _ | Instr.Declare _ | Instr.DeclRead _ | Instr.Untuple _) :: _ -> true
    | _ -> false

  (** show a bloc of instructions *)
  method bloc f b =
    if List.forall
      (function
      | Instr.Fixed.F (_, (Instr.Comment _
                              | (Instr.If (_, _, _) )) (* sans begin end, on a un conflit sur le else *)) -> true
      | _ -> false
      )
      b
    then
      Format.fprintf f "begin@\n@[<v 2>  %a@]@\nend" self#instructions b
    else
      match b with
      | [i] ->
        Format.fprintf f "@[<h>%a%s@]" self#instr i
          (if self#need_unit b then " ()" else "")
      | _ ->
        Format.fprintf f "begin@\n@[<v 2>  %a@]@\nend" self#instructions b

  (** show a binding *)
  method binding f i =
    if BindingSet.mem i used_variables then
      Format.fprintf f "%s" i
    else
      Format.fprintf f "_%s" i

  method hasSelfAffect op = false

  (** show an affectation *)
  method affect f m expr =
    Format.fprintf f "@[<h>%a@ %s@ %a@]"
      self#mutable_ m
      (match m |> Mutable.Fixed.unfix with
      | Mutable.Var _ -> ":="
      | Mutable.Array _ -> "<-"
      | Mutable.Dot _ -> "<-"
      )
      self#expr expr

  (** show a declaration *)
  method declaration f var t e =
    if BindingSet.mem var refbindings then
      Format.fprintf f "@[<h>let %a@ =@ ref(@ %a )@ in@]"
        self#binding var
        self#expr e
    else
      Format.fprintf f "@[<h>let %a@ =@ %a@ in@]"
        self#binding var
        self#expr e

  (** read a value from stdin into a mutable *)
  method read f t m =
    Format.fprintf f "@[Scanf.scanf \"%a\" (fun value -> %a %s value)@]"
      self#format_type t
      self#mutable_ m
      (match m |> Mutable.Fixed.unfix with
      | Mutable.Var _ -> ":="
      | Mutable.Array _ -> "<-"
      | Mutable.Dot _ -> "<-"
      )

  (** declare a variable and read his value from stdin *)
  method read_decl f t v =
    Format.fprintf f "@[let %a = Scanf.scanf \"%a\" (fun x -> x) in@]"
      self#binding v
      self#format_type t

  (** find references variables from a list of instructions *)
  method calc_refs instrs =
    refbindings <-
      List.fold_left
      (Instr.Writer.Deep.fold
         (fun acc i ->
           match Instr.unfix i with
           | Instr.Read (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
           | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _) -> BindingSet.add varname acc
           | _ -> acc
         ))
      BindingSet.empty
      instrs

  (** print an expression *)
  method expr f e =
    begin
      in_expr <- true;
      super#expr f e;
      in_expr <- false;
    end

  (** print mutable values *)
  method mutable_ f m =
    match m |> Mutable.Fixed.unfix with
    | Mutable.Var binding ->
      if in_expr && BindingSet.mem binding refbindings
      then
        Format.fprintf f "(!%a)" self#binding binding
      else
        self#binding f binding
    | _ -> self#mutable_rec f m

  method mutable_rec f m =
    match m |> Mutable.unfix with
    | Mutable.Var binding ->
      if BindingSet.mem binding refbindings
      then
        Format.fprintf f "(!%a)" self#binding binding
      else
        self#binding f binding
    | Mutable.Dot (mutable_, field) ->
      Format.fprintf f "@[<h>%a.%a@]"
        self#mutable_rec mutable_
        self#field field
    | Mutable.Array (mut, indexes) ->
      Format.fprintf f "@[<h>%a.(%a)@]"
        self#mutable_rec mut
        (print_list
           self#expr
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a).(%a"
               f1 e1
               f2 e2
           )) indexes

  (** returns true if the function is recursive *)
  method is_rec funname instrs =
    let is_rec i =
      Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
      | Instr.Call (name, _) -> acc || name = funname
      | _ -> acc
      ) false i ||
        Instr.fold_expr (fun acc e ->
          Expr.Writer.Deep.fold (fun acc e -> match Expr.unfix e with
          | Expr.Call (name, _) -> acc || name = funname
          | _ -> acc
          ) acc e
        ) false i
    in List.fold_left (fun acc i -> acc || is_rec i) false instrs

  method print_exnName f (t : unit Type.Fixed.t) =
    try
      Format.fprintf f "%s" (TypeMap.find t printed_exn)
    with Not_found ->
      Format.fprintf f "NOT_FOUND_%a" self#ptype t

  method print_exns f exns =
    TypeMap.iter (fun ty str ->
      Format.fprintf f "exception %s of %a@\n"
        str
        self#ptype ty
    ) exns

  method used_affect () = true

  method print_fun f funname (t : unit Type.Fixed.t) li instrs =
    self#calc_refs instrs;
    self#calc_used_variables instrs;
    let is_rec = self#is_rec funname instrs in
    let proto = if is_rec then self#print_rec_proto else self#print_proto in
    let sad_types = collect_sad_returns t instrs in
    let () = sad_returns <- contains_sad_return instrs in
    match t with
    | Type.Fixed.F (_, Type.Void) ->
      if sad_returns then failwith("return in a void function : "^funname)
      else
        Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
    | _ ->
      if not(sad_returns) then
        Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
      else
        let () =
          Warner.warn funname (fun t () -> Format.fprintf t "The returns will make a dirty ocaml code")
        in (* TODO faire un diff pour ne déclarer que les nouvelles *)
        let () = printed_exn <-
          TypeSet.fold (fun t (acc: string TypeMap.t) ->
            exn_count <- exn_count + 1;
            TypeMap.add t ("Found_"^(string_of_int exn_count)) acc
          ) sad_types
          TypeMap.empty
        in
        Format.fprintf f "%a@\n@[<h>%a@]@\n@[<v 2>  %atry@\n%a@\nwith %a (out) -> out@]@\n"
          self#print_exns printed_exn
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
          self#print_exnName t

  method ref_alias f li = match li with
  | [] -> ()
  | (name, _) :: tl ->
    let b = BindingSet.mem name refbindings in
    if b then
      Format.fprintf f "let %a = ref %a in@\n%a"
        self#binding name
        self#binding name
        self#ref_alias tl
    else
      self#ref_alias f tl

  method combine_formats () = true

  method print f t expr =
    match Expr.unfix expr with
    | Expr.Lief (Expr.String s) -> Format.fprintf f "@[Printf.printf %s@]" ( self#noformat s)
    | _ ->
      Format.fprintf f "@[Printf.printf \"%a\" %a@]"
        self#format_type t
        (if self#nop (Expr.unfix expr) then
            self#expr
         else self#printp) expr

  method comment f str =
    Format.fprintf f "(*%s*)" str

  method return f e =
    if sad_returns then
      Format.fprintf f "@[<h>raise (%a(%a))@]"
        self#print_exnName (Typer.get_type (self#getTyperEnv ())  e)
        self#expr e
    else
      Format.fprintf f "@[<h>%a@]" self#expr e

  method allocarray_lambda f binding type_ len binding2 lambda _ =
    let next_sad_return =sad_returns in
    sad_returns <- contains_sad_return lambda;
    let b = BindingSet.mem binding refbindings in
    Format.fprintf f "@[<h>let %a@ =@ %aArray.init@ %a@ (fun@ %a@ ->%a@\n@[<v 2>  %a%a@])%a@ in@]"
      self#binding binding
      (fun t () ->
        if b then
          Format.fprintf t "ref(@ "
      ) ()
      (fun f e ->
        if self#nop (Expr.unfix e) then self#expr f e
        else Format.fprintf f "(%a)" self#expr e
      ) len
      self#binding binding2
      (fun f () ->
        if sad_returns then Format.fprintf f "@ try@\n"
      ) ()
      self#instructions lambda
      (fun f () ->
        if sad_returns then Format.fprintf f "@\nwith %a@ out -> out@\n"
          self#print_exnName type_
      ) ()
      (fun t () ->
        if b then
          Format.fprintf t ")"
      ) ();
    sad_returns <- next_sad_return;
    ()

  method allocarray f binding type_ len _ =
    let b = BindingSet.mem binding refbindings in
    Format.fprintf f "@[<h>let@ %a@ %a=@ Array.make@ %a@ (Obj.magic@ 0)%a@ in@]"
      self#binding binding
      (fun t () ->
        if b then
          Format.fprintf t "ref(@ "
      ) ()
      self#expr len
      (fun t () ->
        if b then
          Format.fprintf t ")"
      ) ()

  method affectarray f binding indexes e2 =
    Format.fprintf f "@[<h>%a.(%a)@ <-@ %a@]"
      self#binding binding
      (print_list
         self#expr
         (fun f f1 e1 f2 e2 ->
           Format.fprintf f "%a).(%a" f1 e1 f2 e2
         )) indexes
      self#expr e2


  method nop = function
  | Expr.Lief _ -> true
  | Expr.Access _ -> true
  | Expr.Call (_, _) -> false
  | Expr.Record _ -> true
  | _ -> false

  (* Todo virer les parentheses quand on peut*)
  method apply f var li =
    match BindingMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_call f var t params code li
    | None ->
      match li with
      | [] ->
        Format.fprintf f "@[<h>(%a ())@]"
          self#funname var
      | _ ->
        Format.fprintf
          f
          "@[<h>%a %a@]"
          self#funname var
          (print_list
             (fun t e ->
               if self#nop (Expr.unfix e) then self#expr f e
               else Format.fprintf f "(%a)" self#expr e
             )
             (fun t f1 e1 f2 e2 ->
               Format.fprintf t "%a@ %a" f1 e1 f2 e2
             )
          ) li

  method call f var li =
    self#apply f var li

  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a@]@\ndo@[<v 2>@\n%a@]@\ndone"
      self#expr expr
      self#instructions li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ =@ %a@ to@ %a@ do@\n@]@[<v 2>  %a@]@\ndone"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>%a=%a;@]"
          self#field fieldname
          self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
        Format.fprintf t
          "%a@\n%a" f1 e1 f2 e2)
      f
      li

  method allocrecord f name t el =
    let b = BindingSet.mem name refbindings in
    Format.fprintf f "let %a = %a{@\n@[<v 2>  %a@]@\n}%a in"
      self#binding name
      (fun t () ->
        if b then
          Format.fprintf t "ref(@ "
      ) ()
      (self#def_fields name) el
      (fun t () ->
        if b then
          Format.fprintf t ")"
      ) ()

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "type %s = {@\n@[<v 2>  %a@]@\n};;@\n"
          name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "@[<h>mutable %s : %a;@]"
                 name
                 self#ptype type_
             )
             (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
          ) li
    | Type.Enum li ->
      Format.fprintf f "type %s = @\n@[<v2>    %a@]@\n"
        name
        (print_list
           (fun t name ->
             Format.fprintf t "%s" name
           )
           (fun t fa a fb b -> Format.fprintf t "%a@\n| %a" fa a fb b)
        ) li
    | _ ->
      Format.fprintf f "type %a = %a;;"
        super#binding name
        super#ptype t

  method multiread f instrs =
    let format, variables =
      List.fold_left (fun (format, variables) i -> match Instr.unfix i with
      | Instr.StdinSep -> (format ^ " ", variables)
      | Instr.DeclRead (t, v, _opt) ->
        let addons = format_type t in
        (format ^ addons, (true, Mutable.var v)::variables)
      | Instr.Read (t, mutable_) ->
        let addons = format_type t in
        (format ^ addons, (false, mutable_)::variables)
      | _ -> assert false
      ) ("", []) instrs
    in
    let variables = List.mapi (fun i (b, m) -> (i, b, m) ) (List.rev variables) in
    let declares, affect = List.partition (fun (_, b, _) -> b) variables in
    let print_return : Format.formatter -> unit -> unit = match declares with
      | [] -> (fun _ () ->
        match affect with
        | [] -> Format.fprintf f "()"
        | _ -> ())
      | li -> (fun f () ->
        Format.fprintf f "%a%a"
          (fun f () -> if [] <> affect then Format.fprintf f ";@\n") ()
          (print_list
             (fun f (i, b, v) ->
               let v = match Mutable.unfix v with
                 | Mutable.Var v -> v
                 | _ -> assert false
               in
               if BindingSet.mem v refbindings then Format.fprintf f "ref v_%d" i
               else Format.fprintf f "v_%d" i)
             (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b))
      declares )
    in
    let print_in : Format.formatter -> unit -> unit  = match declares with
      | [] -> fun _ () -> ()
      | li -> fun f () -> Format.fprintf f " in"
    in
    let print_variables : Format.formatter -> unit -> unit =
      match variables with
      | [] -> fun f () -> Format.fprintf f "()"
      | _ ->
        fun f () ->
          print_list (fun f (i, b, m) -> Format.fprintf f "v_%d" i)
            (fun t fa a fb b -> Format.fprintf t "%a %a" fa a fb b)
            f
            variables
    in
    let print_let : Format.formatter -> unit -> unit  = match declares with
      | [] -> (fun _ () -> ())
      | li -> (fun f () ->
        Format.fprintf f "let %a = "
          (print_list
             (fun f (_, _, v) -> self#mutable_ f v)
             (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b))
      declares )
    in Format.fprintf f "%aScanf.scanf \"%s\" (fun %a -> @[<v>%a%a@])%a"
      print_let ()
      format

      print_variables ()

      (print_list (fun f (i, b, m) -> Format.fprintf f "%a %s v_%d"
        self#mutable_ m
        (match Mutable.Fixed.unfix m with
        | Mutable.Var _ -> ":="
        | Mutable.Array _ -> "<-"
        | Mutable.Dot _ -> "<-"
        ) i)
         (fun t fa a fb b -> Format.fprintf t "%a;@\n%a" fa a fb b))
      affect
      print_return ()
      print_in ()

  method printf f () = Format.fprintf f "Printf.printf"
  method multi_print f format exprs =
    if exprs = [] then
      Format.fprintf f "@[<h>%a \"%s\"@]" self#printf () format
    else
      Format.fprintf f "@[<h>%a \"%s\" %a@]" self#printf ()  format
        (print_list
           (fun f (t, expr) ->
             (if self#nop (Expr.unfix expr) then
                 self#expr
              else self#printp) f expr)
           (fun t f1 e1 f2 e2 -> Format.fprintf t "%a@ %a" f1 e1 f2 e2)) exprs

end
