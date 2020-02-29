# encoding: utf-8

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Export ConceptIA data to gift to outputfile
module ConceptAIGiftExporter
  ##
  # Export list of ConceptAI into outpufile
  def self.export_all(concepts_ai, project)
    concepts_ai.each { |concept_ai| export(concept_ai, project) }
  end

  def self.export(concept_ai, project)
    return unless concept_ai.process?

    file = project.get(:outputfile)
    file.write head(concept_ai.name)
    project.stages.each_key do |stage|
      concept_ai.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.to_s(question))
      end
    end
  end

  def self.head(name)
    s = "\n"
    s += '// ' + '=' * 50 + "\n"
    s += "// Concept name: #{name}\n"
    s += '// ' + '=' * 50 + "\n"
    s
  end
end
