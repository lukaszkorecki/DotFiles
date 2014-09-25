#!/usr/bin/ruby
require 'rubygems'


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


  def self.saveyaml(filename=nil, obj=nil)
    if filename.nil? || obj.nil?
      puts "saveyaml filename obj"
    else
      require 'yaml'
      File.open(File.expand_path(filename), 'w') { |f| f.write obj.to_yaml }
    end
  end

  def self.timeit
    t = Time.now
    yield
    puts Time.now - t
  end

  def self.ar_log_on
    ActiveRecord::Base.logger = Logger.new STDOUT
  end

  def self.ar_log_off
    ActiveRecord::Base.logger = Logger.new nil
  end
end
