#include <iostream>
#include <vector>
typedef struct tuple_int_int {
  int tuple_int_int_field_0;
    int tuple_int_int_field_1;
} tuple_int_int;

typedef struct toto {
  tuple_int_int foo;
    int bar;
} toto;


int main(void) {
    int d, c, bar_;
    std::cin >> bar_ >> c >> d;
    tuple_int_int e;
        e.tuple_int_int_field_0 = c;
        e.tuple_int_int_field_1 = d;;
    toto t;
        t.foo = e;
        t.bar = bar_;;
    tuple_int_int f = t.foo;
    int a = f.tuple_int_int_field_0;
    int b = f.tuple_int_int_field_1;
    std::cout << a << " " << b << " " << t.bar << "\n";
    return 0;
}

