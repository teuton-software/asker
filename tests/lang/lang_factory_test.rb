#!/usr/bin/ruby

require "minitest/autorun"

require_relative "../../lib/lang/lang_factory"
require_relative "../../lib/project"

class LangFactoryTest < Minitest::Test
  def setup
    @locales = Project.instance.locales
  end

  def test_hide_text
    @locales.each do |locale|
      lang = LangFactory.instance.get( locale )
      assert_equal locale,  lang.lang
      assert_equal locale,  lang.locale
    end
  end

end
