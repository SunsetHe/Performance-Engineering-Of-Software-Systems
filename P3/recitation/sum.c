#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef uint32_t data_t;

int main(int argc, char *argv[]) {
  if (argc != 3) {
    printf("Usage: %s U N\n", argv[0]);
    return -1;
  }

  const int U = atoi(argv[1]);   // size of the array
  const int N = atoi(argv[2]);   // number of searches to perform

  data_t* data = (data_t*) malloc(U * sizeof(data_t));
  if (data == NULL) {
    printf("Error: not enough memory\n");
    return -1;
  }

  // fill up the array with sequential (sorted) values.
  int i;
  for (i = 0; i < U; i++) {
    data[i] = i;
  }

  printf("Allocated array of size %d\n", U);
  printf("Summing %d random values...\n", N);

  data_t val = 0;
  data_t seed = 42;
  for (i = 0; i < N; i++) {
    int l = rand_r(&seed) % U;
    val = (val + data[l]);
  }

  free(data);
  printf("Done. Value = %d\n", val);
  return 0;
}
