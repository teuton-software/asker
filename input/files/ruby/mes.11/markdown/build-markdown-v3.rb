#!/usr/bin/env ruby

require 'pry-byebug'

puts "Generar Markdown v3"
output    = 'output.md'

#Leer configuración
content = `cat config.txt`
lines   = content.split("\n")
config  = []
lines.each do |line|
  item = line.split(":")
  config << [ item[0], item[1], item[2] ]
end

config.each do |section|
  nombre = section[0]
  desde  = section[1]
  puts "nombre #{nombre} (desde #{desde})"

  #Leer las imágenes
  content = `ls images/#{desde}*.png`
  images = content.split("\n")

  images.each do |i|
      puts " * #{i}"
  end
end
