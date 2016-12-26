#!/usr/bin/env ruby

require 'pry-byebug'

puts "Generar Markdown v2"
output    = 'output.md'

#Leer configuración
content = `cat config.txt`
lines   = content.split("\n")
config  = []
lines.each do |line|
  item = line.split(":")
  config << [ item[0], item[1], item[2] ]
end

#Leer las imágenes
content = `ls images/*.png`
images = content.split("\n")

cmd ="echo '# Build Markdown' > #{output}"
system(cmd)

config.each do |section|
  nombre = section[0]
  desde  = "images/#{section[1]}"
  hasta  = "images/#{section[2]}"
  puts "nombre #{nombre} (desde #{desde} hasta  #{hasta})"

  images.each do |i|
    if desde<=i and i<=hasta then
      puts " * #{i}"
    end
  end
end
