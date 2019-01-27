# File: Rakefile
# Usage: rake

require 'fileutils'
require_relative 'lib/application'
require_relative 'lib/project'

# Define tasks
desc 'Default action => check'
task :default => :check do
end

desc 'Show Asker Rake help'
task :help do
  system("rake -T")
end

packages = ['haml', 'rainbow', 'terminal-table', 'thor']
packages += ['base64_compatible', 'coderay', 'minitest', 'inifile']
packages += ['pry', 'pry-byebug', 'sinatra' ]

desc 'OpenSUSE installation'
task :opensuse => :gems do
  install_gems packages
  chown_asker_files
  create_symbolic_link
end

desc 'Debian installation'
task :debian do
  names = ['make', 'gcc', 'build-essential', 'ruby-dev']
  names.each { |name| system("apt install -y #{name}") }

  install_gems packages
  chown_asker_files
  create_symbolic_link
end

desc 'Install gems'
task :gems do
  install_gems packages
end

desc 'Check installation'
task :check do
  puts "[INFO] Version #{Application.version}"
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
  system("ruby asker version")
end

desc 'Update Asker'
task :update do
  puts "[INFO] Updating Asker..."
  system('git pull')
  install_gems packages
end

desc 'Clean output directory'
task :clean do
  puts "[INFO] Cleaing output directory..."
  dir = Project.instance.get(:outputdir)
  FileUtils.rm_rf(Dir.glob(File.join('.', dir, '*')))
end

def install_gems(list)
  puts "[INFO] Installing Ruby gems..."
#  system('gem install sinatra -v 1.4.6')
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

def chown_asker_files
  user = `who`.split(' ')[0]
  system("chown -R #{user} ../asker")
end

def create_symbolic_link
  puts "[INFO] Creating symbolic link into /usr/local/bin"
  basedir = File.dirname(__FILE__)
  system("ln -s #{basedir}/asker /usr/local/bin/asker")
end
