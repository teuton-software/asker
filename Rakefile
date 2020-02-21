# frozen_string_literal: true

# File: Rakefile
# Usage: rake

require_relative 'tasks/check'
require_relative 'tasks/install'

# Define tasks
desc 'Default action => install:check'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Show rake help'
task :help do
  system('rake -T')
end

desc 'Build gem'
task :build do
  puts '[INFO] Building gem...'
  system('rm asker-*.*.*.gem')
  system('gem build asker.gemspec')
end

desc 'Generate docs'
task :docs do
  puts '[ INFO ] Generating documentation...'
  system('rm -r html/')
  system('yardoc lib/* -o html')
end
