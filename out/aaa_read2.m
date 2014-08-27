#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, i3, s, p, i_, l, m, i, f, g, b;
  char u;
  scanf("%d ", &b);
  int len = b;
  printf("%d=len\n", len);
  int *e = malloc( len * sizeof(int));
  for (f = 0 ; f < len; f++)
  {
    scanf("%d ", &g);
    e[f] = g;
  }
  int* tab = e;
  for (i = 0 ; i < len; i++)
  {
    printf("%d=>%d ", i, tab[i]);
  }
  printf("\n");
  int *k = malloc( len * sizeof(int));
  for (l = 0 ; l < len; l++)
  {
    scanf("%d ", &m);
    k[l] = m;
  }
  int* tab2 = k;
  for (i_ = 0 ; i_ < len; i_++)
  {
    printf("%d==>%d ", i_, tab2[i_]);
  }
  scanf("%d ", &p);
  int strlen = p;
  printf("%d=strlen\n", strlen);
  char *r = malloc( strlen * sizeof(char));
  for (s = 0 ; s < strlen; s++)
  {
    scanf("%c", &u);
    r[s] = u;
  }
  scanf(" ");
  char* tab4 = r;
  for (i3 = 0 ; i3 < strlen; i3++)
  {
    char tmpc = tab4[i3];
    int c = (int)(tmpc);
    printf("%c:%d ", tmpc, c);
    if (tmpc != ' ')
      c = ((c - (int)('a')) + 13) % 26 + (int)('a');
    tab4[i3] = (char)(c);
  }
  for (j = 0 ; j < strlen; j++)
    printf("%c", tab4[j]);
  [pool drain];
  return 0;
}


