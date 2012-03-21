#!/usr/bin/env ruby
f=File
puts f.read(f.expand_path('~/.mcabber_debug')).split("\n").select{ |l| l =~ /MSG/ }.last.split("@").first
