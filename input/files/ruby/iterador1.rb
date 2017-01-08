#!/usr/bin/ruby

nombres = [ "David","Jesús","Bruno", "Daniel", "Nieves", "Raúl" ]

nombres.each do |i|

  if i=="Nieves" then
    puts "Hello #{i.upcase}!"
  else
    puts "Hola #{i}!"
  end
  
end
