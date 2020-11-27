// This illustrates a problem where the return locations
// for two inlined functions are the same, which makes
// handling Step-Out correctly tricky.

__attribute__((always_inline))
static int g(int x) {
  return x + 1;
}

__attribute__((always_inline))
static int h(int x) {
  return g(x);
}

int main(int argc, char** argv) {
  return h(argc);
}
