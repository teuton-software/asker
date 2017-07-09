#!/usr/bin/ruby

require_relative 'demo_loader'

files = ['startrek.sql']
dirbase = File.join('input','es','base-de-datos', 'files')
type = :sqlcode

obj = DemoLoader.new(dirbase, files, type)
obj.load
obj.show
