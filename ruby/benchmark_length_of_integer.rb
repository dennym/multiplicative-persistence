require 'benchmark'

n = 50_000_000
Benchmark.bm(7) do |x|
  x.report("to_s:")   { n.times { n.to_s.length } }
  x.report("log10:") { n.times { Math.log10(n).to_i + 1 } }
end