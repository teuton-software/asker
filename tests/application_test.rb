#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/application"

class TestResult < Minitest::Test

  def test_params
    assert_equal "darts-of-teacher", Application::name
    assert_equal "0.10.0", Application::version
  end
end
