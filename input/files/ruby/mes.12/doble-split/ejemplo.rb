#!/usr/bin/ruby

content = `cat #{ARGV[0]}`
lines = content.split("\n")

lines.each do |line|
  items = line.split(":")
  dirname = items[0]
  perm = items[1]

  puts "mkdir #{dirname}"
  puts "chmod #{perm}"
end

