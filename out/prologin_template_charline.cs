using System;
using System.Collections.Generic;

public class prologin_template_charline
{
  public static int programme_candidat(char[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
    {
      out_ += tableau[i] * i;
      Console.Write(tableau[i]);
    }
    Console.Write("--\n");
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int a = int.Parse(Console.ReadLine());
    int taille = a;
    char[] b = Console.ReadLine().ToCharArray();
    char[] tableau = b;
    Console.Write("" + programme_candidat(tableau, taille) + "\n");
  }
  
}

