#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/lang/lang"

class TestLang < Minitest::Test
  def setup
    @lang = { :en => Lang.new("en"), :es => Lang.new("es") }
    @texts = [ 'hello', 'hello world!', 'bye-bye' ]
    @hides = [ '?????', '????? ?????!', '???-???' ]
  end

  def test_count_words
    examples=[ { :text => "obi-wan kenobi is jedi"   , :wc => 4 },
               { :text => "obi-wan,yoda,qui-gon\n and annakin are jedis,from starwars", :wc => 9 },
               { :text => "Maul\nSidius\nand Vader\nare,old siths." , :wc => 7 }  ]

    examples.each do |example|
      assert_equal example[:wc], @lang[:en].count_words(example[:text])
      assert_equal example[:wc], @lang[:es].count_words(example[:text])
    end
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
