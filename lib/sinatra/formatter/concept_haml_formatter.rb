# frozen_string_literal: false

require_relative 'table_haml_formatter'

# Used by: sinatra_front_end < command/editor
class ConceptHAMLFormatter
  def initialize(concept)
    @concept = concept
  end

  def to_s
    add_concept_names_tags + add_def_images_tables
  end

  private

  def add_concept_names_tags
    out = "\n"
    out << "  %concept\n"
    out << "    %names #{@concept.names.join(', ')}\n"
    out << "    %tags #{@concept.tags.join(', ')}\n"
    out
  end

  def add_def_images_tables
    out = ''
    @concept.texts.each  { |text| out << "    %def #{text}\n" }
    @concept.images.each do |url|
      out << "    %def{ :type => \'image_url\' } #{url}\n"
    end
    @concept.tables.each { |table| out << TableHAMLFormatter.new(table).to_s }
    out
  end
end
