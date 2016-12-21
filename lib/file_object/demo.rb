
require_relative 'file_object'

c = FileObject.factory('lib/application.rb', :rubycode)
c.make_errors
c.debug
