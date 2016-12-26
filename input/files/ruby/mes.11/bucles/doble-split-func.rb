#!/usr/bin/ruby

filename = ARGV[0]

content = `cat #{filename}`
lines = content.split("\n")

lines.each do |row|
  puts " => #{row}"
  items = row.split(':')

  puts " * #{items[0]}"
  puts " * #{items[1]}"
  puts " * #{items[2]}"
end
