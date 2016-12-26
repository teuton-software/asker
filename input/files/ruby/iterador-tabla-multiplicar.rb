#!/usr/bin/ruby

numero = ARGV[0].to_i
lista  = [1,2,3,4,5,6,7,8,9,10]

lista.each do |i|
  puts "#{numero}*#{i} = #{i*numero}"
end
