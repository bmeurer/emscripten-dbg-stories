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
  movie amovie;
  amovie.title = "Star Gate Continuum";
  amovie.rating = 5;
  printMovie(amovie);
  return 0;
}
