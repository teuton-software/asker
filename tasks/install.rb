
require_relative 'packages'

namespace :install do
  desc 'Install gems'
  task :gems do
    install_gems packages
  end

  desc 'OpenSUSE installation'
  task :opensuse do
    names = ['ruby-devel']
    names.each { |name| system("zypper -y #{name}") }
    Rake::Task['install:gems'].invoke
    Rake::Task['install:devel'].invoke
    create_symbolic_link
  end

  desc 'Debian installation'
  task :debian do
    names = ['make', 'gcc', 'build-essential', 'ruby-dev']
    names.each { |name| system("apt install -y #{name}") }
    Rake::Task['install:gems'].invoke
    Rake::Task['install:devel'].invoke
    create_symbolic_link
  end

  desc 'Install developer gems'
  task :devel do
    puts "[INFO] Installing developer Ruby gems..."
    p = %w[rubocop minitest pry-byebug yard]
    #p + %w[sinatra base64_compatible coderay ]
    install_gems p,'--no-ri'
  end

  def install_gems(list)
    puts "[INFO] Installing Ruby gems..."
    fails = filter_uninstalled_gems(list)
    fails.each { |name| system("gem install #{name}") }
  end

  def create_symbolic_link
    puts '[INFO] Creating symbolic link into /usr/local/bin'
    system("ln -s #{Dir.pwd}/asker /usr/local/bin/asker")
  end
end
