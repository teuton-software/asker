# frozen_string_literal: true

# File: Rakefile
# Usage: rake
require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"

require_relative 'tasks/install'
#require_relative 'tasks/build'
#require_relative 'tasks/push'

Bundler::GemHelper.install_tasks

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
