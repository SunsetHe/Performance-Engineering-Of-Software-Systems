// Copyright (c) 2012 MIT License by 6.172 Staff

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main() {
  // Please print the sizes of the following types:
  // int, short, long, char, float, double, unsigned int, long long
  // uint8_t, uint16_t, uint32_t, and uint64_t, uint_fast8_t,
  // uint_fast16_t, uintmax_t, intmax_t, __int128, and student

  // Here's how to show the size of one type. See if you can define a macro
  // to avoid copy pasting this code.
  //printf("size of %s : %zu bytes \n", "int", sizeof(int));
  // e.g. PRINT_SIZE("int", int);
  //      PRINT_SIZE("short", short);

  // Alternatively, you can use stringification
  // (https://gcc.gnu.org/onlinedocs/cpp/Stringification.html) so that
  // you can write
  // e.g. PRINT_SIZE(int);
  //      PRINT_SIZE(short);

  // Composite types have sizes too.
  printf("Size of int: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(int),sizeof(int *));
  printf("Size of short: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(short),sizeof(short *));
  printf("Size of long: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(long),sizeof(long *));
  printf("Size of char: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(char),sizeof(char *));
  printf("Size of float: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(float),sizeof(float *));
  printf("Size of double: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(double),sizeof(double *));
  printf("Size of unsigned int: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(unsigned int),sizeof(unsigned int *));
  printf("Size of long long: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(long long),sizeof(long long *));
  printf("Size of uint8_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uint8_t),sizeof(uint8_t *));
  printf("Size of uint16_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uint16_t),sizeof(uint16_t *));
  printf("Size of uint32_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uint32_t),sizeof(uint32_t *));
  printf("Size of uint64_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uint64_t),sizeof(uint64_t *));
  printf("Size of uint_fast8_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uint_fast8_t),sizeof(uint_fast8_t *));
  printf("Size of uint_fast16_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uint_fast16_t),sizeof(uint_fast16_t *));
  printf("Size of uintmax_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(uintmax_t),sizeof(uintmax_t *));
  printf("Size of intmax_t: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(intmax_t),sizeof(intmax_t *));
  printf("Size of __int128: %zu bytes, Size of the pointer to it: %zu bytes\n", sizeof(__int128),sizeof(__int128 *));

  typedef struct {
    int id;
    int year;
  } student;

  student you;
  you.id = 12345;
  you.year = 4;


  // Array declaration. Use your macro to print the size of this.
  int x[5];


  // You can just use your macro here instead: PRINT_SIZE("student", you);
  printf("size of %s : %zu bytes \n", "student", sizeof(you));
  printf("size of %s : %zu bytes \n", "x", sizeof(x));

  return 0;
}
