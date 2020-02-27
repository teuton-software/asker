# frozen_string_literal: true

require_relative 'utils'

namespace :install do
  desc 'Check installation'
  task :check do
    fails = Utils.filter_uninstalled_gems(Utils.packages)
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
    # Rake::Task['build:gem'].invoke
  end

  desc 'Install gems'
  task :gems do
    Utils.install_gems packages
  end

  desc 'OpenSUSE installation'
  task :opensuse do
    names = %w[ruby-devel]
    names.each { |name| system("zypper -y #{name}") }
    Rake::Task['install:gems'].invoke
    Rake::Task['install:devel'].invoke
    Utils.create_symbolic_link
  end

  desc 'Debian installation'
  task :debian do
    names = %w[make gcc build-essential ruby-dev]
    names.each { |name| system("apt install -y #{name}") }
    Rake::Task['install:gems'].invoke
    Rake::Task['install:devel'].invoke
    Utils.create_symbolic_link
  end

  desc 'Install developer gems'
  task :devel do
    puts '[INFO] Installing developer Ruby gems...'
    p = %w[rubocop minitest pry-byebug yard]
    Utils.install_gems p, '--no-ri'
  end
end
