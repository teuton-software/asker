require "test/unit"
require_relative "../../lib/asker/data/code"

class CodeTest < Test::Unit::TestCase
  def setup
    @examples = []
    @examples << { filename: 'files/string.rb', lines: 4, questions: 5 }
    @examples << { filename: 'files/array.rb', lines: 7, questions: 29 }
    @examples << { filename: 'files/iterador.rb', lines: 10, questions: 86 }
  end

  def test_load_ruby_files
    dirname = File.join("test", "input", "ruby")
    type = :ruby

    @examples.each do |example|
      code = Code.new(dirname, example[:filename], type)

      assert_equal dirname, code.dirname
      assert_equal example[:filename], code.filename
      assert_equal type, code.type
      assert_equal example[:lines], code.lines.size
      assert_equal false, code.process?
    end
  end
end
