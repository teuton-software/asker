# encoding: utf-8

require_relative '../project'
require_relative 'question_gift_formatter'

class ConceptGiftFormatter

  def initialize(concept)
    @concept = concept
  end

  def export
    return if @concept.process==false

    file = Project.instance.outputfile
    file.write "\n"
    file.write "// "+"="*50+"\n"
    file.write "// Concept name: #{@concept.name}\n"
    file.write "// "+"="*50+"\n"

    stages = [ :stage_a, :stage_b, :stage_c, :stage_d, :stage_e ]
    stages.each do |stage|
      @concept.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.new(question).to_s)
      end
   end
  end

end
