import java.util.*;

public class sumDiv
{
  static Scanner scanner = new Scanner(System.in);
  static void foo()
  {
    int a = 0;
    /* test */
    a++;
    /* test 2 */
  }
  
  static void foo2()
  {
    
  }
  
  static void foo3()
  {
    if (1 == 1)
    {
        
    }
  }
  
  static int sumdiv(int n)
  {
    /* On désire renvoyer la somme des diviseurs */
    int out0 = 0;
    /* On déclare un entier qui contiendra la somme */
    for (int i = 1; i <= n; i++)
        /* La boucle : i est le diviseur potentiel*/
        if (n % i == 0)
        {
            /* Si i divise */
            out0 += i;
            /* On incrémente */
        }
        else
        {
            /* nop */
        }
    return out0;
    /*On renvoie out*/
  }
  
  
  public static void main(String args[])
  {
    /* Programme principal */
    int n = 0;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      n = -scanner.nextInt();
    }else{
      n = scanner.nextInt();
    }
    /* Lecture de l'entier */
    System.out.print(sumdiv(n));
  }
  
}

