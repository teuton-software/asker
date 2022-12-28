require 'test/unit'
require_relative '../lib/asker/version'

class VersionTest < Test::Unit::TestCase
  def test_const_major_number
    assert_equal '2.',  Asker::VERSION[0,2]
  end

  def test_cont_name
    assert_equal 'asker',  Asker::NAME
  end

  def test_cont_gem
    assert_equal 'asker-tool', Asker::GEM
  end

  def test_version_class
    assert_equal String, Asker::VERSION.class
  end
end
