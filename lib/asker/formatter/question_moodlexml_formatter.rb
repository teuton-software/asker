# encoding: utf-8

# Transform Questions into Gift format
module QuestionMoodleXMLFormatter
  def self.to_s(question)
    @question = question

    case @question.type
    when :choice
      s += choice_to_s(question)
    when :boolean
    when :match
    when :short
    end
    s.flaten!
  end

  def self.choice_to_s(question)
    s = []

    penalties = ['', '%-50%', '%-33.33333%', '%-25%', '%-20%']
    penalty = penalties[question.bads.size]

    s << "<!-- question: #{question.name}  -->"
    s << '<question type="multichoice">'
    s << '  <name>'
    s << "    <text>#{question.name}</text>"
    s << '  </name>'
    s << '  <questiontext format="html">'
    s << "    <text><![CDATA[#{question.text}]]></text>"
    s << '  </questiontext>'
    s << '  <generalfeedback format="html">'
    s << "    <text>#{question.feedback}</text>"
    s << '  </generalfeedback>'
    s << '  <defaultgrade>1.0000000</defaultgrade>'
    s << "  <penalty>#{penalty}</penalty>"
    s << '  <hidden>0</hidden>'
    s << '  <single>true</single>'
    s << "  <shuffleanswers>#{question.shuffle?}</shuffleanswers>"
    s << '  <answernumbering>abc</answernumbering>'
    s << '  <incorrectfeedback format="html">'
    s << "    <text>#{question.feedback}</text>"
    s << '  </incorrectfeedback>'
    s << '  <answer fraction="100" format="html">'
    s << "    <text>#{question.good}</text>"
    s << '  </answer>'
    s << '  <answer fraction="-25" format="html">'
    s << "    <text>#{question.bad[0]}</text>"
    s << '  </answer>'
    s << '  </question>'
    s << '  <answer fraction="-25" format="html">'
    s << "    <text>#{question.bad[1]}</text>"
    s << '  </answer>'
    s << '  </question>'
    s << '  <answer fraction="-25" format="html">'
    s << "    <text>#{question.bad[2]}</text>"
    s << '  </answer>'
    s << '  </question>'
    s
  end

  def self.sanitize(input = '')
    output = input.dup
    output.tr!("\n", " ")
    output.tr!(":", "\:")
    output.tr!("=", "\\=")
    # output.gsub!('{', "\\{")
    # output.gsub!('}', "\\}")
    output
  end
end
