# frozen_string_literal: false

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
      s = question.name + "\n"
      #s << "{\n"
      #a = []
      #@question.matching.each do |i, j|
      #  i = i[0, 220] + '...(ERROR: text too long)' if i.size > 255
      #  j = j[0, 220] + '...(ERROR: text too long)' if j.size > 255
      #  a << "  =#{sanitize(i)} -> #{sanitize(j)}\n"
      #end
      #a.shuffle! if @question.shuffle?
      #a.each { |i| s << i }
      #s << "}\n\n"
    when :short
      template = File.read(File.join(File.dirname(__FILE__), 'moodle', 'shortanswer.erb'))
      renderer = ERB.new(template)
      s = renderer.result(binding)
    end
    s
  end
end
