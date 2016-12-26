#!/usr/bin/ruby

require 'inifile'

myini = IniFile.load('mytest.ini')

myini.each_section do |section|
  puts "Sección #{section}"
  puts " * var1 es #{myini[section]['var1']}"
  puts " * var2 es #{myini[section]['var2']}"
end

