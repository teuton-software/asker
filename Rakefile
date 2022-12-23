# File: Rakefile

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"
# task default: %i[test standard]
task default: %i[test]

require_relative "tasks/devel"
require_relative "tasks/docker"

desc "Default: run tests"
task :default do
  Rake::Task["test"].invoke
end

desc "Show rake help"
task :help do
  system('rake -T')
end

desc "Delete output files"
task :clean do
  system("rm output/*")
end
