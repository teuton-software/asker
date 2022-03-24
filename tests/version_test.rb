#!/usr/bin/ruby

# require 'minitest/autorun'
require 'test/unit'
require_relative '../lib/asker/version'

#class VersionTest < Minitest::Test
class VersionTest < Test::Unit::TestCase

  def test_const_major_number
    assert_equal '2.3',  Version::MAJOR_NUMBER
  end

  def test_const_version
    assert Version::VERSION.start_with? Version::MAJOR_NUMBER
  end

  def test_cont_name
    assert_equal 'asker',  Version::NAME
  end

  def test_cont_gem
    assert_equal 'asker-tool', Version::GEM
  end

  def test_version_class
    assert_equal String, Version::VERSION.class
  end

end
