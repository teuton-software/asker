# frozen_string_literal: true

##
# Module Utils with functions used by task/install.rb
module Utils
  def self.packages
    %w[haml inifile colorize pry-byebug rainbow rexml terminal-table thor]
  end

  def self.filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
  end

  def self.install_gems(list)
    puts '[INFO] Installing Ruby gems...'
    fails = filter_uninstalled_gems(list)
    fails.each { |name| system("gem install #{name}") }
  end

  def self.create_symbolic_link
    puts '[INFO] Creating symbolic link into /usr/local/bin'
    system("ln -s #{Dir.pwd}/asker /usr/local/bin/asker")
  end
end
