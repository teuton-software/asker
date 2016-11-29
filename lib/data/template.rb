
require 'rexml/document'
require_relative 'row'

class Template
  attr_reader :rows

  def initialize( table, index, xml )
    @table   = table
    @index   = index
    @rows    = []
    @xml     = xml
    load_info_from(xml)
    @output = use_vars_into_template
    debug
    @rows
  end

  def load_info_from(xml)
    @vars = {}
    vars = xml.attributes
    vars.keys.each { |i| @vars[i]=vars[i].split(',') }
    @template = ''
    xml.elements.each { |i| @template << i.to_s + "\n" }
  end

  def use_vars_into_template
    output = ''
    return if @vars.size.zero?
    max = @vars.first[1].size
    (1..max).each do |index|
      @vars.each_pair { |k,v| output += @template.dup.gsub!(k,v[index-1]) }
    end
    output
  end

  def debug
    puts "="*40
    puts @output
    puts "="*40
  end

end
