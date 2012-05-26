{
	open Stdlib
	open Lexing
	let newline lexbuf =
		let p = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- { p with
      pos_lnum = 1 + p.pos_lnum ;
      pos_bol  = p.pos_cnum ;
    }

	let error lexbuf =
		let x = lexbuf.lex_curr_p in
		failwith $ Printf.sprintf "lexing error at line %i, char %i, near %s"
			x.pos_lnum
			(x.pos_cnum - x.pos_bol - 1)
			(lexeme lexbuf)

	open Parser
}

let ignore = '#' [^ '\n']*
let space = [' ' '\t' '\r']

let int = ['0'-'9']+
let char = "\\'" | [^'\'' '\\'] | "\\n" | "\\r" | ("\\" int)
let string = (( "\\\"" | [^'"'] )*)
let comment = ([^'*'] | ('*' [^'/'] ) )*
let ident = ['a'-'z'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
(* whitespace *)
| "/*" (comment as str ) "*/" {
	token lexbuf 
(* COMMENT(str) TODO *)
}
| '\n' { newline lexbuf ; token lexbuf }
| ignore { token lexbuf }
| space { token lexbuf }

(* keyword *)
| "def"  { DEF }
| "with" { WITH }
| "main" { MAIN }
| "end"  { END }
| "read"  { READ }
| "print" { PRINT }
| "skip"  { SKIP }
| "macro" { MACRO }

(* control flow *)
| "if"   { IF }
| "then" { THEN }
| "else" { ELSE }
| "elsif" { ELSIF }
| "do"   { DO }
| "for"  { FOR }
| "to"   { TO }
| "while"  { WHILE }
| "return" { RETURN }

(* type *)
| "enum"   { ENUM }
| "record" { RECORD }
| "int"    { TYPE_INT }
| "float"  { TYPE_FLOAT }
| "char"   { TYPE_CHAR }
| "bool"   { TYPE_BOOL }
| "array"  { TYPE_ARRAY }
| "void"  { TYPE_VOID }

(* punctuation *)
| "=" { SET }
| "." { DOT }
| "," { COMMA }
| ";" { PERIOD }
| "(" { LEFT_PARENS }
| ")" { RIGHT_PARENS }
| "[" { LEFT_BRACKET }
| "]" { RIGHT_BRACKET }

(* operator *)
| "!"  { NOT }
| "&&" { AND }
| "||" { OR }

| "==" { EQUAL }
| "!=" | "<>" { NOT_EQUAL }
| "<"  { LOWER }
| ">"  { HIGHER }
| "<=" | "=<" { LOWER_OR_EQUAL }
| ">=" | "=>" { HIGHER_OR_EQUAL }

| "+" { ADD }
| "-" { NEG }
| "*" { MUL }
| "/" { DIV }
| "%" { MODULO }

(* value *)
| "true"  { TRUE }
| "false" { FALSE }

| int as x { INT (int_of_string x) }
| '\'' char '\'' as x { CHAR (Scanf.sscanf x "%C" (fun x -> x)) }
| '"' (string as x) '"' { STRING x }
| ident as x { IDENT x }

| eof { EOF }
| _ { error lexbuf }
