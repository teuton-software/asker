require_relative "../lib/asker/version"

namespace :docker do
  desc "Build docker image"
  task :build do
    image = "dvarrui/asker"
    puts "==> Creating docker image <#{image}>"
    system("docker build -t #{image} install/docker")
    system("docker tag #{image}:latest #{image}:#{Asker::VERSION}")
  end

  desc "Run docker container"
  task :run do
    name = "asker"
    image = "dvarrui/asker"
    volume = Dir.pwd

    system("docker run -it --rm --name #{name} -v #{volume}:/opt -w /opt #{image}")
  end

  desc "Publish docker image"
  task :push do
    image = "dvarrui/asker"
    system("docker push #{image}:latest")
    system("docker push #{image}:#{Asker::VERSION}")
  end
end
