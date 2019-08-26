#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/code/code'

class CodeTest < Minitest::Test
  def setup
    @examples = []
    @examples << { filename: 'files/string.rb', lines: 4, questions: 7 }
    @examples << { filename: 'files/array.rb', lines: 7, questions: 30 }
    @examples << { filename: 'files/iterador.rb', lines: 10, questions: 90 }
  end

  def test_load_ruby_files
    dirname = 'tests/input/ruby'
    type = :ruby

    @examples.each do |example|
      code = Code.new(dirname, example[:filename], type)

      assert_equal dirname, code.dirname
      assert_equal example[:filename], code.filename
      assert_equal type, code.type
      assert_equal example[:lines], code.lines.size
      assert_equal false, code.process?
      assert_equal 0, code.questions.size

      code.process = true
      code.make_questions
      assert_equal true, code.questions.size >= example[:questions]
    end
  end
end
