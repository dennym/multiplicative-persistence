#include <stdio.h>
#include <math.h>
#include <gmp.h>

int main() {
   return 0;
}

unsigned long long math_pow(int base, int ext) {
  return pow(base, ext);
}

unsigned long long loop_pow(int base, int ext) {
  unsigned long long value = 1;

  while (ext !=0) {
    value *= base;
    --ext;
  }

  printf("value: %llu", value);

  return value;
}

int foo(int bar) {
  return bar;
}
