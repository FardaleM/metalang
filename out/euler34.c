#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int a, b, c, d, e, g, i, j;
    int *f = calloc( 10 , sizeof(int));
    for (j = 0; j <= 9; j++)
      f[j] = 1;
    for (i = 1; i <= 9; i++)
    {
        f[i] *= i * f[i - 1];
        printf("%d ", f[i]);
    }
    int out0 = 0;
    printf("\n");
    for (a = 0; a <= 9; a++)
      for (b = 0; b <= 9; b++)
        for (c = 0; c <= 9; c++)
          for (d = 0; d <= 9; d++)
            for (e = 0; e <= 9; e++)
              for (g = 0; g <= 9; g++)
              {
                  int sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
                  int num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                  if (a == 0)
                  {
                      sum --;
                      if (b == 0)
                      {
                          sum --;
                          if (c == 0)
                          {
                              sum --;
                              if (d == 0)
                                sum --;
                          }
                      }
                  }
                  if (sum == num && sum != 1 && sum != 2)
                  {
                      out0 += num;
                      printf("%d ", num);
                  }
    }
    printf("\n%d\n", out0);
    return 0;
}


