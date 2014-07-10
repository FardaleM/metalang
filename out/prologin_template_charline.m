#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

char* read_char_line(int n){
  char *tab = malloc( n * sizeof(char));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      char t = '_';
      scanf("%c", &t);
      tab[i] = t;
    }
  }
  scanf(" ");
  return tab;
}

int programme_candidat(char* tableau, int taille){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < taille; i++)
    {
      out_ += tableau[i] * i;
      printf("%c", tableau[i]);
    }
  }
  printf("--\n");
  return out_;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int b = 0;
  scanf("%d ", &b);
  int a = b;
  int taille = a;
  char *d = malloc( taille * sizeof(char));
  {
    int e;
    for (e = 0 ; e < taille; e++)
    {
      char f = '_';
      scanf("%c", &f);
      d[e] = f;
    }
  }
  scanf(" ");
  char* c = d;
  char* tableau = c;
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}


