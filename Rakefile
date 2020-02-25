# frozen_string_literal: true

# File: Rakefile
# Usage: rake

require_relative 'tasks/install'

# Define tasks
desc 'Default action => check & build'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Show rake help'
task :help do
  system('rake -T')
end

namespace :build do
  desc 'Build all (gem and docs)'
  task :all do
    Rake::Task['build:gem'].invoke
    Rake::Task['build:docs'].invoke
  end

  desc 'Build gem'
  task :gem do
    puts '[INFO] Building gem...'
    system('rm theory-asker-*.*.*.gem')
    system('gem build theory-asker.gemspec')
  end

  desc 'Build docs'
  task :docs do
    puts '[ INFO ] Generating documentation...'
    system('rm -r html/')
    system('yardoc lib/* -o html')
  end
end
