#include<stdio.h>
#include<stdlib.h>

int eratostene(int* t, int max_){
  int n = 0;
  {
    int i;
    for (i = 2 ; i < max_; i++)
      if (t[i] == i)
    {
      n ++;
      int j = i * i;
      if (j / i == i)
      {
        /* overflow test */
        while (j < max_ && j > 0)
        {
          t[j] = 0;
          j += i;
        }
      }
    }
  }
  return n;
}

int main(void){
  int maximumprimes = 6000;
  int *era = malloc( maximumprimes * sizeof(int));
  {
    int j_;
    for (j_ = 0 ; j_ < maximumprimes; j_++)
      era[j_] = j_;
  }
  int nprimes = eratostene(era, maximumprimes);
  int *primes = malloc( nprimes * sizeof(int));
  {
    int o;
    for (o = 0 ; o < nprimes; o++)
      primes[o] = 0;
  }
  int l = 0;
  {
    int k;
    for (k = 2 ; k < maximumprimes; k++)
      if (era[k] == k)
    {
      primes[l] = k;
      l ++;
    }
  }
  printf("%d == %d\n", l, nprimes);
  int *canbe = malloc( maximumprimes * sizeof(int));
  {
    int i_;
    for (i_ = 0 ; i_ < maximumprimes; i_++)
      canbe[i_] = 0;
  }
  {
    int i;
    for (i = 0 ; i < nprimes; i++)
      {
      int j;
      for (j = 0 ; j < maximumprimes; j++)
      {
        int n = primes[i] + 2 * j * j;
        if (n < maximumprimes)
          canbe[n] = 1;
      }
    }
  }
  {
    int m;
    for (m = 1 ; m <= maximumprimes; m++)
    {
      int m2 = m * 2 + 1;
      if (m2 < maximumprimes && !canbe[m2])
      {
        printf("%d\n", m2);
      }
    }
  }
  return 0;
}


