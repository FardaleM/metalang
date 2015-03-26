import java.util.*;

public class affect
{
  static Scanner scanner = new Scanner(System.in);
  /*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
  static class Toto {
    int foo;
    int bar;
    int blah;
  }
  static Toto mktoto(int v1)
  {
    Toto t = new Toto();
    t.foo = v1;
    t.bar = v1;
    t.blah = v1;
    return t;
  }
  
  static Toto mktoto2(int v1)
  {
    Toto t = new Toto();
    t.foo = v1 + 3;
    t.bar = v1 + 2;
    t.blah = v1 + 1;
    return t;
  }
  
  static int result(Toto t_, Toto t2_)
  {
    Toto t = t_;
    Toto t2 = t2_;
    Toto t3 = new Toto();
    t3.foo = 0;
    t3.bar = 0;
    t3.blah = 0;
    t3 = t2;
    t = t2;
    t2 = t3;
    t.blah ++;
    int len = 1;
    int[] cache0 = new int[len];
    for (int i = 0 ; i < len; i++)
      cache0[i] = -i;
    int[] cache1 = new int[len];
    for (int j = 0 ; j < len; j++)
      cache1[j] = j;
    int[] cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  static void main(String[] args)
  {
    Toto t = mktoto(4);
    Toto t2 = mktoto(5);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      t.bar = -scanner.nextInt();
    }else{
      t.bar = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      t.blah = -scanner.nextInt();
    }else{
      t.blah = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      t2.bar = -scanner.nextInt();
    }else{
      t2.bar = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      t2.blah = -scanner.nextInt();
    }else{
      t2.blah = scanner.nextInt();
    }
    System.out.printf("%s%s", result(t, t2), t.blah);
  }
  
}

