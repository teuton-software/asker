#!/usr/bin/ruby

require_relative 'object_loader'

files = ['startrek.sql']
dirbase = File.join('input','files','sql')
type = :sqlcode

obj = ObjectLoader.new(dirbase, files, type)
obj.load
obj.show
