#include <stdio.h>
#include <stdlib.h>

/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
int main(void) {
  int i;
  char input = ' ';
  int current_pos = 500;
  int *mem = calloc( 1000 , sizeof(int));
  for (i = 0; i < 1000; i++)
    mem[i] = 0;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  current_pos++;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  while (mem[current_pos] != 0)
  {
    mem[current_pos] = mem[current_pos] - 1;
    current_pos --;
    mem[current_pos] = mem[current_pos] + 1;
    printf("%c", (char)(mem[current_pos]));
    current_pos++;
  }
  return 0;
}


