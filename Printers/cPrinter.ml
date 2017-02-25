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
 *
 *)

(** C Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Stdlib
open Helper
let lang = "c"

let print_lief prio f l = 
  let open Format in
  let open Expr in match l with
  | Bool true -> fprintf f "1"
  | Bool false -> fprintf f "0"
  | Char c -> clike_char f c
  | x -> print_lief prio f x

let print_mut conf prio f m =
  Mutable.Fixed.Deep.fold (print_mut0 "%a%a" "[%a]" "%a->%s" conf) m f prio

let config macros = {
  prio_binop = prio_binop_equal;
  prio_unop;
  print_varname;
  print_lief;
  print_op;
  print_unop;
  print_mut;
  macros
}

let print_expr config e f p =
  let open Format in
  let open Expr in
  let print_expr0 config e f prio_parent = match e with
    | _ -> print_expr0 config e f prio_parent in
  Fixed.Deep.fold (print_expr0 config) e f p

let rec ptype tyenv f t =
  match Type.unfix t with
  | Type.Integer -> Format.fprintf f "int"
  | Type.String -> Format.fprintf f "char*"
  | Type.Array a -> Format.fprintf f "%a*" (ptype tyenv) a
  | Type.Void ->  Format.fprintf f "void"
  | Type.Bool -> Format.fprintf f "int"
  | Type.Char -> Format.fprintf f "char"
  | Type.Named n -> begin match Typer.expand tyenv t
                                  default_location |> Type.unfix with
    | Type.Struct _ ->
      Format.fprintf f "struct %s *" n
    | Type.Enum _ ->
      Format.fprintf f "%s" n
    | _ -> assert false
    end
  | Type.Enum _ | Type.Struct _ | Type.Auto | Type.Tuple _ | Type.Lexems -> assert false

let def_fields c name f li =
  let open Format in
  print_list
    (fun f (s, e) -> fprintf f "%a->%s = %a;" c.print_varname name s e nop)
    sep_nl
    f
    li
    
let print_instr0 ptype c i f pend =
  let open Ast.Instr in
  let open Format in
  match i with
  | Comment s -> fprintf f "/*%s*/" s
  | Declare (var, ty, e, _) -> fprintf f "%a %a = %a%a" ptype ty c.print_varname var e nop pend ()
  | AllocArray (name, ty, e, None, opt) -> fprintf f "%a *%a = calloc(%a, sizeof(%a))%a"
                                             ptype ty
                                             c.print_varname name
                                             e nop
                                             ptype ty
                                             pend ()
  | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
  | AllocArrayConst (name, ty, len, lief, opt) -> assert false
  | AllocRecord (name, ty, list, opt) -> fprintf f "%a %a = malloc(sizeof(%s))%a@\n%a"
                                           ptype ty
                                           c.print_varname name
                                           (match Type.unfix ty with | Type.Named n -> n | _ -> assert false) pend ()
                                           (def_fields c name) list
  | Print li->
    let format, exprs = extract_multi_print clike_noformat format_type li in
    begin match exprs with
      | [] -> fprintf f "printf(\"%s\")%a" format pend ()
      | _ -> fprintf f "printf(\"%s\", %a)%a" format
               (print_list (fun f (t, e) -> e f nop) sep_c) exprs pend ()
    end
  | Read li ->
    let format, affected, declared = split_multi_read li " " format_type in
    begin match affected with
      | [] -> fprintf f "scanf(\"%s\")%a" format pend ()
      | _ -> fprintf f "scanf(\"%s\", %a)%a"
               (*            (print_list
                              (fun f (ty, name) -> fprintf f "%a %a;" ptype ty c.print_varname name)
                              sep_nl) declared (* en fait, c'est déclaré dans une autre passe.*) *)
               format
               (print_list
                  (fun f mut -> fprintf f "&%a" (c.print_mut c nop) mut)
                  sep_c) affected
               pend ()
    end
  | Untuple _ | Unquote _ -> assert false
  | _ -> clike_print_instr c i f pend

let mkprint_instr print_instr0 ptype (c:Helper.config) i =
  let is_multi_instr = match i with
    | Ast.Instr.Declare _ -> true
    | _ -> false in
  {
    is_multi_instr = is_multi_instr;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=print_instr0 ptype c i;
    default = seppt;
    print_lief = c.print_lief;
  }

let print_instr print_instr0 ptype macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config macros in
  let i = (fold (mkprint_instr print_instr0 ptype c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default

class cPrinter = object(self)

  val mutable typerEnv : Typer.env = Typer.empty
  method getTyperEnv () = typerEnv
  method setTyperEnv t = typerEnv <- t
  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b
  val mutable macros = StringMap.empty
  

  method instructions f li =
    let rewrite i = match Instr.unfix i with
      | Instr.ClikeLoop (init, cond, incr, li) ->
        let init = List.map (fun i -> match Instr.unfix i with
            | Instr.Declare (var, ty, e, _) ->
              let mut = Mutable.var var in
              Instr.affect mut e
            | _ -> i) init
        in Instr.ClikeLoop (init, cond, incr, li) |> Instr.fix
      | _ -> i
    in
    let li = List.map (Instr.Fixed.Deep.map rewrite) li in
    let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "c" li
        with Not_found -> List.assoc "" li) macros
    in print_list (fun f t -> print_instr print_instr0 (ptype typerEnv) macros t f) sep_nl f li

  method ptype f t = ptype typerEnv f t

  method main f main =
    let li_fori, li_forc = clike_collect_for main false in
    Format.fprintf f "@[<v 4>int main(void) {@\n%a%a%a@\nreturn 0;@]@\n}"
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions main

  method prototype f t = self#ptype f t

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a %s(%a)"
      self#ptype t funname
      (print_list
         (fun t (binding, type_) ->
            Format.fprintf t "%a@ %a"
              self#prototype type_ print_varname  binding
         ) sep_c
      ) li

  method prog f (prog: Utils.prog) =
    Format.fprintf f "#include <stdio.h>@\n#include <stdlib.h>@\n%a@\n%a%a@\n@\n"
      (fun f () ->
         if Tags.is_taged "use_math"
         then Format.fprintf f "#include <math.h>@\n"
      ) ()
(print_list (fun f t -> match t with
           | Prog.Comment str -> Format.fprintf f "/* %s */@\n" str
           | Prog.DeclarFun (funname, t, li, liinstrs, _opt) -> self#print_fun f funname t li liinstrs
           | Prog.DeclareType (name, t) -> self#decl_type f name t
           | Prog.Macro (name, t, params, code) ->
             macros <- StringMap.add
                 name (t, params, code)
                 macros
           | _ -> ()
         ) sep_nl)
             
      prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
      let b = List.exists (fun (n, t) -> match Type.unfix t with
          | Type.Named n -> n = name
          | _ -> false) li in
      Format.fprintf f "%atypedef struct %s {@\n@[<v 4>  %a@]@\n} %s;@\n"
        (fun f b ->
           if b then Format.fprintf f "struct %s;@\n" name
        ) b name
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "%a %s;" self#ptype type_ name
           ) sep_nl
        ) li name
    | Type.Enum li ->
      Format.fprintf f "typedef enum %s {@\n@[<v2>  %a@]@\n} %s;" name
        (print_list (fun t name -> Format.fprintf t "%s" name) sep_c) li name
    | _ -> assert false

  method declare_for s f li =
    if li <> [] then
      Format.fprintf f "%s %a;@\n"
        s
        (print_list print_varname sep_c) li

  method print_fun f funname t li instrs =
    let li_fori, li_forc = clike_collect_for instrs false in
    Format.fprintf f "@\n@[<h>%a@] {@\n@[<v 4>    %a%a%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions instrs

end
