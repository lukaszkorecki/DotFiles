#!/usr/bin/ruby
require 'rubygems'
begin
  require 'awesome_print'
rescue => e
  puts e
end
require 'yaml'


if defined? IRB
  require 'fileutils'
  include FileUtils
  require 'irb/completion'
  require 'irb/ext/save-history'

  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

  IRB.conf[:PROMPT_MODE] = :SIMPLE
end

module H_
  def self.load_bundler
    require 'rubygems'
    require 'bundler'
    Bundler.require
  end


  def self.defined_methods object
    object.methods - Object.new.methods
  end


  def apf o
    ap o
    false
  end
end
