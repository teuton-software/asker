#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/version'

class VersionTest < Minitest::Test
  def test_major_number
    assert_equal '2.2',  Version::MAJOR_NUMBER
  end

  def test_version
    assert Version::Version.start_with? Version::MAJOR_NUMBER
  end

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
