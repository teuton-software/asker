#!/usr/bin/ruby

require_relative 'demo_loader'

#files = [,'data_string1.rb',, 'iterador1.rb']
files = ['string.py', 'array.py', 'iterador.py']
dirbase = File.join('input', 'es', 'imw', 'files')
type = :python

obj = DemoLoader.new(dirbase, files, type)
obj.load
obj.show
