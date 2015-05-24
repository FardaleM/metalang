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


(** Transforment les indexes des tableaux pour les langages qui comptent à partir de 1
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open PassesUtils

type acc0 = unit
type 'lex acc = unit
let init_acc () = ()

let map_mut m =
  Mutable.Fixed.Deep.map (* ne traverse pas les expressions puisque les expressions sont dans 'a. *)
    (fun m ->
      let m0 = match Mutable.unfix m with
      | Mutable.Array (m, li) ->
          Mutable.Array(m, List.map (fun e -> Expr.saddi e 1) li)
      | m -> m
      in Mutable.Fixed.fixa (Mutable.Fixed.annot m) m0
    ) m

let process () is =
  (), List.map (fun i ->
    Instr.Fixed.Deep.map2
      (function
        | Instr.Affect (m, e) -> Instr.Affect (map_mut m, e)
        | Instr.Read (ty, m) -> Instr.Read (ty, map_mut m)
        | i -> i)
      (Expr.Fixed.Deep.map (fun e -> match Expr.unfix e with
        | Expr.Access m -> Expr.Fixed.fixa (Expr.Fixed.annot e) $ Expr.Access (map_mut m)
        | _ -> e))
      i) is
