#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct args_ty {
    int *array;
    int length;
    int constant;
} args;

/* multiplies each element by a constant */
void multiplyByConstant(int *array, int length, int constant) {
  for (int i = 0; i < length; ++i) {
      array[i] *= constant;
  }
}

/* adds a constant to each element */
void addConstant(int *array, int length, int constant) {
  for (int i = 0; i < length; ++i) {
    array[i] += constant;
  }  
}

/* entry point for thread */
void *threadEntryPoint(void *input) {
  args *arguments = (args*) input;
  multiplyByConstant(arguments->array, arguments->length, arguments->constant);
  return NULL;
}

int main() {
  int n = 10;
  int x[n], y[n];

  /* initialize x and y */
  for (int i = 0; i < n; ++i) {
    x[i] = i;
    y[i] = n-i-1;
  }

  /* this variable is our reference to the thread */
  pthread_t thread;

  /* intialize the argument to the thread */
  args *thread_args = (args*) malloc(sizeof(args));
  thread_args->array = x;
  thread_args->length = n;
  thread_args->constant = 5;

  /* create a second thread which executes threadEntryPoint */
  if(pthread_create(&thread, NULL, threadEntryPoint, (void*) thread_args)) {
    fprintf(stderr, "Error creating thread\n");
    return 1;
  }

  /* add 5 to each element in y */
  addConstant(y, n, 5);

  /* wait for the second thread to finish */
  if(pthread_join(thread, NULL)) {
    fprintf(stderr, "Error joining thread\n");
    return 2;
  }

  /* output x and y */
  for (int i = 0; i < n; ++i) {
      printf("x[%d] = %d, y[%d] = %d\n", i, x[i], i, y[i]);
  }
  return 0;
}