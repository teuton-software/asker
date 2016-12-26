#!/usr/bin/ruby

content = `cat #{ARGV[0]}`
lines = content.split("\n")

vector = []

lines.each do |line|
  items = line.split(":")
  
  dirname = items[0]
  perm = items[1]

  vector << { :dirname => dirname, :perm => perm }
end

puts vector.to_s
