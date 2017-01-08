#!/usr/bin/ruby

nombres = ['obi-wan', 'yoda', 'darth Vader']

nombres.each do |i|

  if i[0,5]=='darth'
    puts "Bye #{i.upcase}!"
  else
    puts "Hello #{i.capitalize}!"
  end
  
end
