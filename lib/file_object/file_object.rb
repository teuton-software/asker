
require_relative 'ruby_code_object'

module FileObject
  def self.factory(filename,type)
    case type
    when :rubycode
      return RubyCodeObject.new(filename)
    end
    nil
  end

  def self.load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end

  def self.clone_array(array)
    out = []
    array.each { |item| out << item.dup }
    out
  end
end
