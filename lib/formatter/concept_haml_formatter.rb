# encoding: utf-8

require_relative 'table_haml_formatter'

class ConceptHAMLFormatter

  def initialize(concept)
    @concept = concept
  end

  def to_s
    out = ""
    out << "  %concept\n"
    out << "    %names #{@concept.names.join(",")}\n"
    out << "    %tags #{@concept.tags.join(",")}\n"
    @concept.texts.each  { |text| out << "    %def #{text}\n" }
    @concept.images.each { |url|  out << "    %def{ :type => \'image_url\' } #{url}\n" }
    @concept.tables.each { |table| out << TableHAMLFormatter.new(table).to_s }
	  return out
  end

end
