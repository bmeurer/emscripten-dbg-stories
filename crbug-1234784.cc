#include <cstdlib>
#include <iostream>
#include <string>

__attribute__((noinline)) void alert(const char* msg) {
  std::cout << msg << std::endl;
}

std::string getOtherString(const std::string& input) {
  if (input.empty()) {
    return "Other String";
  }
  return "";
}

template <class T> T templatedFunc(const std::string& input, T value);
template <> int templatedFunc(const std::string& input, int value) {
  std::string fullString(input + " World");
  std::string otherString(getOtherString(input));

  if (otherString.empty()) {
    std::cout << "Got empty string" << std::endl;
    alert("No one could have predicted this!");
    return value;
  }

  std::cout << "Didn't really need either string" << std::endl;
  return 0;
}

int main(int argc, char** argv) {
  return templatedFunc("Hello", 42);
}
