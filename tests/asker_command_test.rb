#!/usr/bin/ruby

require 'minitest/autorun'

class AskerCommandTest < Minitest::Test
  def test_version
    assert_equal true,  system('asker version > /dev/null')
  end

end
