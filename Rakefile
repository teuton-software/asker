# File: Rakefile
# Usage: rake

require 'fileutils'
require_relative 'lib/application'
require_relative 'lib/project'

# Define tasks

desc 'Default'
task default: :check do
end

list = ['haml', 'sinatra', 'rainbow', 'terminal-table', 'thor']
list << %w(base64_compatible coderay minitest pry pry-byebug inifile)
list.flatten!

desc 'Install gems'
task :gems do
  install_gems list
end

desc 'Check installation'
task :check do
  puts "[INFO] Version #{Application.version}"
  fails = filter_uninstalled_gems(list)

  if fails.size.zero?
    puts '[ OK ] Gems installed OK!'
  else
    puts '[FAIL] Gems not installed!: ' + fails.join(',')
  end

  testfile = File.join('.', 'tests', 'all.rb')
  a = File.read(testfile).split("\n")
  b = a.select { |i| i.include? '_test' }

  d = File.join('.', 'tests', '**', '*_test.rb')
  e = Dir.glob(d)

  if b.size == e.size
    puts "[ OK ] All ruby tests executed by #{testfile}"
  else
    puts "[FAIL] Some ruby tests are not executed by #{testfile}"
  end

  puts "[INFO] Running #{testfile}"
  system(testfile)
end

desc 'Update this project'
task :update do
  system('git pull')
  install_gems list
end

desc 'Clean output dir'
task :clean do
  dir = Project.instance.get(:outputdir)
  FileUtils.rm_rf(Dir.glob(File.join('.', dir, '*')))
end

def install_gems(list)
  system('gem install sinatra -v 1.4.6')
  fails = filter_uninstalled_gems(list)
  fails.each { |name| system("gem install #{name}") }
end

def filter_uninstalled_gems(list)
  cmd = `gem list`.split("\n")
  names = cmd.map { |i| i.split(' ')[0] }
  fails = []
  list.each { |i| fails << i unless names.include?(i) }
  fails
end
