#!/usr/bin/ruby

class CodeObject

  def initialize(filename)
    @filename = filename
  end

  def debug
    @lines.each_with_index do |line,index|
      puts "[%2d] #{line}"%index
    end
  end

  def load(filename=@filename)
    return if filename.nil?
    content = File.read(filename)
    @lines = content.split("\n")
  end
end

c = CodeObject.new('lib/application.rb')
c.load
c.debug
