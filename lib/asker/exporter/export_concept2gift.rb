# frozen_string_literal: true

require_relative "../formatter/question_gift_formatter"

class ExportConcept2Gift
  ##
  # Export an array of ConceptAI objects from Project into GIFT outpufile
  # @param concepts_ai (Array)
  # @param file (File)
  def call(concepts_ai, file)
    concepts_ai.each { |concept_ai| export(concept_ai, file) }
  end

  private

  ##
  # Export 1 concept_ai from project
  # @param concept_ai (ConceptAI)
  # @param file (File)
  def export(concept_ai, file)
    return unless concept_ai.concept.process?

    file.write head(concept_ai.concept.name)
    Application.instance.config["questions"]["stages"].each do |stage|
      concept_ai.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.to_s(question))
      end
    end
  end

  ##
  # Convert Concept name into gift format head
  # @param name (String)
  # @return String
  def head(name)
    s = "\n"
    s += "// " + "=" * 50 + "\n"
    s += "// Concept name: #{name}\n"
    s += "// " + "=" * 50 + "\n"
    s
  end
end
