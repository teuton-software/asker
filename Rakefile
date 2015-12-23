#File: Rakefile
#Usage: rake

#Define tasks

desc "Install gems "
task :gems do
	system("gem install haml")
	system("gem install rspec")
end

desc "Update this project"
task :update do
	system("git pull")
end

desc "Clean output dir"
task :clean do
	system("rm output/*")
end
