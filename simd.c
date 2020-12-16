#include <wasm_simd128.h>

void multiply_arrays(int* out, int* in_a, int* in_b, int size) {
  for (int i = 0; i < size; i += 4) {
    v128_t a = wasm_v128_load(&in_a[i]);
    v128_t b = wasm_v128_load(&in_b[i]);
    v128_t prod = wasm_i32x4_mul(a, b);
    wasm_v128_store(&out[i], prod);
  }
}

int main(int argc, char** argv) {
  int a[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
  int b[8] = { 8, 7, 6, 5, 4, 3, 2, 1 };
  int c[8];
  multiply_arrays(c, a, b, 16);
  return c[0];
}
