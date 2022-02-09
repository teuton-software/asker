#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/version'

class VersionºTest < Minitest::Test
  def test_name
    assert_equal 'asker',  Version::NAME
  end

  def test_gem
    assert_equal 'asker-tool', Version::GEM
  end

  def test_version
    assert_equal String, Version::VERSION.class
  end

end
