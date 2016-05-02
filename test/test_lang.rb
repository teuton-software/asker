#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/concept/lang"

class TestLang < Minitest::Test
  def setup
    @lang = { :en => Lang.new("en"), :es => Lang.new("es") }
    @texts = [ 'hello', 'hello world!', 'bye-bye' ]
    @hides = [ '?????', '????? ?????!', '???-???' ]
  end

  def test_hide_text
    max=@texts.size
    max.times do |index|
      assert_equal @hides[index], @lang[:en].hide_text(@texts[index])
    end
    max.times do |index|
      assert_equal @hides[index], @lang[:es].hide_text(@texts[index])
    end
  end

end
