program plus_petit;

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

type c = array of Longint;
function go0(tab : c; a : Longint; b : Longint) : Longint;
var
  e : Longint;
  i : Longint;
  j : Longint;
  m : Longint;
begin
  m := (a + b) Div 2;
  if a = m
  then
    begin
      if tab[a] = m
      then
        begin
          exit(b);
        end
      else
        begin
          exit(a);
        end;
    end;
  i := a;
  j := b;
  while i < j do
  begin
    e := tab[i];
    if e < m
    then
      begin
        i := i + 1;
      end
    else
      begin
        j := j - 1;
        tab[i] := tab[j];
        tab[j] := e;
      end;
  end;
  if i < m
  then
    begin
      exit(go0(tab, a, m));
    end
  else
    begin
      exit(go0(tab, m, b));
    end;
end;

function plus_petit0(tab : c; len : Longint) : Longint;
begin
  exit(go0(tab, 0, len));
end;


var
  i : Longint;
  len : Longint;
  tab : c;
  tmp : Longint;
begin
  len := 0;
  len := read_int_();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmp := 0;
    tmp := read_int_();
    skip();
    tab[i] := tmp;
  end;
  Write(plus_petit0(tab, len));
end.


