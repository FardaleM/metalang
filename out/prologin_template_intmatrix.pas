program prologin_template_intmatrix;

var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
end; 
procedure skip();
var
   n : char;
   t : char;
   s : char;
begin
   n := #13;
   t := #10;
   s := #32;
   if not( global_has_char ) then
      skip_char();
   while (global_char = s) or (global_char = n) or (global_char = t) do
   begin
      skip_char();
   end;
end;
function read_char_aux() : char;
begin
   if global_has_char then
      read_char_aux := global_char
   else
   begin
      skip_char();
      read_char_aux := global_char;
   end
end;
function read_int_() : Longint;
var
   c    : char;
   i    : Longint;
   sign :  Longint;
begin
   i := 0;
   c := read_char_aux();
   if c = '-' then begin
      skip_char();
      sign := -1;
   end
   else
      sign := 1;

   repeat
      c := read_char_aux();
      if (ord(c) <=57) and (ord(c) >= 48) then
      begin
         i := i * 10 + ord(c) - 48;
         skip_char();
      end
      else
         exit(i * sign);
   until false;
end;

type d = array of Longint;
type e = array of d;
function programme_candidat(tableau : e; x : Longint; y : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  out0 : Longint;
begin
  out0 := 0;
  for i := 0 to  y - 1 do
  begin
    for j := 0 to  x - 1 do
    begin
      out0 := out0 + tableau[i][j] * (i * 2 + j);
    end;
  end;
  exit(out0);
end;


var
  a : Longint;
  b : d;
  c : Longint;
  tableau : e;
  taille_x : Longint;
  taille_y : Longint;
begin
  taille_x := read_int_();
  skip();
  taille_y := read_int_();
  skip();
  SetLength(tableau, taille_y);
  for a := 0 to  taille_y - 1 do
  begin
    SetLength(b, taille_x);
    for c := 0 to  taille_x - 1 do
    begin
      b[c] := read_int_();
      skip();
    end;
    tableau[a] := b;
  end;
  Write(programme_candidat(tableau, taille_x, taille_y));
  Write(''#10'');
end.


