#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = {}

    @files[:command] = []
    @files[:command] << 'lib/command/create.rb'
    @files[:command] << 'lib/command/delete.rb'
    @files[:command] << 'lib/command/download.rb'
    @files[:command] << 'lib/command/editor.rb'
#    @files[:command] << 'lib/command/file.rb'
    @files[:command] << 'lib/command/version.rb'
  end

  def test_rubocop_command
    @files[:command].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end
end
