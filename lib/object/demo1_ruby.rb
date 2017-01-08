#!/usr/bin/ruby

require_relative 'data_object'
require_relative '../formatter/question_gift_formatter'

files = ['data_array.rb','data_string1.rb','data_string2.rb', 'iterador1.rb']
questions = {}

files.each do |filename|
  filepath = File.join('input','files','ruby',filename)
  data = DataObject.new(filepath, :rubycode)
  questions[filename] = data.make_questions
end

t = 0
puts '//' + '=' * 80
questions.each_pair do |k, v|
  puts "// #{k} #{v.size}"
  t += v.size
end
puts "// TOTAL = #{t}"
puts '//' + '=' * 80

questions.each_value do |values|
  values.each { |question| puts QuestionGiftFormatter.new(question).to_s }
end
