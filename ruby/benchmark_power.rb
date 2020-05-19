require 'benchmark'

n = 50_000

Benchmark.bm(7) do |x|
  x.report("**:")   { n.times { 2**n * 3**n * 5**n * 7**n } }
  x.report("pow:") { n.times { 2.pow(n) * 3.pow(n) * 5.pow(n) * 7.pow(n) } }
end