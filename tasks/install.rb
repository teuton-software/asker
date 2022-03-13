# frozen_string_literal: true

require_relative 'utils'
require_relative '../lib/asker/version'

namespace :install do
  desc 'Check installation'
  task :check do
    puts "[-] asker version => #{Version::VERSION}"
    fails = Utils.filter_uninstalled_gems(Utils.packages)
    if fails.size.zero?
      puts '[+] Gems installed OK!'
    else
      puts '[X] Gems not installed!: ' + fails.join(',')
    end
    testfile = File.join('.', 'tests', 'all.rb')
    a = File.read(testfile).split("\n")
    b = a.select { |i| i.include? '_test' }
    c = Dir.glob(File.join('.', 'tests', '**', '*_test.rb'))

    if b.size == c.size
      puts "[+] All test files included into #{testfile}"
    else
      puts "[X] Some ruby tests are not executed by #{testfile}"
    end
    puts "[-] Running #{testfile}"
    system(testfile)
    # Rake::Task['build:gem'].invoke
  end

  desc 'Install gems'
  task :gems do
    Utils.install_gems Utils.packages
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
    puts '[-] Installing developer Ruby gems...'
    p = %w[rubocop minitest pry-byebug yard]
    Utils.install_gems p
  end
end
