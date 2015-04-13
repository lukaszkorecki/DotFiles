# vi: ft=ruby
require 'benchmark'
require 'benchmark/ips'

TIMES = ITERATIONS

Benchmark.ips do |x|
  x.report('REPORT') do
    TIMES.times do
      # ...
    end
  end

  x.report('REPORT2') do
    TIMES.times do
      # ...
    end
  end

  x.compare!
end
