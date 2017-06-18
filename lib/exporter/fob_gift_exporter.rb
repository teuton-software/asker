# encoding: utf-8

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Use to export questions from FOB to gift format
module FOBGiftExporter
  def self.export(fob)
    return false unless fob.process?

    file = Project.instance.outputfile
    file.write "\n"
    file.write '// ' + '=' * 50 + "\n"
    file.write "// FOB #{fob.type}: #{fob.filename} (#{fob.questions.size})\n"
    file.write '// ' + '=' * 50 + "\n"

    fob.questions.each do |question|
      file.write QuestionGiftFormatter.new(question).to_s
    end
    true
  end
end
