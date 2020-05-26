require 'benchmark/ips'
require 'ffi'

module Calc
  extend FFI::Library
  ffi_lib '../build/libpow.so'

  attach_function :mpz_pow, [ :int, :int ], :string
  attach_function :loop_pow, [ :int, :int ], :string
  attach_function :loop_pow_reduced, [ :int, :int ], :string
  attach_function :complete_calculation, [ :int, :int, :int, :int ], :string
end

n = 20_000

Benchmark::ips do |x|
  x.report('**:')   { 2**n * 3**n * 5**n * 7**n }
  x.report('pow:') { 2.pow(n) * 3.pow(n) * 5.pow(n) * 7.pow(n) }
  x.report('C - mpz_pow()') { Calc.mpz_pow(2, n).to_i * Calc.mpz_pow(3, n).to_i * Calc.mpz_pow(5, n).to_i * Calc.mpz_pow(7, n).to_i }
  x.report('C - loop pow') { Calc.loop_pow(2, n).to_i * Calc.loop_pow(3, n).to_i * Calc.loop_pow(5, n).to_i * Calc.loop_pow(7, n).to_i }
  x.report('C - loop pow reduced') { Calc.loop_pow_reduced(2, n).to_i * Calc.loop_pow_reduced(3, n).to_i * Calc.loop_pow_reduced(5, n).to_i * Calc.loop_pow_reduced(7, n).to_i }
  x.report('C - complete calculation') { Calc.complete_calculation(n, n, n, n) }
end