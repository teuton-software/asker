#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../../lib/lang/lang_factory"

class LangFactoryTest < Minitest::Test
  def setup
  end

  def test_hide_text
    en = LangFactory.instance.get(:en)
    assert_equal 'en', en.lang
    es = LangFactory.instance.get(:es)
    assert_equal 'es', es.lang
  end

end
