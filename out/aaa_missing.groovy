import java.util.*;

public class aaa_missing
{
  static Scanner scanner = new Scanner(System.in);
  /*
  Ce test a été généré par Metalang.
*/
  static int result(int len, int[] tab)
  {
    boolean[] tab2 = new boolean[len];
    for (int i = 0 ; i < len; i++)
      tab2[i] = false;
    for (int i1 = 0 ; i1 < len; i1++)
    {
      System.out.printf("%s ", tab[i1]);
      tab2[tab[i1]] = true;
    }
    print("\n");
    for (int i2 = 0 ; i2 < len; i2++)
      if (!tab2[i2])
      return i2;
    return -1;
  }
  
  
  static void main(String[] args)
  {
    int len;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = scanner.nextInt();
    } else {
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s\n", len);
    int[] tab = new int[len];
    for (int a = 0 ; a < len; a++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab[a] = -scanner.nextInt();
      }else{
        tab[a] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    System.out.printf("%s\n", result(len, tab));
  }
  
}

