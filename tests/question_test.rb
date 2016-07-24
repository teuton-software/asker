#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/concept/question"

class TestLang < Minitest::Test
  def setup
    q0 = Question.new
    q1 = Question.new
    q1.name="my name 1"
    q1.comment="my comment 1"
    q1.text="my text 1"
    q1.set_boolean
    q1.good="my good 1"

    @questions = [ q0 , q1 ]
  end

  def test_init
    q = @questions[0]

    assert_equal "", q.name
    assert_equal "", q.comment
    assert_equal "", q.text
    assert_equal :choice, q.type
    assert_equal "", q.good
    assert_equal [], q.bads
    assert_equal [], q.matching
    assert_equal [], q.shorts
  end

  def test_change_and_reset
    q = @questions[1]

    assert_equal "my name 1", q.name
    assert_equal "my comment 1", q.comment
    assert_equal "my text 1", q.text
    assert_equal :boolean, q.type
    assert_equal "my good 1", q.good

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

  def test_set_types
    q = @questions[0]
    q.set_boolean
    assert_equal :boolean, q.type
    q.set_match
    assert_equal :match, q.type
    q.set_short
    assert_equal :short, q.type
    q.set_choice
    assert_equal :choice, q.type
  end

end
