import java.util.*;

public class aaa_readints
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int f;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      f = scanner.nextInt();
    } else {
      f = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = f;
    System.out.printf("%d=len\n", len);
    int[] tab1 = new int[len];
    for (int k = 0 ; k < len; k++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab1[k] = -scanner.nextInt();
      }else{
        tab1[k] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d\n", i, tab1[i]);
    }
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = -scanner.nextInt();
    }else{
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] tab2 = new int[len - 1][];
    for (int s = 0 ; s < len - 1; s++)
    {
      int[] ba = new int[len];
      for (int v = 0 ; v < len; v++)
      {
        int w;
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          w = scanner.nextInt();
        } else {
          w = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        ba[v] = w;
      }
      tab2[s] = ba;
    }
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        System.out.printf("%d ", tab2[i][j]);
      }
      System.out.print("\n");
    }
  }
  
}

