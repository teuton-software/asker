# encoding: utf-8

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Export ConceptIA data to gift to outputfile
module ConceptAIGiftExporter
  ##
  # Export an array of ConceptAI objects from Project into GIFT outpufile
  # @param concepts_ai (Array)
  # @param project (Project)
  def self.export_all(concepts_ai, project)
    concepts_ai.each { |concept_ai| export(concept_ai, project) }
  end

  ##
  # Export 1 concept_ai from project
  # @param concept_ai (ConceptAI)
  # @param project (Project)
  private_class_method def self.export(concept_ai, project)
    return unless concept_ai.process?

    file = project.get(:outputfile)
    file.write head(concept_ai.name)
    Application.instance.config['questions']['stages'].each do |stage|
      concept_ai.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.to_s(question))
      end
    end
  end

  ##
  # Convert Concept name into gift format head
  # @param name (String)
  # @return String
  private_class_mmethod def self.head(name)
    s = "\n"
    s += '// ' + '=' * 50 + "\n"
    s += "// Concept name: #{name}\n"
    s += '// ' + '=' * 50 + "\n"
    s
  end
end
