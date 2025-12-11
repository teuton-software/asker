namespace :devel do
  desc "OpenSUSE installation"
  task :opensuse do
    names = %w[ruby-devel]
    names.each { |name| system("zypper -y #{name}") }
  end

  desc "Debian installation"
  task :debian do
    names = %w[make gcc build-essential ruby-dev]
    names.each { |name| system("apt install -y #{name}") }
  end

  desc "Create /usr/local/bin/asker"
  task :launcher do
    launcherpath = "/usr/local/bin/asker"
    if File.exist?(launcherpath)
      warn "File exist! (#{launcherpath})"
      exit 1
    end

    rubypath = `rbenv which ruby`.strip
    commandpath = File.join(Dir.pwd, "asker")

    puts "# Created with: 'rake devel:launcher'"
    puts "# - Copy this content into: #{launcherpath}"
    puts "# - Then: chmod +x #{launcherpath}"
    puts "RUBYPATH=#{rubypath}"
    puts "COMMANDPATH=#{commandpath}"
    puts "$RUBYPATH $COMMANDPATH $@"
  end
end
