require 'benchmark'
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

Benchmark.bm(25) do |x|
  x.report('**:')   { n.times { 2**n * 3**n * 5**n * 7**n } }
  x.report('pow:') { n.times { 2.pow(n) * 3.pow(n) * 5.pow(n) * 7.pow(n) } }
  x.report('C - mpz_pow()') { n.times { Calc.mpz_pow(2, n).to_i * Calc.mpz_pow(3, n).to_i * Calc.mpz_pow(5, n).to_i * Calc.mpz_pow(7, n).to_i } }
  x.report('C - loop pow') { n.times { Calc.loop_pow(2, n).to_i * Calc.loop_pow(3, n).to_i * Calc.loop_pow(5, n).to_i * Calc.loop_pow(7, n).to_i } }
  x.report('C - loop pow reduced') { n.times { Calc.loop_pow_reduced(2, n).to_i * Calc.loop_pow_reduced(3, n).to_i * Calc.loop_pow_reduced(5, n).to_i * Calc.loop_pow_reduced(7, n).to_i } }
  x.report('C - complete calculation') { n.times { Calc.complete_calculation(n, n, n, n) } }
end