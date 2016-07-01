using System;

public class euler03
{
  
  public static void Main(String[] args)
  {
    int maximum = 1;
    int b0 = 2;
    int a = 408464633;
    int sqrtia = (int)Math.Sqrt(a);
    while (a != 1)
    {
        int b = b0;
        bool found = false;
        while (b <= sqrtia)
        {
            if (a % b == 0)
            {
                a /= b;
                b0 = b;
                b = a;
                sqrtia = (int)Math.Sqrt(a);
                found = true;
            }
            b += 1;
        }
        if (!found)
        {
            Console.Write(a + "\n");
            a = 1;
        }
    }
  }
  
}

