#File: Rakefile
#Usage: rake

#Define tasks

desc "Installation"
task :default => [:gems] do
  puts "Darts proyect installation has finish!"
end

list=['haml', 'sinatra', 'rainbow', 'terminal-table', 'thor', 'base64_compatible', 'coderay']

desc "Install gems "
task :gems do
  list.each { |name| system("gem install #{name}") }
end

desc "Check installed gems "
task :check do
  cmd=(`gem list`).split("\n")
  names = cmd.map { |i| i.split(" ")[0]}
  fails = []
  list.each { |i| fails << i unless names.include?(i) }

  if fails.size==0
    puts "Check gems OK!"
  else
    puts "Check gems FAILS!: "+fails.join(",")
  end
  system('./tests/all.rb')
  a=`cat tests/all.rb|grep "_test"|wc -l`
  b=`vdir -R tests/ |grep "_test.rb"|wc -l`
  if a.to_i == b.to_i
    puts 'OK: All ruby tests into test/all.rb'
  else
    puts 'FAIL: some ruby tests are not into test/all.rb'
  end
end

desc "Update this project"
task :update do
  system("git pull")
end

desc "Clean output dir"
task :clean do
  system("rm output/*")
end
