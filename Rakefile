require 'fileutils'
include FileUtils

RCLIST = %w(.vimrc .zshrc .gemrc .irbrc)
DIRS = %w(.oh-my-zsh)
REPOS = {
  'https://github.com/robbyrussell/oh-my-zsh.git' =>  '.oh-my-zsh'
}

class String
  def red; colorize(self, "\e[1m\e[31m"); end
  def green; colorize(self, "\e[1m\e[32m"); end
  def dark_green; colorize(self, "\e[32m"); end
  def yellow; colorize(self, "\e[1m\e[33m"); end
  def blue; colorize(self, "\e[1m\e[34m"); end
  def dark_blue; colorize(self, "\e[34m"); end
  def pur; colorize(self, "\e[1m\e[35m"); end
  def colorize(text, color_code)  "#{color_code}#{text}\e[0m" end
end

def go_home path=''
  puts "Going home".green
  cd File.expand_path "~#{path}"
end

desc "Remove existing rc files and directories"
task :implode do
  puts "Removing .rc files and directories!"
  go_home
  begin
    rm_rf DIRS
    RCLIST.each{ |rc| rm rc }
  rescue
    puts "nothing to delete?".yellow
  end
  puts "finished removing".pur
end

desc "Get DotFiles and other dependencies"
task :get do
  puts "Cloning dependiencies".green
  go_home

  REPOS.each do |git_url, directory|
    puts directory.yellow
    rm_rf directory
    STDOUT << `git clone -q #{git_url} #{directory}`
  end
  puts "finished cloning".pur
end

desc "Create symlinks"
task :symlink do
  puts "Creating symlinks to rc files and such".green
  go_home
  puts ".vim".yellow
  begin
    ln_s '.DotFiles', '.vim'
  rescue
  puts "hm".red
  end
  RCLIST.map {|file| [ ".DotFiles/#{file}", file]}.each do |from, to|
    puts to.yellow
    ln_s from, to
  end
  puts "finished symlinking".pur
end

task "Update main repo"
task :update do
  puts "Updating .DotFiles".green
  STDOUT << `git pull -q`

  puts "updated".pur
end

namespace :vim do
  desc "Update vim plugins"
  task :update do
    puts "Updating vim plugins".green
    go_home '/.vim'
    [
      'git submodule init',
      'git submodule update',
      'git submodule foreach git pull -q origin master'
    ].each do |cmd|
      STDOUT << `#{cmd}`
    end

    puts "plugins updated".pur
  end
end

task :setup do
  puts "SETTING UP".red
  ['implode', 'get', 'symlink', 'vim:update'].each do |task|
    Rake::Task[task].invoke
  end
end
