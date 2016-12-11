
require 'rexml/document'
require_relative 'row'

class Template
  attr_reader :datarows

  def initialize( table, index, xml )
    vars, template = load_info_from(xml)
    data_string = apply_vars_to_template(vars, template)
    @datarows = read_rows_from(table, index, data_string)
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
      t = template.dup
      vars.each_pair { |k,v| t.gsub!(k,v[index-1]) }
      output += t
    end
    output
  end

  def read_rows_from(table, index, data_string)
    datarows = []
    data = "<template>\n#{data_string}\n</template>"
    xml = REXML::Document.new(data)
    xml.root.elements.each do |i|
      if i.name == 'row'
        datarows << Row.new(table, index, i)
        index += 1
      end
    end
    datarows
  end
end
