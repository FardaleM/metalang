
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure pathfinding is


type stringptr is access all char_array;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

procedure SkipSpaces is
  C : Character;
  Eol : Boolean;
begin
  loop
    Look_Ahead(C, Eol);
    exit when Eol or C /= ' ';
    Get(C);
  end loop;
end;
function min2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a < b
  then
    return a;
  else
    return b;
  end if;
end;
type e is Array (Integer range <>) of Integer;
type e_PTR is access e;
type f is Array (Integer range <>) of e_PTR;
type f_PTR is access f;
type g is Array (Integer range <>) of Character;
type g_PTR is access g;
type h is Array (Integer range <>) of g_PTR;
type h_PTR is access h;
function pathfind_aux(cache : in f_PTR; tab : in h_PTR; x : in Integer; y : in Integer; posX : in Integer; posY : in Integer) return Integer is
  val4 : Integer;
  val3 : Integer;
  val2 : Integer;
  val1 : Integer;
  out0 : Integer;
begin
  if posX = x - 1 and then posY = y - 1
  then
    return 0;
  else
    if ((posX < 0 or else posY < 0) or else posX >= x) or else posY >= y
    then
      return x * y * 10;
    else
      if tab(posY)(posX) = '#'
      then
        return x * y * 10;
      else
        if cache(posY)(posX) /= (-1)
        then
          return cache(posY)(posX);
        else
          cache(posY)(posX) := x * y * 10;
          val1 := pathfind_aux(cache, tab, x, y, posX + 1, posY);
          val2 := pathfind_aux(cache, tab, x, y, posX - 1, posY);
          val3 := pathfind_aux(cache, tab, x, y, posX, posY - 1);
          val4 := pathfind_aux(cache, tab, x, y, posX, posY + 1);
          out0 := 1 + min2_0(min2_0(min2_0(val1, val2), val3), val4);
          cache(posY)(posX) := out0;
          return out0;
        end if;
      end if;
    end if;
  end if;
end;
function pathfind(tab : in h_PTR; x : in Integer; y : in Integer) return Integer is
  tmp : e_PTR;
  cache : f_PTR;
begin
  cache := new f (0..y);
  for i in integer range 0..y - 1 loop
    tmp := new e (0..x);
    for j in integer range 0..x - 1 loop
      tmp(j) := (-1);
    end loop;
    cache(i) := tmp;
  end loop;
  return pathfind_aux(cache, tab, x, y, 0, 0);
end;

  y : Integer;
  x : Integer;
  tmp : Character;
  tab2 : g_PTR;
  tab : h_PTR;
  result : Integer;
begin
  Get(x);
  SkipSpaces;
  Get(y);
  SkipSpaces;
  tab := new h (0..y);
  for i in integer range 0..y - 1 loop
    tab2 := new g (0..x);
    for j in integer range 0..x - 1 loop
      tmp := Character'Val(0);
      Get(tmp);
      tab2(j) := tmp;
    end loop;
    SkipSpaces;
    tab(i) := tab2;
  end loop;
  result := pathfind(tab, x, y);
  PInt(result);
end;
