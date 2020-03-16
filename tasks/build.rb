# frozen_string_literal: true

namespace :build do
  desc 'Build all (gem and docs)'
  task :all do
    Rake::Task['build:gem'].invoke
    Rake::Task['build:docs'].invoke
  end

  desc 'Build gem'
  task :gem do
    puts '[INFO] Building gem...'
    system('rm asker-tool-*.*.*.gem')
    system('gem build asker-tool.gemspec')
  end

  desc 'Build docs'
  task :docs do
    puts '[INFO] Generating documentation...'
    system('rm -r html/')
    system('yardoc lib/* -o html ' \
       '--files LICENSE')
  end
end
