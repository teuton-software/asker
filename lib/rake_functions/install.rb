
desc 'OpenSUSE installation'
task :opensuse => :gems do
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
