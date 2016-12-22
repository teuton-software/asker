
require_relative 'data_object'

c = DataObject.new('lib/application.rb', :rubycode)
c.make_questions
c.debug
