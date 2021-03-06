program tictactoe;

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

{
Tictactoe : un tictactoe avec une IA
}
{ La structure de donnée }
type gamestate=^gamestate_r;
  e = array of Longint;
  f = array of e;
  gamestate_r = record
    cases : f;
    firstToPlay : boolean;
    note : Longint;
    ended : boolean;
  end;

{ Un Mouvement }
type move=^move_r;
  move_r = record
    x : Longint;
    y : Longint;
  end;

{ On affiche l'état }
procedure print_state(g : gamestate);
var
  x : Longint;
  y : Longint;
begin
  Write(''#10'|');
  for y := 0 to  2 do
  begin
    for x := 0 to  2 do
    begin
      if g^.cases[x][y] = 0 then
        begin
          Write(' ');
        end
      else if g^.cases[x][y] = 1
      then
        begin
          Write('O');
        end
      else
        begin
          Write('X');
        end;;
      Write('|');
    end;
    if y <> 2
    then
      begin
        Write(''#10'|-|-|-|'#10'|');
      end;
  end;
  Write(''#10'');
end;

{ On dit qui gagne (info stoquées dans g.ended et g.note ) }
procedure eval0(g : gamestate);
var
  col : Longint;
  colv : Longint;
  freecase : Longint;
  lin : Longint;
  linv : Longint;
  win : Longint;
  x : Longint;
  y : Longint;
begin
  win := 0;
  freecase := 0;
  for y := 0 to  2 do
  begin
    col := -1;
    lin := -1;
    for x := 0 to  2 do
    begin
      if g^.cases[x][y] = 0
      then
        begin
          freecase := freecase + 1;
        end;
      colv := g^.cases[x][y];
      linv := g^.cases[y][x];
      if (col = -1) and (colv <> 0) then
        begin
          col := colv;
        end
      else if colv <> col
      then
        begin
          col := -2;
        end;;
      if (lin = -1) and (linv <> 0) then
        begin
          lin := linv;
        end
      else if linv <> lin
      then
        begin
          lin := -2;
        end;;
    end;
    if col >= 0 then
      begin
        win := col;
      end
    else if lin >= 0
    then
      begin
        win := lin;
      end;;
  end;
  for x := 1 to  2 do
  begin
    if (g^.cases[0][0] = x) and (g^.cases[1][1] = x) and (g^.cases[2][2] = x)
    then
      begin
        win := x;
      end;
    if (g^.cases[0][2] = x) and (g^.cases[1][1] = x) and (g^.cases[2][0] = x)
    then
      begin
        win := x;
      end;
  end;
  g^.ended := (win <> 0) or (freecase = 0);
  if win = 1 then
    begin
      g^.note := 1000;
    end
  else if win = 2
  then
    begin
      g^.note := -1000;
    end
  else
    begin
      g^.note := 0;
    end;;
end;

{ On applique un mouvement }
procedure apply_move_xy(x : Longint; y : Longint; g : gamestate);
var
  player : Longint;
begin
  player := 2;
  if g^.firstToPlay
  then
    begin
      player := 1;
    end;
  g^.cases[x][y] := player;
  g^.firstToPlay := not(g^.firstToPlay);
end;

procedure apply_move(m : move; g : gamestate);
begin
  apply_move_xy(m^.x, m^.y, g);
end;

procedure cancel_move_xy(x : Longint; y : Longint; g : gamestate);
begin
  g^.cases[x][y] := 0;
  g^.firstToPlay := not(g^.firstToPlay);
  g^.ended := false;
end;

procedure cancel_move(m : move; g : gamestate);
begin
  cancel_move_xy(m^.x, m^.y, g);
end;

function can_move_xy(x : Longint; y : Longint; g : gamestate) : boolean;
begin
  exit(g^.cases[x][y] = 0);
end;

function can_move(m : move; g : gamestate) : boolean;
begin
  exit(can_move_xy(m^.x, m^.y, g));
end;

{
Un minimax classique, renvoie la note du plateau
}
function minmax(g : gamestate) : Longint;
var
  currentNote : Longint;
  maxNote : Longint;
  x : Longint;
  y : Longint;
begin
  eval0(g);
  if g^.ended
  then
    begin
      exit(g^.note);
    end;
  maxNote := -10000;
  if not(g^.firstToPlay)
  then
    begin
      maxNote := 10000;
    end;
  for x := 0 to  2 do
  begin
    for y := 0 to  2 do
    begin
      if can_move_xy(x, y, g)
      then
        begin
          apply_move_xy(x, y, g);
          currentNote := minmax(g);
          cancel_move_xy(x, y, g);
          { Minimum ou Maximum selon le coté ou l'on joue}
          if (currentNote > maxNote) = g^.firstToPlay
          then
            begin
              maxNote := currentNote;
            end;
        end;
    end;
  end;
  exit(maxNote);
end;

{
Renvoie le coup de l'IA
}
function play(g : gamestate) : move;
var
  currentNote : Longint;
  minMove : move;
  minNote : Longint;
  x : Longint;
  y : Longint;
begin
  new(minMove);
  minMove^.x := 0;
  minMove^.y := 0;
  minNote := 10000;
  for x := 0 to  2 do
  begin
    for y := 0 to  2 do
    begin
      if can_move_xy(x, y, g)
      then
        begin
          apply_move_xy(x, y, g);
          currentNote := minmax(g);
          Write(x);
          Write(', ');
          Write(y);
          Write(', ');
          Write(currentNote);
          Write(''#10'');
          cancel_move_xy(x, y, g);
          if currentNote < minNote
          then
            begin
              minNote := currentNote;
              minMove^.x := x;
              minMove^.y := y;
            end;
        end;
    end;
  end;
  Write(minMove^.x);
  Write(minMove^.y);
  Write(''#10'');
  exit(minMove);
end;

function init0() : gamestate;
var
  a : gamestate;
  cases : f;
  i : Longint;
  j : Longint;
  tab : e;
begin
  SetLength(cases, 3);
  for i := 0 to  2 do
  begin
    SetLength(tab, 3);
    for j := 0 to  2 do
    begin
      tab[j] := 0;
    end;
    cases[i] := tab;
  end;
  new(a);
  a^.cases := cases;
  a^.firstToPlay := true;
  a^.note := 0;
  a^.ended := false;
  exit(a);
end;

function read_move() : move;
var
  b : move;
  x : Longint;
  y : Longint;
begin
  x := read_int_();
  skip();
  y := read_int_();
  skip();
  new(b);
  b^.x := x;
  b^.y := y;
  exit(b);
end;


var
  c : move;
  d : move;
  i : Longint;
  state : gamestate;
begin
  for i := 0 to  1 do
  begin
    state := init0();
    new(c);
    c^.x := 1;
    c^.y := 1;
    apply_move(c, state);
    new(d);
    d^.x := 0;
    d^.y := 0;
    apply_move(d, state);
    while not(state^.ended) do
    begin
      print_state(state);
      apply_move(play(state), state);
      eval0(state);
      print_state(state);
      if not(state^.ended)
      then
        begin
          apply_move(play(state), state);
          eval0(state);
        end;
    end;
    print_state(state);
    Write(state^.note);
    Write(''#10'');
  end;
end.


