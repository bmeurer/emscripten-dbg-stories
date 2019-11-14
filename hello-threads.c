#include <pthread.h>
#include <stdio.h>

void* foo(void* data) {
  printf("Hello threads!\n");
  return NULL;
}

int main(int argc, char** argv) {
  pthread_t id;
  pthread_create(&id, NULL, &foo, NULL);
  return 0;
}
