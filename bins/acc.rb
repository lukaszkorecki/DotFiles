acc = File.read ARGV[0]

to_f = -> (v) { v.scan(/[0-9\.]*/).reject(&:empty?).first.to_f }

data = []

acc
  .lines
  .map { |r| r.split("\t") }
  .each do |r|
  if r.size > 3
    data << r
  else # new line in description !
    r.each { |mi| data.last << mi }
  end
end

ins = []
outs = []

data.each do |r|
  outs << to_f.call(r[-1])
  ins << to_f.call(r[-2])
end

ins_total = ins.reduce(&:+)
outs_total = outs.reduce(&:+)

puts "Ins: #{ ins_total }"
puts "Outs: #{ outs_total }"

puts "Balance: #{ outs_total - ins_total }"
