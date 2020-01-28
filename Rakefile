# frozen_string_literal: true

# File: Rakefile
# Usage: rake

def packages
  p = %w[haml rainbow terminal-table thor inifile]
  p + %w[base64_compatible coderay minitest sinatra yard]
end

require_relative 'lib/asker/rake_functions/install'

# Define tasks
desc 'Default action => check'
task default: :check do
end

desc 'Show Asker Rake help'
task :help do
  system('rake -T')
end

desc 'Update Asker'
task :update do
  puts '[INFO] Updating Asker...'
  system('git pull')
  install_gems packages
end

desc 'Check installation'
task :check do
  fails = filter_uninstalled_gems(packages)
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
  Rake::Task['build'].invoke
end

desc 'Build gem'
task :build do
  puts '[INFO] Building gem...'
  system('rm asker-*.*.*.gem')
  system('gem build asker.gemspec')
  #puts "[ INFO ] Generating documentation..."
  #system('rm -r html/')
  #system('yardoc lib/* -o html')
end

def filter_uninstalled_gems(list)
  cmd = `gem list`.split("\n")
  names = cmd.map { |i| i.split(' ')[0] }
  fails = []
  list.each { |i| fails << i unless names.include?(i) }
  fails
end

def create_symbolic_link
  puts '[INFO] Creating symbolic link into /usr/local/bin'
  basedir = File.dirname(__FILE__)
  system("ln -s #{basedir}/asker /usr/local/bin/asker")
end
