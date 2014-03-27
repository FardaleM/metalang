program affect;

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
function read_int_() : integer;
var
   c    : char;
   i    : integer;
   sign :  integer;
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

{
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
}
type
    toto=^toto_r;
    toto_r = record
      foo : integer;
      bar : integer;
      blah : integer;
    end;

function mktoto(v1 : integer) : toto;
var
  c : toto;
  t : toto;
begin
  new(c);
  c^.foo := v1;
  c^.bar := v1;
  c^.blah := v1;
  t := c;
  exit(t);
end;

function mktoto2(v1 : integer) : toto;
var
  d : toto;
  t : toto;
begin
  new(d);
  d^.foo := v1
  +
  3;
  d^.bar := v1
  +
  2;
  d^.blah := v1
  +
  1;
  t := d;
  exit(t);
end;

type f = array of integer;
function result(t_ : toto; t2_ : toto) : integer;
var
  cache0 : f;
  cache1 : f;
  cache2 : f;
  e : toto;
  i : integer;
  j : integer;
  len : integer;
  t : toto;
  t2 : toto;
  t3 : toto;
begin
  t := t_;
  t2 := t2_;
  new(e);
  e^.foo := 0;
  e^.bar := 0;
  e^.blah := 0;
  t3 := e;
  t3 := t2;
  t := t2;
  t2 := t3;
  t^.blah := t^.blah + 1;
  len := 1;
  SetLength(cache0, len);
  for i := 0 to  len - 1 do
  begin
    cache0[i] := -i;
  end;
  SetLength(cache1, len);
  for j := 0 to  len - 1 do
  begin
    cache1[j] := j;
  end;
  cache2 := cache0;
  cache0 := cache1;
  cache2 := cache0;
  exit(t^.foo + t^.blah * t^.bar + t^.bar * t^.foo);
end;


var
  a : integer;
  b : integer;
  t : toto;
  t2 : toto;
begin
  t := mktoto(4);
  t2 := mktoto(5);
  t^.bar := read_int_();
  skip();
  t^.blah := read_int_();
  skip();
  t2^.bar := read_int_();
  skip();
  t^.blah := read_int_();
  a := result(t, t2);
  Write(a);
  b := t^.blah;
  Write(b);
end.


