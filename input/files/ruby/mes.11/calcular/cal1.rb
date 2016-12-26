#!/usr/bin/ruby

# Comprobar que hay 3 argumentos
if ARGV.size != 3
  puts "Usar el programa <cal1> con 3 argumentos"
  puts "  num1 : Es un número entero"
  puts "  op   : Será +, -, x o /"
  puts "  num2 : Es un número entero"
  exit 1
end

# Pasar los 3 primeros argumentos a variables
num1 = ARGV[0].to_i
op   = ARGV[1]
num2 = ARGV[2].to_i

if    op=="+"
  puts num1+num2
elsif op=="-"
  puts num1-num2
elsif op=="x"
  puts num1*num2
elsif op=="/"
  puts num1/num2
end
