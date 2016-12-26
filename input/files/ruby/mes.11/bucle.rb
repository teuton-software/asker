#!/usr/bin/ruby

a = [11,12,13,14]

a.each do |i|
  puts "B1 Item #{i}"
  end

a.each { |i|
  puts "B2 Item #{i}"
  }

i=0
while i<a.size
  puts "B3 Item #{a[i]}"
  i = i+1
  end
