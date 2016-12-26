#!/usr/bin/ruby

#datos
year1    = ARGV[0]
year2    = year1.to_i + 1
curso    = "curso#{year1}#{year2}"

filename = 'subjects.txt'
content  = `cat #{filename}`
dirnames = content.split("\n")

#comprobaciones
if year1 == nil
	puts "Falta poner year! Ejemplo: 16"
	exit
end

#código
system("mkdir #{curso}")
system("groupadd profesores #{curso}")
dirnames.each do |i|
  puts   "Creando dir #{curso}/#{i}"
  system("mkdir #{curso}/#{i}")
  system("chmod 777 #{curso}/#{i}")
end

