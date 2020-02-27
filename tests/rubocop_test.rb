#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class RubocopTest < Minitest::Test
  def setup
    @files = {}

    @files[:lib] = []
#    @files[:lib] << 'asker'
    @files[:lib] << 'Rakefile'
#    @files[:lib] << 'tasks/install.rb'
    @files[:lib] << 'tasks/utils.rb'
    @files[:lib] << 'lib/asker.rb'
    @files[:lib] << 'lib/asker/application.rb'
#    @files[:lib] << 'lib/asker/checker.rb'
#    @files[:lib] << 'lib/asker/cli.rb'
    @files[:lib] << 'lib/asker/logger.rb'
#    @files[:lib] << 'lib/asker/project.rb'
    @files[:lib] << 'lib/asker/skeleton.rb'

    @files[:ai] = []
#   @files[:ai] << 'lib/asker/ai/concept_ai.rb'
    @files[:ai] << 'lib/asker/ai/stages/main.rb'

    @files[:data] = []
#    @files[:data] << 'lib/asker/data/column.rb'
#    @files[:data] << 'lib/asker/data/concept.rb'

    @files[:exporter] = []
    @files[:exporter] << 'lib/asker/exporter/code_gift_exporter.rb'

    @files[:formatter] = []
#    @files[:formatter] << 'lib/asker/formatter/code_string_formatter.rb'
    @files[:formatter] << 'lib/asker/formatter/concept_doc_formatter.rb'
    @files[:formatter] << 'lib/asker/formatter/concept_string_formatter.rb'

    @files[:lang] = []
    @files[:lang] << 'lib/asker/lang/lang_factory.rb'
#    @files[:lang] << 'lib/asker/lang/lang.rb'

    @files[:loader] = []
    @files[:loader] << 'lib/asker/loader/input_loader.rb'
#    @files[:data] << 'lib/asker/loader/project_loader.rb'
    @files[:loader] << 'lib/asker/loader/directory_loader.rb'
    @files[:loader] << 'lib/asker/loader/file_loader.rb'
#    @files[:loader] << 'lib/asker/loader/content_loader.rb'
    @files[:loader] << 'lib/asker/loader/code_loader.rb'
  end

  def test_rubocop_lib
    @files[:lib].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_ai
    @files[:ai].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_data
    @files[:data].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_exporter
    @files[:exporter].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_formatter
    @files[:formatter].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_lang
    @files[:lang].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end

  def test_rubocop_loader
    @files[:loader].each do |file|
      output = `rubocop #{file}`
      lines = output.split("\n")
      puts "[DEBUG] #{file}" if $?.exitstatus > 0
      assert_equal 0, $?.exitstatus
    end
  end
end
