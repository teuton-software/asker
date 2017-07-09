#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/code/code'

class CodeTest < Minitest::Test
  def test_load_ruby_files_string
    dirname = 'tests/input/ruby'
    filename = 'files/string.rb'
    type = :ruby
    code = Code.new(dirname, filename, type)

    assert_equal dirname, code.dirname
    assert_equal filename, code.filename
    assert_equal type, code.type
  end
end
