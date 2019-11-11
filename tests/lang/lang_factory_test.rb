#!/usr/bin/ruby

require 'minitest/autorun'

require_relative '../../lib/asker/lang/lang_factory'
require_relative '../../lib/asker/project'

class LangFactoryTest < Minitest::Test
  def setup
    @codes = Project.instance.locales
  end

  def test_hide_text
    @codes.each do |code|
      lang = LangFactory.instance.get( code )
      assert_equal code,  lang.lang
      assert_equal code,  lang.code
    end
  end

end
