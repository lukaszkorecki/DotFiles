#!/usr/bin/ruby
require 'tempfile'

f = Tempfile.new('email')
contents = ARGF.readlines.join("\n")
f.write contents

`open #{f.path}`
