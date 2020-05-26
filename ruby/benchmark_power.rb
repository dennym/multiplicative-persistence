require 'benchmark/ips'
require 'ffi'
require '../c_src/power_ruby_ffi.rb'

n = 20_000

Benchmark::IPS.options[:format] = 'not human'

Benchmark::ips do |x|
  x.report('**:')   { 2**n * 3**n * 5**n * 7**n }
  x.report('pow:') { 2.pow(n) * 3.pow(n) * 5.pow(n) * 7.pow(n) }
  x.report('C - mpz_pow()') { RubyFFI.mpz_pow(2, n).to_i * RubyFFI.mpz_pow(3, n).to_i * RubyFFI.mpz_pow(5, n).to_i * RubyFFI.mpz_pow(7, n).to_i }
  x.report('C - loop pow') { RubyFFI.loop_pow(2, n).to_i * RubyFFI.loop_pow(3, n).to_i * RubyFFI.loop_pow(5, n).to_i * RubyFFI.loop_pow(7, n).to_i }
  x.report('C - loop pow reduced') { RubyFFI.loop_pow_reduced(2, n).to_i * RubyFFI.loop_pow_reduced(3, n).to_i * RubyFFI.loop_pow_reduced(5, n).to_i * RubyFFI.loop_pow_reduced(7, n).to_i }
  x.report('C - complete RubyFFIulation') { RubyFFI.complete_calculation(n, n, n, n) }
end