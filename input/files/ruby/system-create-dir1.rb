#!/usr/bin/ruby

#datos
year     = ARGV[0]
curso    = "curso#{year}"
depto    = ARGV[1]

if depto == "tur"
  dirnames = [ "ingles","fol", "aleman", "protocolo" ]
elsif depto == "inf"
  dirnames = [ "sistemas","ingles","basededatos", "fol" ]
else
  puts "Falta saber el valor de DEPTO!"
  puts "Valores posibles: tur, inf"
  exit
end

#código

system("mkdir #{curso}")

dirnames.each do |i|
  puts   "Creando dir #{curso}/#{i}"
  system("mkdir #{curso}/#{i}")
  system("chmod 777 #{curso}/#{i}")
end

