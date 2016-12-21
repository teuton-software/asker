#!/usr/bin/ruby

require_relative 'code_object'

class FileObject

  def initialize(filename,type)
    case type
    when :rubycode
      return RubyCodeObject.new(filename, type)
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
