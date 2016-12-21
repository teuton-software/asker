#!/usr/bin/ruby

class CodeObject

  def initialize(filename)
    @filename = filename
    @lines = load(@filename)
    @output = ''
    @log = []
  end

  def debug
    puts "[INFO] Params:"
    puts "  * filename : #{@filename}"
    puts "  * lines    : #{@lines.size}"
    puts "\n"
    puts "[INFO] Source code:"
    @lines.each_with_index do |line,index|
      puts "[%2d] #{line}"%index
    end
    puts "[INFO] Output:"
    puts @output
  end

  def load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end

  def clone_data
    lines = []
    @lines.each { |line| lines << line.dup }
    lines
  end

  def make_errors
    make_comment_error
    make_string_error
    make_keyword_error
  end

  def make_comment_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?('#')
    end
    error_lines.each do |index|
      lines = clone_data
      lines[index].sub!('#','').strip!
      @output << "make comment error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end

  def make_string_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?("'")
    end
    error_lines.each do |index|
      lines = clone_data
      lines[index].sub!("'",'')
      @output << "make string error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end

  def make_keyword_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?("end")
    end
    error_lines.each do |index|
      lines = clone_data
      lines[index].sub!('end','edn')
      @output << "make keyword error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end

end

#c = CodeObject.new('lib/application.rb')
#c.make_errors
#c.debug
