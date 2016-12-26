#!/usr/bin/ruby

require 'inifile'

data=<<EOF
[section1]
; some comment on section1
var1 = foo
var2 = doodle
var3 = multiline values \
are also possible

[section2]
# another comment
var1 = baz
var2 = shoodle
EOF

myini = IniFile.new(:content => data)

myini.each_section do |section|
  puts "Sección #{section}"
  puts " * var1 es #{myini[section]['var1']}"
  puts " * var2 es #{myini[section]['var2']}"
end
