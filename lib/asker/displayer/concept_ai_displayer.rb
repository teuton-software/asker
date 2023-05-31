# frozen_string_literal: true

require "erb"
require "rainbow"
require "terminal-table"
require_relative "../application"
require_relative "../logger"

class ConceptAIDisplayer
  ##
  # Display ConceptAI stat on screen
  # @param concepts_ai (Array)
  def self.show(concepts_ai)
    stages = Application.instance.config["questions"]["stages"]
    # Create table HEAD
    screen_table = Terminal::Table.new do |st|
      title = %w[Concept Questions Entries xFactor]
      %w[d b f i s t].each do |i|
        if stages.include? i.to_sym
          title << i
          next
        end
        title << Rainbow(i).yellow.bright
      end
      st << title
      st << :separator
    end
    # Create table BODY
    total = {}
    total[:q] = total[:e] = total[:c] = 0
    total[:sd] = total[:sb] = total[:sf] = 0
    total[:si] = total[:ss] = total[:st] = 0

    concepts_ai.each do |concept_ai|
      next unless concept_ai.concept.process?

      e = concept_ai.concept.texts.size
      e += concept_ai.concept.images.size
      concept_ai.concept.tables.each { |t| e += t.fields.size * t.rows.size }

      sd = sb = sf = 0
      si = ss = st = 0
      sd = concept_ai.questions[:d].size if stages.include? :d
      sb = concept_ai.questions[:b].size if stages.include? :b
      sf = concept_ai.questions[:f].size if stages.include? :f
      si = concept_ai.questions[:i].size if stages.include? :i
      ss = concept_ai.questions[:s].size if stages.include? :s
      st = concept_ai.questions[:t].size if stages.include? :t
      t = sd + sb + sf + si + ss + st

      factor = "Unkown"
      factor = (t.to_f / e).round(2).to_s unless e.zero?
      screen_table.add_row [Rainbow(concept_ai.concept.name(:screen)).green.bright,
                            t, e, factor, sd, sb, sf, si, ss, st]

      total[:q] += t
      total[:e] += e
      total[:c] += 1
      total[:sd] += sd
      total[:sb] += sb
      total[:sf] += sf
      total[:si] += si
      total[:ss] += ss
      total[:st] += st
    end
    return if total[:c].zero? # No concepts to be process?

    # Add row with excluded questions
    export_excluded_questions(screen_table, concepts_ai)

    # Create table TAIL
    screen_table.add_separator
    screen_table.add_row [Rainbow("#{total[:c]} concept/s").bright,
                          Rainbow(total[:q].to_s).bright,
                          Rainbow(total[:e].to_s).bright,
                          Rainbow((total[:q].to_f / total[:e]).round(2)).bright,
                          total[:sd], total[:sb], total[:sf],
                          total[:si], total[:ss], total[:st]]
    export_notes
    Logger.verboseln "#{screen_table}\n"
  end

  private_class_method def self.export_excluded_questions(screen_table, concepts_ai)
    # Create table BODY
    total = {}
    total[:q] = total[:c] = 0
    total[:sd] = total[:sb] = total[:sf] = 0
    total[:si] = total[:ss] = total[:st] = 0

    concepts_ai.each do |concept_ai|
      next unless concept_ai.concept.process?

      sd = concept_ai.excluded_questions[:d].size
      sb = concept_ai.excluded_questions[:b].size
      sf = concept_ai.excluded_questions[:f].size
      si = concept_ai.excluded_questions[:i].size
      ss = concept_ai.excluded_questions[:s].size
      st = concept_ai.excluded_questions[:t].size
      t = sd + sb + sf + si + ss + st

      total[:q] += t
      total[:c] += 1
      total[:sd] += sd
      total[:sb] += sb
      total[:sf] += sf
      total[:si] += si
      total[:ss] += ss
      total[:st] += st
    end
    screen_table.add_row [Rainbow('Excluded questions').yellow.bright,
                          total[:q], '-', '-',
                          total[:sd], total[:sb],
                          total[:sf], total[:si],
                          total[:ss], total[:st]]
  end

  private_class_method def self.export_notes
    exclude_questions = Application.instance.config['questions']['exclude'].to_s
    renderer = ERB.new(File.read(File.join(File.dirname(__FILE__), 'concept_ai_displayer.erb')))
    Logger.verboseln Rainbow(renderer.result(binding)).white
  end
end
