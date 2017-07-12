# encoding: utf-8

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Use to export data from ConceptIA to gift format
module ConceptAIGiftExporter
  def self.export(concept_ai)
    @concept_ai = concept_ai
    return unless @concept_ai.process?

    file = Project.instance.outputfile
    file.write head(concept_ai)

    stages = Project.instance.stages
    stages.each_key do |stage|
      @concept_ai.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.to_s(question))
      end
    end
  end

  def self.head(concept_ai)
    s = "\n"
    s += '// ' + '=' * 50 + "\n"
    s += "// Concept name: #{concept_ai.name}\n"
    s += '// ' + '=' * 50 + "\n"
    s
  end
end
