
int baz0() {
  return 42;
}

__attribute__((noinline)) int bar0() {
  return baz0();
}

__attribute__((always_inline)) int baz1() {
  return bar0();
}

__attribute__((noinline)) int bar1() {
  return baz1();
}

int main() {
  return bar1();
}
