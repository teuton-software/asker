#!/usr/bin/ruby

require_relative 'demo_loader'

files = ['startrek.sql']
dirbase = File.join('input','files','sql')
type = :sqlcode

obj = DemoLoader.new(dirbase, files, type)
obj.load
obj.show
