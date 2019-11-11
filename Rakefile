# frozen_string_literal: true

# File: Rakefile
# Usage: rake

def packages
  p = %w[haml rainbow terminal-table thor inifile]
  p + %w[base64_compatible coderay minitest sinatra]
end

require_relative 'lib/asker/rake_functions/check'
require_relative 'lib/asker/rake_functions/install'

# Define tasks
desc 'Default action => check'
task default: :check do
end

desc 'Show Asker Rake help'
task :help do
  system('rake -T')
end

desc 'Build gem'
task :build do
  puts '[INFO] Building gem...'
  system('gem build asker.gemspec')
end

desc 'Update Asker'
task :update do
  puts '[INFO] Updating Asker...'
  system('git pull')
  install_gems packages
end

def create_symbolic_link
  puts '[INFO] Creating symbolic link into /usr/local/bin'
  basedir = File.dirname(__FILE__)
  system("ln -s #{basedir}/asker /usr/local/bin/asker")
end
