#!/usr/bin/ruby

require_relative 'fob_loader'

files = ['startrek.sql']
dirbase = File.join('input','files','sql')
type = :sqlcode

obj = FOBLoader.new(dirbase, files, type)
obj.load
obj.show
