require "test/unit"
require_relative "../../lib/asker/ai/question"
require_relative "../../lib/asker/exporter/gift/question_gift_formatter"

class QuestionGiftFormatterTest < Test::Unit::TestCase
  def setup
    q0 = Question.new

    q1 = Question.new(:boolean)
    q1.name = 'my name 1'
    q1.comment = 'boolean comment 1'
    q1.text = 'my text 1'
    q1.good = true
    q1.feedback = 'You know is true'

    q2 = Question.new(:choice)
    q2.name = 'my name 2'
    q2.comment = 'choice comment 2'
    q2.text = 'my text 2'
    q2.good = 'good 2'
    q2.bads = [ 'bad1', 'bad2', 'bad3' ]
    q2.feedback = '2 is OK'

    q3 = Question.new(:match)
    q3.name = 'my name 3'
    q3.comment = 'match comment 3'
    q3.text = 'my text 3'
    q3.matching << [ 'a1', 'b1' ]
    q3.matching << [ 'a2', 'b2' ]
    q3.matching << [ 'a3', 'b3' ]
    q3.matching << [ 'a4', 'b4' ]
    q3.feedback = 'match feedback'

    q4 = Question.new(:short)
    q4.name = 'my name 4'
    q4.comment = 'short comment 4'
    q4.text = 'my text 4'
    q4.shorts << 'OK1'
    q4.feedback = 'short feedback'

    @questions = [q0, q1, q2, q3, q4]
  end

  def test_sanitize
    assert_equal '', QuestionGiftFormatter.sanitize()
    assert_equal 'Hello!', QuestionGiftFormatter.sanitize('Hello!')
    assert_equal "Hello! How are you?", QuestionGiftFormatter.sanitize("Hello!\nHow are you?")
    assert_equal 'this \#value', QuestionGiftFormatter.sanitize('this #value')
    assert_equal 'say\: Hello!', QuestionGiftFormatter.sanitize('say: Hello!')
    assert_equal '1+1\=2', QuestionGiftFormatter.sanitize('1+1=2')
    assert_equal '\{value\}', QuestionGiftFormatter.sanitize('{value}')
  end

  def test_boolean_question_formatter
    index = 1
    question = @questions[index]
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    c = format("{%s####%s}", question.good, question.feedback)
    assert_equal c, line[2]

    question.feedback = nil
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    c = format("{%s####}", question.good)
    assert_equal c, line[2]

  end

  def test_choice_question_formatter
    index = 2
    question = @questions[index]
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    assert_equal '{', line[2]
    d = [line[3], line[4], line[5], line[6]]
    d.sort!
    assert_equal format("  =%s", question.good), d[0]
    c = '  ~%-25%' + question.bads[0]
    assert_equal c, d[1]
    c = '  ~%-25%' + question.bads[1]
    assert_equal c, d[2]
    c = '  ~%-25%' + question.bads[2]
    assert_equal c, d[3]

    c = format("  ####%s", question.feedback)
    assert_equal c, line[7]
    assert_equal '}', line[8]

    question.feedback = nil
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    assert_equal '{', line[2]
    d = [line[3], line[4], line[5], line[6]]
    d.sort!
    assert_equal format("  =%s", question.good), d[0]
    c = '  ~%-25%' + question.bads[0]
    assert_equal c, d[1]
    c = '  ~%-25%' + question.bads[1]
    assert_equal c, d[2]
    c = '  ~%-25%' + question.bads[2]
    assert_equal c, d[3]
    assert_equal '}', line[7]
  end

  def test_match_question_formatter
    index = 3
    question = @questions[index]
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    assert_equal '{', line[2]
    d = [line[3], line[4], line[5], line[6]]
    d.sort!
    m = question.matching[0]
    assert_equal format("  =%s -> %s", m[0], m[1]), d[0]
    m = question.matching[1]
    assert_equal format("  =%s -> %s", m[0], m[1]), d[1]
    m = question.matching[2]
    assert_equal format("  =%s -> %s", m[0], m[1]), d[2]
    m = question.matching[3]
    assert_equal format("  =%s -> %s", m[0], m[1]), d[3]
    assert_equal '}', line[7]
  end

  def test_short_question_formatter
    index = 4
    question = @questions[index]
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    assert_equal '{', line[2]
    m = question.shorts[0]
    c = '  =%100%' + m + '#'
    assert_equal c, line[3]
    assert_equal format("  ####%s", question.feedback), line[4]
    assert_equal '}', line[5]

    question.feedback = nil
    a = QuestionGiftFormatter.to_s(question)
    line = a.split("\n")

    c = format("// %s", question.comment)
    assert_equal c, line[0]
    c = format("::%s::[html]%s", question.name, question.text)
    assert_equal c, line[1]
    assert_equal '{', line[2]
    m = question.shorts[0]
    c = '  =%100%' + m + '#'
    assert_equal '}', line[4]
  end
end
