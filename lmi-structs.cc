#include <iostream>
#include <string>

struct movie {
  std::string title;
  int rating;
};

void printMovie(movie &m) {
  std::cout << m.title << ": " << m.rating << "\n";
}

int main() {
  movie stargate;
  stargate.title = "Star Gate Continuum";
  stargate.rating = 5;
  printMovie(stargate);
  
  // Added for testing double pointers.
  movie *ptr = &stargate;
  movie **dblptr = &ptr;

  return 0;
}
