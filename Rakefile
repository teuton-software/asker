#File: Rakefile
#Usage: rake

#Define tasks

desc "Installation"
task :default => [:gems] do
  puts "Darts proyect installation has finish!"
end

list=['haml', 'sinatra', 'rainbow', 'terminal-table', 'base64_compatible']

desc "Install gems "
task :gems do
  list.each { |name| system("gem install #{name}") }
  system("zypper in rubygem-rspec") #opensuse13.2
end

desc "Check installed gems "
task :check do
  cmd=(`gem list`).split("\n")
  names = cmd.map { |i| i.split(" ")[0]}
  fails = []
  list.each do |i|
    fails << i if not names.include?(i)
  end

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

desc "Open GUI"
task :gui do
  e = ENV.to_h
  system("#{e["HOME"]}/.shoes/federales/shoes lib/gui/prueba1.rb&")
end
