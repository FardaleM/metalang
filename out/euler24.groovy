import java.util.*

int fact(int n)
{
  int prod = 1
  for (int i = 2; i <= n; i++)
      prod *= i
  return prod
}
void show(int lim, int nth)
{
  int[] t = new int[lim]
  for (int i = 0; i < lim; i++)
      t[i] = i
  boolean[] pris = new boolean[lim]
  for (int j = 0; j < lim; j++)
      pris[j] = false
  for (int k = 1; k < lim; k++)
  {
      int n = fact(lim - k)
      int nchiffre = nth.intdiv(n)
      nth = nth % n
      for (int l = 0; l < lim; l++)
          if (!pris[l])
          {
              if (nchiffre == 0)
              {
                  print(l)
                  pris[l] = true
              }
              nchiffre--
          }
  }
  for (int m = 0; m < lim; m++)
      if (!pris[m])
          print(m)
  print("\n")
}

show(10, 999999)

