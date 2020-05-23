require 'benchmark'
require 'ffi'

module Calc
  extend FFI::Library
  ffi_lib '../build/libpow.so'

  attach_function :foo, [:int], :int
  attach_function :math_pow, [ :int, :ulong_long ], :ulong_long
  attach_function :loop_pow, [ :int, :ulong_long ], :ulong_long
end

n = 20_000

Benchmark.bm(7) do |x|
  x.report('**:')   { n.times { 2**n * 3**n * 5**n * 7**n } }
  x.report('pow:') { n.times { 2.pow(n) * 3.pow(n) * 5.pow(n) * 7.pow(n) } }
  x.report('C - pow()') { n.times { Calc.math_pow(2, n) * Calc.math_pow(3, n) * Calc.math_pow(5, n) * Calc.math_pow(7, n) } }
  x.report('C - loop pow') { Calc.loop_pow(2, n) * Calc.loop_pow(3, n) * Calc.loop_pow(5, n) * Calc.loop_pow(7, n) }
end