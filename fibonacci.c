#include <stdio.h>

int fib(int n) {
  int a, b = 0, c = 1;
  while (--n > 0) {
    a = b;
    b = c;
    c = a + b;
  }
  return c;
}

int main() {
  int a = fib(9);
  printf("9th fib: %d\n", a);
  int b = fib(5);
  printf("5th fib: %d\n", b);
  return 0;
}
