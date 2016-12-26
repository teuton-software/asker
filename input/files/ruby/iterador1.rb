#!/usr/bin/ruby

nombres = [ "David","Jesús","Bruno", "Daniel", "Nieves", "Raúl" ]

nombres.each do |i|

  if i=="Daniel" then
    puts "Bay bye #{i.upcase}!"
  else
    puts "Hola #{i}!"
  end
  
end
