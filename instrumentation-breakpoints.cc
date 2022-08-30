#include <iostream>

void printAll(int *x, int length) {
  for (int i = 0; i < length; ++i) {
    std::cerr << x[i] << std::endl;
  }
}

int main() {
  int n = 10;
  int x[n];

  for (int i = 0; i < n; ++i) {
    x[i] = n - i;
  }
  printAll(x, n);
  return 0;
}
