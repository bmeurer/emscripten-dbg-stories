#include <stdio.h>

__attribute__((always_inline)) int square(int x) {
  int result = x * x;
  return result;
}

__attribute__((noinline)) int dsquare(int x, int y) {
  int dsq = square(x);
  dsq += square(y);
  return dsq;
}

int main(int argc, char *argv[]) {
  int result = dsquare(6, 8);
  printf("result = %d\n", result);
  return 0;
}
