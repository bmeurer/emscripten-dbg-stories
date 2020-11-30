typedef union {
	int x;
	float y;
} u;

typedef struct {
	int x;
	float y;
} s;

int some_func(int x, u some_union, s some_struct) {
  return some_union.x + some_struct.x;
}

int main() {
	some_func(10, (u) { .x = 20 }, (s) { .x = 30 });
	return 0;
}
