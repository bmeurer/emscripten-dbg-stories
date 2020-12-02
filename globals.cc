#include <iostream>

static int x = 0;

static int incX() {
  int prevX = x;
  int newX = prevX + 1;
  x = newX;
  return prevX;
}

std::string hello = "Hello";

namespace {

std::string world = "World";

void greet() {
  int myX = incX();
  std::cout << hello << " " << myX << " " << world << "\n";
}

}

int main() {
  greet();
  greet();
  return 0;
}
