#!/usr/bin/ruby
require 'rubygems'
require 'awesome_print'
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
end
