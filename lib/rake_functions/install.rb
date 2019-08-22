# File: Rakefile
# Usage: rake

desc 'OpenSUSE installation'
task :opensuse => :gems do
  install_gems packages
  create_symbolic_link
  puts "[INFO] Run 'asker download' to download sample input files from repo"
end

desc 'Debian installation'
task :debian do
  names = ['make', 'gcc', 'build-essential', 'ruby-dev']
  names.each { |name| system("apt install -y #{name}") }

  install_gems packages
  create_symbolic_link
  puts "[INFO] Run 'asker download' to download sample input files from repo"
end

desc 'Install gems'
task :gems do
  install_gems packages
end

def install_gems(list)
  puts "[INFO] Installing Ruby gems..."
#  system('gem install sinatra -v 1.4.6')
  fails = filter_uninstalled_gems(list)
  fails.each { |name| system("gem install #{name}") }
end
