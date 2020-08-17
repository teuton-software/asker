#!/usr/bin/ruby

require 'minitest/autorun'

require_relative '../../lib/asker/lang/lang_factory'
require_relative '../../lib/asker/application'

class LangFactoryTest < Minitest::Test
  def setup
  end

  def test_hide_text
    languages = Application.instance.config['languages']
    languages.each_pair do |key, value|
      next if key.downcase == 'default' || value.downcase != 'yes'
      lang = LangFactory.instance.get(key)
      assert_equal key,  lang.lang
      assert_equal key,  lang.code
    end
  end

end
