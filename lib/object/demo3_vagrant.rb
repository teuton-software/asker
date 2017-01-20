#!/usr/bin/ruby

require_relative 'object_loader'

files = ['Vagrantfile1', 'Vagrantfile2', 'Vagrantfile3', 'Vagrantfile4']
dirbase = File.join('input','files','vagrant')
type = :rubycode

obj = ObjectLoader.new(dirbase, files, type)
obj.load
obj.show
