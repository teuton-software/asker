#!/usr/bin/ruby

require 'test/unit'
require_relative '../../lib/asker/ai/question'

class QuestionTest < Test::Unit::TestCase

  def setup
    q0 = Question.new

    q1 = Question.new(:boolean)
    q1.name="my name 1"
    q1.comment="my comment 1"
    q1.text="my text 1"
    q1.good=true

    q2 = Question.new(:choice)
    q2.name="my name 2"
    q2.comment="my comment 2"
    q2.text="my text 2"
    q2.good="good 2"
    q2.bads = [ "bad1", "bad2", "bad3" ]

    q3 = Question.new(:match)
    q3.name="my name 3"
    q3.comment="my comment 3"
    q3.text="my text 3"
    q3.matching << [ "a1", "b1" ]
    q3.matching << [ "a2", "b2" ]
    q3.matching << [ "a3", "b3" ]
    q3.matching << [ "a4", "b4" ]

    @questions = [ q0 , q1, q2, q3 ]
  end

  def test_init
    q = @questions[0]

    assert_equal "",   q.name
    assert_equal "",   q.comment
    assert_equal "",   q.text
    assert_equal :choice, q.type
    assert_equal "",   q.good
    assert_equal [],   q.bads
    assert_equal [],   q.matching
    assert_equal [],   q.shorts
    assert_equal true, q.shuffle?
    q.shuffle_off
    assert_equal false, q.shuffle?
    q.shuffle_on
    assert_equal true,  q.shuffle?
  end

  def test_boolean
    q = @questions[1]

    assert_equal "my name 1", q.name
    assert_equal "my comment 1", q.comment
    assert_equal "my text 1", q.text
    assert_equal :boolean,    q.type
    assert_equal true,        q.good
    assert_equal true,        q.shuffle?
    q.shuffle_off
    assert_equal false,       q.shuffle?

    q.reset

    assert_equal "",    q.name
    assert_equal "",    q.comment
    assert_equal "",    q.text
    assert_equal :choice, q.type
    assert_equal "",    q.good
    assert_equal [],    q.bads
    assert_equal [],    q.matching
    assert_equal [],    q.shorts
    assert_equal true,  q.shuffle?
    q.shuffle_off
    assert_equal false, q.shuffle?
  end

  def test_choice
    q = @questions[2]

    assert_equal "my name 2", q.name
    assert_equal "my comment 2", q.comment
    assert_equal "my text 2", q.text
    assert_equal :choice, q.type
    assert_equal "good 2", q.good
    assert_equal [ "bad1", "bad2", "bad3" ], q.bads
    assert_equal 3, q.bads.size

    q.reset

    assert_equal "", q.name
    assert_equal "", q.comment
    assert_equal "", q.text
    assert_equal :choice, q.type
    assert_equal "", q.good
    assert_equal [], q.bads
    assert_equal [], q.matching
    assert_equal [], q.shorts
  end

  def test_match
    q = @questions[3]

    assert_equal "my name 3", q.name
    assert_equal "my comment 3", q.comment
    assert_equal "my text 3", q.text
    assert_equal :match, q.type
    assert_equal "", q.good
    assert_equal [], q.bads
    assert_equal 4, q.matching.size

    q.reset

    assert_equal "", q.name
    assert_equal "", q.comment
    assert_equal "", q.text
    assert_equal :choice, q.type
    assert_equal "", q.good
    assert_equal [], q.bads
    assert_equal [], q.matching
    assert_equal [], q.shorts
  end

end
