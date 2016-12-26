#!/usr/bin/env ruby

puts "Generar Markdown"

content = `ls *.png`
filenames = content.split("\n")
output    = 'output.md'

cmd ="echo '# Build Markdown' > #{output}"
system(cmd)
filenames.each do |filename|
  cmd ="echo '![#{filename}](./#{filename})' >> #{output}"
  system(cmd)
  cmd ="echo ' ' >> #{output}"
  system(cmd)
end
