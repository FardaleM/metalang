#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
  Ce test a été généré par Metalang.
*/
int result(int len, int* tab){
  int i2, i1, i;
  int *tab2 = malloc( len * sizeof(int));
  for (i = 0 ; i < len; i++)
    tab2[i] = 0;
  for (i1 = 0 ; i1 < len; i1++)
  {
    printf("%d ", tab[i1]);
    tab2[tab[i1]] = 1;
  }
  printf("\n");
  for (i2 = 0 ; i2 < len; i2++)
    if (!tab2[i2])
    return i2;
  return -1;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int e, b;
  scanf("%d ", &b);
  int len = b;
  printf("%d\n", len);
  int *tab = malloc( len * sizeof(int));
  for (e = 0 ; e < len; e++)
  {
    scanf("%d ", &tab[e]);
  }
  printf("%d\n", result(len, tab));
  [pool drain];
  return 0;
}


