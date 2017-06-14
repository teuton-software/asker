#!/usr/bin/ruby

require_relative 'fob_loader'

files = ['Vagrantfile1', 'Vagrantfile2', 'Vagrantfile3', 'Vagrantfile4']
dirbase = File.join('input','files','vagrant')
type = :rubycode

obj = FOBLoader.new(dirbase, files, type)
obj.load
obj.show
