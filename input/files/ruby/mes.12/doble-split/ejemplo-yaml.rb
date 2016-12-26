#!/usr/bin/ruby

require 'yaml'

#datos = YAML::load(File.new('mytest.yaml').read)
content = `cat mytest.yaml`
datos = YAML::load(content)

puts datos.to_s

