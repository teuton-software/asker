
require_relative 'object_factory'

c = ObjectFactory.get('lib/application.rb', :rubycode)
c.make_questions
c.debug
