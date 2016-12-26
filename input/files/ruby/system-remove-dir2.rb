#!/usr/bin/ruby

year1    = ARGV[0]

if year1 == nil
	puts "Falta poner year! Ejemplo: 16"
	exit
end

year2    = year1.to_i + 1
curso    = "curso#{year1}#{year2}"

system("rm -r #{curso}")
