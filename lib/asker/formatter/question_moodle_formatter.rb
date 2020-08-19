# frozen_string_literal: false

require 'erb'

# Transform Questions into Gift format
module QuestionMoodleFormatter
  ##
  # Convert question object into gift formatted string
  # @param question (Question)
  # @return String
  def self.to_s(question)
    # @question.comment.nil? && @question.comment.empty?

    case question.type
    when :choice
      penalties = ['', '%-50%', '%-33.33333%', '%-25%', '%-20%']
      penalty = penalties[question.bads.size]
      template = File.read(File.join(File.dirname(__FILE__), 'moodle', 'multichoice.erb'))
      renderer = ERB.new(template)
      s = renderer.result(binding)
    when :boolean
      template = File.read(File.join(File.dirname(__FILE__), 'moodle', 'truefalse.erb'))
      renderer = ERB.new(template)
      s = renderer.result(binding)
    when :match
      template = File.read(File.join(File.dirname(__FILE__), 'moodle', 'matching.erb'))
      renderer = ERB.new(template)
      s = renderer.result(binding)
    when :short
      template = File.read(File.join(File.dirname(__FILE__), 'moodle', 'shortanswer.erb'))
      renderer = ERB.new(template)
      s = renderer.result(binding)
    end
    s
  end
end
