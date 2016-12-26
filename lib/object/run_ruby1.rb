#!/usr/bin/ruby

require 'pry-byebug'
require_relative 'data_object'
require_relative '../formatter/question_gift_formatter'

data = DataObject.new('lib/application.rb', :rubycode)
questions = data.make_questions
# data.debug

questions.each do |question|
  puts QuestionGiftFormatter.new(question).to_s
end
