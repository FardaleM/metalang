#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface toto : NSObject
{
  @public int foo;
  @public int bar;
  @public int blah;
}
@end
@implementation toto 
@end

toto * mktoto(int v1){
  toto * t = [toto alloc];
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}

int result(toto ** t, int len){
  int j;
  int out0 = 0;
  for (j = 0 ; j < len; j++)
  {
    t[j]->blah = t[j]->blah + 1;
    out0 = out0 + t[j]->foo + t[j]->blah * t[j]->bar + t[j]->bar * t[j]->foo;
  }
  return out0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  toto * *t = calloc( 4 , sizeof(toto *));
  for (i = 0 ; i < 4; i++)
    t[i] = mktoto(i);
  scanf("%d %d", &t[0]->bar, &t[1]->blah);
  int titi = result(t, 4);
  printf("%d%d", titi, t[2]->blah);
  [pool drain];
  return 0;
}


