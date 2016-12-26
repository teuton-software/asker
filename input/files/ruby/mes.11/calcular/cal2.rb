#!/usr/bin/ruby
require 'pry-byebug'

if ARGV.size != 1
  puts "Usar el programa <cal2> con 1 argumento"
  puts "  filename : Nombre de fichero"
  exit 1
end

filename = ARGV[0]
content = `cat #{filename}`
lines   = content.split("\n")

lines.each do |row|
  binding.pry
  puts "Procesando: #{row}"
  items=row.split(" ")
  
  num1 = items[0].to_i
  op   = items[1]
  num2 = items[2].to_i

  if    op=="+"
    puts num1+num2
  elsif op=="-"
    puts num1-num2
  elsif op=="x"
    puts num1*num2
  elsif op=="/"
    puts num1/num2
  end

end
