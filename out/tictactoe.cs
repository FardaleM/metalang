using System;

public class tictactoe
{
static bool eof;
static String buffer;
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = "\n"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
public static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\n' || c == '\t' || c == '\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
}
public static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} 
  /*
Tictactoe : un tictactoe avec une IA
*/
  /* La structure de donnée */
  public class gamestate {public int[][] cases;public bool firstToPlay;public int note;public bool ended;}
  /* Un Mouvement */
  public class move {public int x;public int y;}
  /* On affiche l'état */
  public static void print_state(gamestate g)
  {
    Console.Write("\n|");
    for (int y = 0 ; y <= 2; y ++)
    {
      for (int x = 0 ; x <= 2; x ++)
      {
        if (g.cases[x][y] == 0)
          Console.Write(" ");
        else if (g.cases[x][y] == 1)
          Console.Write("O");
        else
          Console.Write("X");
        Console.Write("|");
      }
      if (y != 2)
        Console.Write("\n|-|-|-|\n|");
    }
    Console.Write("\n");
  }
  
  /* On dit qui gagne (info stoquées dans g.ended et g.note ) */
  public static void eval_(gamestate g)
  {
    int win = 0;
    int freecase = 0;
    for (int y = 0 ; y <= 2; y ++)
    {
      int col = -1;
      int lin = -1;
      for (int x = 0 ; x <= 2; x ++)
      {
        if (g.cases[x][y] == 0)
          freecase ++;
        int colv = g.cases[x][y];
        int linv = g.cases[y][x];
        if (col == -1 && colv != 0)
          col = colv;
        else if (colv != col)
          col = -2;
        if (lin == -1 && linv != 0)
          lin = linv;
        else if (linv != lin)
          lin = -2;
      }
      if (col >= 0)
        win = col;
      else if (lin >= 0)
        win = lin;
    }
    for (int x = 1 ; x <= 2; x ++)
    {
      if (g.cases[0][0] == x && g.cases[1][1] == x && g.cases[2][2] == x)
        win = x;
      if (g.cases[0][2] == x && g.cases[1][1] == x && g.cases[2][0] == x)
        win = x;
    }
    g.ended = win != 0 || freecase == 0;
    if (win == 1)
      g.note = 1000;
    else if (win == 2)
      g.note = -1000;
    else
      g.note = 0;
  }
  
  /* On applique un mouvement */
  public static void apply_move_xy(int x, int y, gamestate g)
  {
    int player = 2;
    if (g.firstToPlay)
      player = 1;
    g.cases[x][y] = player;
    g.firstToPlay = !g.firstToPlay;
  }
  
  public static void apply_move(move m, gamestate g)
  {
    apply_move_xy(m.x, m.y, g);
  }
  
  public static void cancel_move_xy(int x, int y, gamestate g)
  {
    g.cases[x][y] = 0;
    g.firstToPlay = !g.firstToPlay;
    g.ended = false;
  }
  
  public static void cancel_move(move m, gamestate g)
  {
    cancel_move_xy(m.x, m.y, g);
  }
  
  public static bool can_move_xy(int x, int y, gamestate g)
  {
    return g.cases[x][y] == 0;
  }
  
  public static bool can_move(move m, gamestate g)
  {
    return can_move_xy(m.x, m.y, g);
  }
  
  /*
Un minimax classique, renvoie la note du plateau
*/
  public static int minmax(gamestate g)
  {
    eval_(g);
    if (g.ended)
      return g.note;
    int maxNote = -10000;
    if (!g.firstToPlay)
      maxNote = 10000;
    for (int x = 0 ; x <= 2; x ++)
      for (int y = 0 ; y <= 2; y ++)
        if (can_move_xy(x, y, g))
    {
      apply_move_xy(x, y, g);
      int currentNote = minmax(g);
      cancel_move_xy(x, y, g);
      /* Minimum ou Maximum selon le coté ou l'on joue*/
      if ((currentNote > maxNote) == g.firstToPlay)
        maxNote = currentNote;
    }
    return maxNote;
  }
  
  /*
Renvoie le coup de l'IA
*/
  public static move play(gamestate g)
  {
    move minMove = new move();
    minMove.x = 0;
    minMove.y = 0;
    int minNote = 10000;
    for (int x = 0 ; x <= 2; x ++)
      for (int y = 0 ; y <= 2; y ++)
        if (can_move_xy(x, y, g))
    {
      apply_move_xy(x, y, g);
      int currentNote = minmax(g);
      Console.Write("" + x + ", " + y + ", " + currentNote + "\n");
      cancel_move_xy(x, y, g);
      if (currentNote < minNote)
      {
        minNote = currentNote;
        minMove.x = x;
        minMove.y = y;
      }
    }
    Console.Write("" + minMove.x + minMove.y + "\n");
    return minMove;
  }
  
  public static gamestate init_()
  {
    int[][] cases = new int[3][];
    for (int i = 0 ; i < 3; i++)
    {
      int[] tab = new int[3];
      for (int j = 0 ; j < 3; j++)
        tab[j] = 0;
      cases[i] = tab;
    }
    gamestate a = new gamestate();
    a.cases = cases;
    a.firstToPlay = true;
    a.note = 0;
    a.ended = false;
    return a;
  }
  
  public static move read_move()
  {
    int x = readInt();
    stdin_sep();
    int y = readInt();
    stdin_sep();
    move b = new move();
    b.x = x;
    b.y = y;
    return b;
  }
  
  
  public static void Main(String[] args)
  {
    for (int i = 0 ; i <= 1; i ++)
    {
      gamestate state = init_();
      move c = new move();
      c.x = 1;
      c.y = 1;
      apply_move(c, state);
      move d = new move();
      d.x = 0;
      d.y = 0;
      apply_move(d, state);
      while (!state.ended)
      {
        print_state(state);
        apply_move(play(state), state);
        eval_(state);
        print_state(state);
        if (!state.ended)
        {
          apply_move(play(state), state);
          eval_(state);
        }
      }
      print_state(state);
      Console.Write("" + state.note + "\n");
    }
  }
  
}

