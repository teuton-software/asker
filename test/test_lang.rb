#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/concept/lang"

class TestLang < Minitest::Test
  def setup
    @lang = { :en => Lang.new("en"), :es => Lang.new("es") }
    @texts = [ 'hello', 'hello world!', 'bye-bye' ]
    @hides = [ '?????', '????? ?????!', '???-???' ]
  end

  def test_count_words
    example=[  { :text => "Hello friend! How are you today?", :wc => 6 },
               { :text => "Dave,get up!.Come on." , :wc => 5 }
            ]

    assert_equal example[0][:wc], @lang[:en].count_words(example[0][:text])
    assert_equal example[1][:wc], @lang[:en].count_words(example[1][:text])
    assert_equal example[0][:wc], @lang[:es].count_words(example[0][:text])
    assert_equal example[1][:wc], @lang[:es].count_words(example[1][:text])
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
