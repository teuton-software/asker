#!/usr/bin/ruby

require_relative 'demo_loader'

files = ['Vagrantfile1', 'Vagrantfile2', 'Vagrantfile3', 'Vagrantfile4']
dirbase = File.join('input','files','vagrant')
type = :rubycode

obj = DemoLoader.new(dirbase, files, type)
obj.load
obj.show