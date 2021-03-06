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


(** Variable names generator
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ext
open Ast

let var_of_int =
  let alpha = Array.init 26 (fun i -> char_of_int (i + (int_of_char 'a') ) ) in
  let len = 26 in
  let rec f i =
    let s = String.make 1 alpha.(i mod len)  in
    if i / len == 0 then s
    else
      (f (i / len) ) ^ s
  in f;;

let bindings = ref StringSet.empty

let add s =
  bindings := StringSet.add s !bindings

let fresh_init prog =
  let addsetty t acc = match t with
    | Type.Named n -> StringSet.add n acc
    | Type.Array t | Type.Option t -> t acc
    | Type.Tuple li -> List.fold_left (|>) acc li
    | Type.Struct li -> List.fold_left (fun acc (name, f) -> StringSet.add name (f acc)) acc li
    | Type.Enum l -> List.fold_left (fun a b -> StringSet.add b a) acc l
    | Type.Void | Type.Bool | Type.Auto | Type.Integer | Type.Char | Type.String | Type.Lexems -> acc
  in
  let addset acc i = Instr.Writer.Deep.fold
      (fun acc i ->
         match Instr.unfix i with
         | Instr.Declare (UserName b, _, _, _)
         | Instr.AllocRecord(UserName b, _, _, _)
         | Instr.AllocArray (UserName b, _, _, None, _)
         | Instr.Loop (UserName b, _, _, _)
           -> StringSet.add b acc
         | Instr.Read li ->
           List.fold_left (fun acc -> function
               | Instr.DeclRead (_, UserName b, _) -> StringSet.add b acc
               | _ -> acc) acc li
         | Instr.AllocArray (b1, _, _, Some (b2, _), _)
           ->
           let acc = match b1 with
             | UserName b1 -> StringSet.add b1 acc
             | _ -> acc in
           let acc = match b2 with
             | UserName b2 -> StringSet.add b2 acc
             | _ -> acc
           in acc
         | Instr.Untuple (li, e, _) ->
           List.fold_left (fun acc (_, name) ->
               match name with UserName name -> StringSet.add name acc
                             | _ -> acc) acc li
         | _ -> acc
      ) acc i
  in
  let addtop (acc : StringSet.t) t : StringSet.t = match t with
    | Prog.DeclarFun (v, t, params, instrs, _) ->
      let acc = StringSet.add v acc in
      let acc:StringSet.t = List.fold_left
          (fun acc (v, _ ) -> match v with
             | UserName v -> StringSet.add v acc
             | _ -> acc)
          acc params in
      let acc:StringSet.t = List.fold_left addset acc instrs in
      acc
    | Prog.DeclareType (name, t)->
      let acc = StringSet.add name acc in
      let acc = Type.Fixed.Deep.fold addsetty t acc in
      acc
    | _ -> acc
  in
  let set = StringSet.empty in
  let set = match prog.Prog.main with
    | None -> set
    | Some instrs -> List.fold_left addset set instrs in
  let set = List.fold_left addtop set prog.Prog.funs in
  let () = bindings := set
  in ();;

let fresh_user =
  let r = ref (-1) in
  let rec gen () =
    r := !r + 1 ;
    let out = var_of_int !r in
    if StringSet.mem out !bindings then gen () else out
  in gen



let fresh_internal =
  let r = ref (-1) in
  fun () -> r := !r + 1 ; InternalName !r


