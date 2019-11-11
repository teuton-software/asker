#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = {}

    @files[:lib] = []
    @files[:lib] << 'Rakefile'
    @files[:lib] << 'lib/asker/application.rb'
#    @files[:lib] << 'lib/asker/project.rb'
    @files[:lib] << 'lib/asker/tool.rb'

    @files[:ai] = []
#   @files[:ai] << 'lib/asker/ai/concept_ai.rb'
    @files[:ai] << 'lib/asker/ai/stages/main.rb'

    @files[:command] = []
    @files[:command] << 'lib/asker/command/main.rb'
    @files[:command] << 'lib/asker/command/create.rb'
    @files[:command] << 'lib/asker/command/delete.rb'
    @files[:command] << 'lib/asker/command/download.rb'
    @files[:command] << 'lib/asker/command/editor.rb'
#    @files[:command] << 'lib/asker/command/file.rb'
    @files[:command] << 'lib/asker/command/version.rb'

    @files[:data] = []
#    @files[:data] << 'lib/asker/data/column.rb'
#    @files[:data] << 'lib/asker/data/concept.rb'

    @files[:exporter] = []
    @files[:exporter] << 'lib/asker/exporter/code_gift_exporter.rb'

    @files[:lang] = []
    @files[:lang] << 'lib/asker/lang/lang_factory.rb'
#    @files[:lang] << 'lib/asker/lang/lang.rb'

    @files[:loader] = []
#    @files[:data] << 'lib/asker/loader/project_loader.rb'

    @files[:sinatra] = []
    @files[:sinatra] << 'lib/asker/sinatra/formatter/concept_haml_formatter.rb'
    @files[:sinatra] << 'lib/asker/sinatra/formatter/table_haml_formatter.rb'
  end

  def test_rubocop_lib
    @files[:lib].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_ai
    @files[:ai].each do |file|
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

  def test_rubocop_exporter
    @files[:exporter].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_lang
    @files[:lang].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_loader
    @files[:loader].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end

  def test_rubocop_sinatra
    @files[:sinatra].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      assert_equal true, lines.any?(/file inspected, no offenses detected/)
    end
  end
end
