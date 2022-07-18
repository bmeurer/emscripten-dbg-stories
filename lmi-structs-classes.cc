#include <iostream>
#include <string>

struct movie {
  std::string title;
  int year_released;
  int budget;
};

class MovieReview {
  public:
    movie *mov;
    std::string review;
    int rating;
    void printMovieRating() {
      std::cout << this->mov->title << ": " << this->rating << "/5" << "\n";
    }

    MovieReview(movie *m, std::string review, int rating) {
      this->mov = m;
      this->review = review;
      this->rating = rating;
    }
};

int main() {
  movie stargate;
  stargate.title = "Star Gate Continuum";
  stargate.year_released = 2008;
  stargate.budget = 7000000;

  MovieReview stargateReview(&stargate, "The best thing since sliced bread.", 5);
  stargateReview.printMovieRating();
  
  // Added for testing double pointers.
  {
    movie *ptr = &stargate;
    movie **dblptr = &ptr;
    MovieReview *reviewptr = &stargateReview;
    MovieReview **reviewdblptr = &reviewptr;
    std::cout << "ptr: "<< ptr << ", dblptr: " << dblptr << "\n";
    std::cout << "reviewptr: "<< reviewptr << ", reviewdblptr: " << reviewdblptr << "\n";
  }

  return 0;
}
