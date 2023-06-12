# frozen_string_literal: false

require "erb"
require_relative "../application"

# Transform Questions into Gift format
class QuestionMoodleFormatter
  ##
  # Convert question object into gift formatted string
  # @param question (Question)
  # @return String
  def self.to_s(question)
    case question.type
    when :choice
      fractions = Application.instance.config["questions"]["fractions"]
      penalties = fractions
      # penalties = ['', '-50', '-33.33333', '-25', '-20']
      # puts "[DEBUG] fractions : #{fractions}"
      # puts "[DEBUG] penalties : #{penalties}"

      penalty = penalties[question.bads.size]
      template = File.read(File.join(File.dirname(__FILE__), "moodle", "multichoice.erb"))
    when :boolean
      template = File.read(File.join(File.dirname(__FILE__), "moodle", "truefalse.erb"))
    when :ddmatch
      template = File.read(File.join(File.dirname(__FILE__), "moodle", "ddmatch.erb"))
    when :match
      template = File.read(File.join(File.dirname(__FILE__), "moodle", "matching.erb"))
    when :ordering
      template = File.read(File.join(File.dirname(__FILE__), "moodle", "ordering.erb"))
    when :short
      template = File.read(File.join(File.dirname(__FILE__), "moodle", "shortanswer.erb"))
    else
      warn "[ERROR] QuestionMoodleFormatter: Unkown type (#{question.type})"
      exit 1
    end
    renderer = ERB.new(template)
    renderer.result(binding)
  end
end
