# encoding: utf-8

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Use to export questions from FOB to gift format
module CodeGiftExporter
  def self.export(code)
    return false unless code.process?

    file = Project.instance.outputfile
    file.write "\n"
    file.write '// ' + '=' * 50 + "\n"
    file.write "// FOB #{code.type}: #{code.filename} (#{code.questions.size})\n"
    file.write '// ' + '=' * 50 + "\n"

    code.questions.each do |question|
      file.write QuestionGiftFormatter.new(question).to_s
    end
    true
  end
end
