#!/usr/bin/ruby

require_relative 'demo_loader'

#files = [,'data_string1.rb',, 'iterador1.rb']
files = ['data_array.rb', 'data_string1.rb', 'data_string2.rb']
dirbase = File.join('input','files','ruby')
type = :ruby

obj = DemoLoader.new(dirbase, files, type)
obj.load
obj.show
