# encoding: utf-8

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Use to export data from ConceptIA to gift format 
class ConceptAIGiftExporter

  def initialize(concept_ai)
    @concept_ai = concept_ai
  end

  def export
    return if @concept_ai.process==false

    file = Project.instance.outputfile
    file.write "\n"
    file.write "// "+"="*50+"\n"
    file.write "// Concept name: #{@concept_ai.name}\n"
    file.write "// "+"="*50+"\n"

    stages = Project.instance.stages
    stages.each_key do |stage|
      @concept_ai.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.new(question).to_s)
      end
   end
  end

end
