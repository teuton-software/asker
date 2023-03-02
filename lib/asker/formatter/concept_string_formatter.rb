# frozen_string_literal: true

require "rainbow"
require "terminal-table"

# Define methods to transform Concept into String
module ConceptStringFormatter
  ##
  # Formatter Concept to String
  # @param concept (Concept)
  # @return String
  def self.to_s(concept)
    tt = Terminal::Table.new
    get_tt_rows(concept).each { |row| tt.add_row row }
    tt.to_s
  end

  private_class_method def self.get_tt_rows(concept)
    rows = []
    rows << [Rainbow(concept.id.to_s).bright,
             Rainbow(concept.name(:screen)).green.bright]
            # +          " (lang=#{concept.lang.lang}) "]
    # rows << [Rainbow("Filename").white, concept.filename]
    # rows << [Rainbow("Context").white, concept.context.join(', ').to_s]
    rows << [Rainbow("Tags").white, concept.tags.join(', ').to_s]
    unless concept.reference_to.size.zero?
      rows << [Rainbow("Reference to").white,
             concept.reference_to.join(', ')[0...70].to_s]
    end
    unless concept.referenced_by.size.zero?
      rows << [Rainbow("Referenced by").white,
             concept.referenced_by.join(', ')[0...70].to_s]
    end
    rows << format_texts(concept)
    unless concept.images.size.zero?
      counter = concept.images.size
      # counter1 = 0
      # concept.images.each { |image|  counter1 += 1 if image[:file] == :none }
      # counter2 = concept.images.size - counter1
      rows << [Rainbow("def(file)").white, "#{counter} file/s"]
    end
    rows << format_tables(concept) unless concept.tables.count.zero?
    rows << format_neighbors(concept)
  end

  private_class_method def self.format_texts(concept)
    list = []
    concept.texts.each do |i|
      if i.size < 60
        list << i.to_s
        next
      end
      list << i[0...70].to_s + '...'
    end
    # [Rainbow("def").white, list.join("\n")]
    [Rainbow("def").white, list.size.to_s]
  end

  private_class_method def self.format_tables(concept)
    return [] if concept.tables.count.zero?

    list = concept.tables.map(&:to_s)
    [Rainbow("tables").white, list.join("\n")]
  end

  private_class_method def self.format_neighbors(concept)
    list = concept.neighbors[0..4].map do |i|
      value = Rainbow(i[:value].to_s[0..4]).white
      "#{value} #{i[:concept].name(:screen)}"
    end
    [Rainbow("neighbors").white, list.join("\n")]
  end
end
