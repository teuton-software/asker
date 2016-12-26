#!/usr/bin/ruby

require 'rainbow'

content = `cat #{ARGV[0]}`
lines = content.split("\n")

usuario = ""
cargo = ""
monedas = ""

lines.each do |i|
  if i.size>0
    items = i.split("=")
    param = items[0].strip
    valor = items[1].strip

    if param == "usuario"
      usuario = valor 
    end
    if param == "cargo"
      cargo = valor 
    end
    if param == "monedas"
      monedas = valor 
    end
  end
end

puts "---------------"
puts "Usuario = "+Rainbow(usuario).green.bright
puts "Cargo   = "+Rainbow(cargo).green
puts "Monedas = "+Rainbow(monedas).green

