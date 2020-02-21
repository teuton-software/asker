
require_relative 'packages'

namespace :install do
  desc 'OpenSUSE installation'
  task :opensuse do
    names = ['ruby-devel']
    names.each { |name| system("zypper -y #{name}") }
    install_gems packages, '--no-ri'
    create_symbolic_link
  end

  desc 'Debian installation'
  task :debian do
    names = ['make', 'gcc', 'build-essential', 'ruby-dev']
    names.each { |name| system("apt install -y #{name}") }
    install_gems packages,'--no-ri'
    create_symbolic_link
  end

  desc 'Install gems'
  task :gems do
    install_gems packages
  end

  def install_gems(list, options = '')
    puts "[INFO] Installing Ruby gems (options=#{options})..."
    fails = filter_uninstalled_gems(list)
    fails.each { |name| system("gem install #{name} #{options}") }
  end

  desc 'Install developer gems'
  task :devel do
    puts "[INFO] Installing developer Ruby gems..."
    p = %w[rubocop minitest pry-byebug yard]
    p.each { |name| system("gem install #{name}") }
  end

  def create_symbolic_link
    puts '[INFO] Creating symbolic link into /usr/local/bin'
    basedir = File.dirname(__FILE__)
    system("ln -s #{basedir}/asker /usr/local/bin/asker")
  end
end
