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

char* complete_calculation(int x2, int x3, int x5, int x7) {
  char * str_result;
  mpz_t base2, base3, base5, base7, tmp, result;

  mpz_init(tmp);
  mpz_init_set_ui(result, 1);
  mpz_init_set_ui(base2, 2);
  mpz_init_set_ui(base3, 3);
  mpz_init_set_ui(base5, 5);
  mpz_init_set_ui(base7, 7);

  mpz_pow_ui(tmp, base2, x2);
  mpz_mul(result, result, tmp);
  mpz_pow_ui(tmp, base3, x3);
  mpz_mul(result, result, tmp);
  mpz_pow_ui(tmp, base5, x5);
  mpz_mul(result, result, tmp);
  mpz_pow_ui(tmp, base7, x7);
  mpz_mul(result, result, tmp);

  str_result = mpz_get_str(NULL, 10, result);

  mpz_clear(tmp);
  mpz_clear(base2);
  mpz_clear(base3);
  mpz_clear(base5);
  mpz_clear(base7);
  mpz_clear(result);

  return str_result;
}

int main() {
  // only for test purpose
  loop_pow(2, 5000);

  return 0;
}