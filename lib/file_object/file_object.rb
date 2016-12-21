
require_relative 'ruby_code_object'

module FileObject
  def self.factory(filename,type)
    case type
    when :rubycode
      return RubyCodeObject.new(filename)
    end
    nil
  end
end
