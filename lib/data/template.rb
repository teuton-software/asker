
require 'rexml/document'
require_relative 'row'

class Template
  attr_reader :rows

  def initialize( table, index, xml )
    @table   = table
    @index   = index
    @rows    = []
    vars, template = load_info_from(xml)
    data_string = apply_vars_to_template(vars, template)
    @rows = read_rows_from(data_string)
  end

  def load_info_from(xml)
    vars = {}
    template = ''
    v = xml.attributes
    v.keys.each { |i| vars[i]=v[i].split(',') }
    xml.elements.each { |i| template << i.to_s + "\n" }
    return vars, template
  end

  def apply_vars_to_template(vars,template)
    output = ''
    return if vars.size.zero?
    max = vars.first[1].size
    (1..max).each do |index|
      vars.each_pair { |k,v| output += template.dup.gsub!(k,v[index-1]) }
    end
    output
  end

  def read_rows_from(data_string)
    puts data_string
    data = "<template>\n#{data_string}\n</template>"
    xml = REXML::Document.new(data)
    xml.elements.each do |i|
      if i.name == 'row'
        puts "OK"+i.to_s
      end
    end
    []
  end
end
