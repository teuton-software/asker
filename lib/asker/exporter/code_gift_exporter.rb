# frozen_string_literal: true

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# UNDER DEVELOPMENT
# Use to export questions from Code to gift format
module CodeGiftExporter
  def self.export_all(codes)
    codes.each do |code|
      code.make_questions
      export code
    end
  end

  def self.export(code)
    return false unless code.process?

    file = Project.instance.outputfile
    file.write head(code)

    code.questions.each do |question|
      file.write QuestionGiftFormatter.to_s(question)
    end
    true
  end

  def self.head(code)
    s = "\n"
    s += '// ' + '=' * 50 + "\n"
    s += "// Code #{code.type}: #{code.filename} (#{code.questions.size})\n"
    s += '// ' + '=' * 50 + "\n"
    s
  end
end
