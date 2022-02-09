# frozen_string_literal: true

# File: Rakefile
# Usage: rake

require_relative 'tasks/install'
require_relative 'tasks/build'
require_relative 'tasks/push'

# Define tasks
desc 'Default action => check & build'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Show rake help'
task :help do
  system('rake -T')
end

desc 'Clean output folder'
task :clean do
  system('rm output/*')
end
