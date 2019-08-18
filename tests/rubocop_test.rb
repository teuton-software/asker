#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = {}

    @files[:lib] = []
    @files[:lib] << 'lib/application.rb'
    @files[:lib] << 'lib/config.rb'

    @files[:command] = []
    @files[:command] << 'lib/command/main.rb'
    @files[:command] << 'lib/command/create.rb'
    @files[:command] << 'lib/command/delete.rb'
    @files[:command] << 'lib/command/download.rb'
    @files[:command] << 'lib/command/editor.rb'
#    @files[:command] << 'lib/command/file.rb'
    @files[:command] << 'lib/command/version.rb'

    @files[:data] = []
#    @files[:data] << 'lib/command/column.rb'
#    @files[:data] << 'lib/command/concept.rb'
  end

  def test_rubocop_lib
    @files[:lib].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_command
    @files[:command].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_data
    @files[:data].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end
end
