namespace :devel do
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

  desc "Create symbolic link"
  task :launcher do
    puts '==> Creating symbolic link into /usr/local/bin'
    system("ln -s #{Dir.pwd}/asker /usr/local/bin/asker")
  end
end
