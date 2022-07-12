#include <iostream>

void usePrimitives(int &i, char &c, bool &b, float &f, double &d, wchar_t &w) {
  std::cerr << i << "\n";
  std::cerr << c << "\n";
  std::cerr << b << "\n";
  std::cerr << f << "\n";
  std::cerr << d << "\n";
  std::cerr << w << "\n";
}

int main() {
  int i = 1;
  char c = 'c';
  bool b = true;
  float f = 42.5;
  double d = 123.456;
  wchar_t w = L'A';
  
  // Added for testing double pointers.
  double *ptr = &d;
  double **dblptr = &ptr;
  
  usePrimitives(i, c, b, f, d, w);
}
