# frozen_string_literal: true

require_relative '../formatter/question_gift_formatter'

# Use to export questions from Code to gift format
module CodeGiftExporter
  ##
  # Export an Array of codes to gift format file
  # @param codes (Array)
  def self.export_all(codes, file)
    codes.each { |code| export(code, file) }
  end

  ##
  # Export 1 code to gift format file
  # @param code (Code)
  def self.export(code, file)
    return false unless code.process?

    file.write head(code)
    code.questions.each do |question|
      file.write QuestionGiftFormatter.to_s(question)
    end
    true
  end

  private_class_method def self.head(code)
    s = "\n"
    s += '// ' + '=' * 50 + "\n"
    s += "// Code #{code.type}: #{code.filename} (#{code.questions.size})\n"
    s += '// ' + '=' * 50 + "\n"
    s
  end
end
