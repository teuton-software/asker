
desc 'OpenSUSE installation'
task :install_opensuse do
  names = ['ruby-devel']
  names.each { |name| system("zypper -y #{name}") }

  install_gems packages, '--no-ri'
  create_symbolic_link
end

desc 'Debian installation'
task :install_debian do
  names = ['make', 'gcc', 'build-essential', 'ruby-dev']
  names.each { |name| system("apt install -y #{name}") }

  install_gems packages,'--no-ri'
  create_symbolic_link
end

desc 'Install gems'
task :install_gems do
  install_gems packages
end

def install_gems(list, options = '')
  puts "[INFO] Installing Ruby gems (options=#{options})..."
  fails = filter_uninstalled_gems(list)
  fails.each { |name| system("gem install #{name} #{options}") }
end

desc 'Install developer gems'
task :install_devel do
  puts "[INFO] Installing developer Ruby gems..."
  p = %w[rubocop minitest pry-byebug]
  p.each { |name| system("gem install #{name}") }
end
