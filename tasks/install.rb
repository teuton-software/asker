
namespace :install do
  def packages
    p = %w[haml rainbow terminal-table thor inifile]
  end

  desc 'Check installation'
  task :check do
    fails = filter_uninstalled_gems(packages)
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
    Rake::Task['build:gem'].invoke
  end

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

  def filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
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
