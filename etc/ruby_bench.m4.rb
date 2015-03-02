# vi: ft=ruby
require 'benchmark'

TIMES = NUMBER

Benchmark.bmbm do |x|
  x.report(REPORT) do
    n.times do
      # ...
    end
  end

  x.report(REPORT2) do
    n.times do
      # ...
    end
  end
end
