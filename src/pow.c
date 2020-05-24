#include <stdio.h>
#include <gmp.h>

char* mpz_pow(int base, int ext) {
  char * str_result;
  mpz_t internal_base, result;

  mpz_init(result);
  mpz_init_set_ui(internal_base, base);

  mpz_pow_ui(result, internal_base, ext);

  str_result = mpz_get_str(NULL, 10, result);

  mpz_clear(internal_base);
  mpz_clear(result);

  return str_result;
}

char* loop_pow_reduced(int base, int ext) {
  char * str_result;
  mpz_t result;

  mpz_init_set_ui(result, 1);

  while (ext !=0) {
    mpz_mul_ui(result, result, base);
    --ext;
  }

  str_result = mpz_get_str(NULL, 10, result);

  mpz_clear(result);

  return str_result;
}

char* loop_pow(int base, int ext) {
  char * str_result;
  mpz_t internal_base, result;

  mpz_init_set_ui(internal_base, base);
  mpz_init_set_ui(result, 1);

  while (ext !=0) {
    mpz_mul(result, result, internal_base);
    --ext;
  }

  str_result = mpz_get_str(NULL, 10, result);

  mpz_clear(internal_base);
  mpz_clear(result);

  return str_result;
}

int main() {
  // only for test purpose
  loop_pow(2, 5000);

  return 0;
}