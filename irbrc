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


  def self.saveyaml(filename, obj)
    require 'yaml'
    File.open(filename, 'w') { |f| f.write obj.to_yaml }
  end

  # adopted from https://gist.github.com/jimweirich/4950443#file-source_for-rb
  # My take on Mike's source_for method.
  # (see http://pragmaticstudio.com/blog/2013/2/13/view-source-ruby-methods)
  #
  # (1) I named it 'src' rather than source_for (ok, I'm a lazy typer).
  # (2) The edit function was broken out as a separate function.
  # (3) The edit function is for emacs
  # (4) If the method is not defined on the object, and the object
  #     is a class, then see if it is an instance method on the class.
  #
  # The fourth point allows my to say:
  #
  #      src(Person, :update)
  # or   src(Person.new, :update)
  #
  def self.edit(file, line)
    `tmux split-window -h -p 50 'vim +#{line} #{file}'`
  end

  def self.src(object=nil, method=nil)
    puts "src Object, :method" if object.nil? or method.nil?
    if object.respond_to?(method)
      meth = object.method(method)
    elsif object.is_a?(Class)
      meth = object.instance_method(method)
    end
    location = meth.source_location
    edit(*location) if location
    location
  rescue NameError => ex
    STDERR << "couldnt edit becasue #{ex}"
    nil
  end

  def self.die!
    `kill -9 #{Process.pid}`
  end

  def self.grab_exception
    e = nil
    begin
      yield
    rescue => error
      e = error
    end
    e

  end
end
