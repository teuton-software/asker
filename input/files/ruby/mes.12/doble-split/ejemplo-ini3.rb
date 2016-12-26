#!/usr/bin/ruby

require 'inifile'

data=`cat mytest.ini`
myini = IniFile.new(:content => data)

myini.each_section do |section|
  puts "Sección #{section}"
  puts " * var1 es #{myini[section]['var1']}"
  puts " * var2 es #{myini[section]['var2']}"
end
