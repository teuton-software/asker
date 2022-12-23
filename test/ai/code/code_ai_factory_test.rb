#!/usr/bin/ruby

require 'test/unit'
require_relative '../../../lib/asker/ai/code/code_ai_factory'
require_relative '../../../lib/asker/data/code'

class CodeAIFactoryTest < Test::Unit::TestCase

  def setup
    @examples = []
    @examples << { filename: 'files/string.rb', lines: 4, questions: 5 }
    @examples << { filename: 'files/array.rb', lines: 7, questions: 29 }
    @examples << { filename: 'files/iterador.rb', lines: 10, questions: 86 }

    @codes = []
    dirname = 'tests/input/ruby'
    type = :ruby
    @examples.each do |example|
      @codes << Code.new(dirname, example[:filename], type)
    end
  end

  def test_load_ruby_codes
    @codes.each do |code|
      code_ai = CodeAIFactory.get(code)
      assert_equal File.basename(code.filename), code_ai.name
      assert_equal code.process?, code_ai.process?
      assert_equal code.type, code_ai.type
      assert_equal code.filename, code_ai.filename
      assert_equal code.lines, code_ai.lines
      assert_equal false, code_ai.process?
      assert code_ai.questions.size.positive?
    end
  end
end
