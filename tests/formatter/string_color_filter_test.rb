#!/usr/bin/ruby

require 'minitest/autorun'
require 'rexml/document'

require_relative '../../lib/asker/formatter/string_color_filter'
require_relative '../../lib/asker/project'

class StringColorFilterTest < Minitest::Test
  def test_color_on
    Project.instance.reset
    assert_equal 'Hello!', StringColorFilter.filter('Hello!')
    assert_equal "\e[34mHello!\e[0m", StringColorFilter.filter(Rainbow('Hello!').blue)
  end

  def test_color_off
    Project.instance.reset
    Project.instance.set(:color_output, false)
    assert_equal 'Hello!', StringColorFilter.filter('Hello!')
    assert_equal 'Hello!', StringColorFilter.filter(Rainbow('Hello!').blue)
    Project.instance.reset
  end
end
