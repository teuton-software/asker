
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
    use_vars_into_template
    debug
    @rows
  end

  def load_info_from(xml)
    @vars = {}
    vars = xml.attributes
    vars.keys.each { |i| @vars[i]=vars[i] }
    @template = ''
    xml.elements.each { |i| @template << i.to_s + "\n" }
  end

  def use_vars_into_template

  end

  def debug
    puts "="*40
    puts @xml.to_s
    puts @vars
    puts @template
    puts "="*40
  end

end
