#!/usr/bin/ruby

require 'test/unit'
require_relative '../../lib/asker/lang/lang'

class LangTest < Test::Unit::TestCase
  def setup
    @lang = { en: Lang.new("en"), es: Lang.new("es") }
    @texts = [ 'hello', 'hello world!', 'bye,bye' ]
    @hides = [ '[*]', '????? ?????!', '???,???' ]
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
    max = @texts.size
    max.times do |index|
      assert_equal @hides[index], @lang[:en].hide_text(@texts[index])
    end
    max.times do |index|
      assert_equal @hides[index], @lang[:es].hide_text(@texts[index])
    end
  end

  def test_text_with_connectors
    text = %q{Hello, my name is Obiwan. I am a Jedi.}
    t = @lang[:en].text_with_connectors(text)

    assert_equal 2,    t[:lines].size

    assert_equal 6,    t[:lines][0].size
    assert_equal 0,    t[:lines][0][0]
    assert_equal "my", t[:lines][0][1]
    assert_equal 1,    t[:lines][0][2]
    assert_equal 2,    t[:lines][0][3]
    assert_equal 3,    t[:lines][0][4]
    assert_equal ".",  t[:lines][0][5]

    assert_equal 5,    t[:lines][1].size
    assert_equal "I",  t[:lines][1][0]
    assert_equal 4,    t[:lines][1][1]
    assert_equal "a",  t[:lines][1][2]
    assert_equal 5,    t[:lines][1][3]
    assert_equal ".",  t[:lines][1][4]

    assert_equal 6,    t[:words].size
    assert_equal "Hello,", t[:words][0][:word]
    assert_equal "name",   t[:words][1][:word]
    assert_equal "is",     t[:words][2][:word]
    assert_equal "Obiwan", t[:words][3][:word]
    assert_equal "am",     t[:words][4][:word]
    assert_equal "Jedi",   t[:words][5][:word]

    #### Example ####
    # {
    #   :lines=>[[0, "my", 1, 2, 3, "."], ["I", 4, "a", 5, "."]],
    #   :words=>
    #     [{:word=>"Hello,", :row=>0, :col=>0},
    #      {:word=>"name", :row=>0, :col=>2},
    #      {:word=>"is", :row=>0, :col=>3},
    #      {:word=>"Obiwan", :row=>0, :col=>4},
    #      {:word=>"am", :row=>1, :col=>1},
    #      {:word=>"Jedi", :row=>1, :col=>3}],
    #   :indexes=>[0, 1, 2, 3, 4, 5]
    # }

    r2 = "[1] my [2] [3] [4]. I am a Jedi."
    assert_equal r2, @lang[:en].build_text_from_filtered(t, [0,1,2,3])

    r2 = "Hello, my [1] [2] [3]. I [4] a Jedi."
    assert_equal r2, @lang[:en].build_text_from_filtered(t, [1,2,3,4])

    r2= "Hello, my name [1] [2]. I [3] a [4]."
    assert_equal r2, @lang[:en].build_text_from_filtered(t, [2,3,4,5])
  end
end
