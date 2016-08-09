#File: Rakefile
#Usage: rake

#Define tasks

desc "Installation"
task :default => [:gems] do
  puts "Darts proyect installation has finish!"
end

list=['haml', 'sinatra', 'rainbow', 'terminal-table', 'base64_compatible', 'coderay']

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
    puts "Check OK!"
  else
    puts "Check FAILS!: "+fails.join(",")
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

desc "Open Web GUI"
task :web do
  require_relative 'sinatra_front_end'
  SinatraFrontEnd.run!
end
