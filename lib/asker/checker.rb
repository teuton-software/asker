# frozen_string_literal: true

require 'rainbow'

##
# Check HAML file syntax
module Checker
  ##
  # Check:
  # * file exist
  # * filename extension
  # * and HAML syntax
  # @param filepath (String)
  def self.check(filepath)
    unless File.exist? filepath
      puts Rainbow('File not found!').red.bright
      return false
    end
    unless File.extname(filepath) == '.haml'
      puts Rainbow('Only check HAML files!').yellow.bright
      return false
    end
    check_filepath(filepath)
  end

  ##
  # Check HAML syntax
  # @param filepath (String)
  def self.check_filepath(filepath)
    data = Data.new(filepath)
    data.check
    data.show_errors
    data.ok?
  end

  ##
  # Internal class that revise syntax
  # rubocop:disable Metrics/ClassLength
  class Data
    attr_reader :inputs
    attr_reader :outputs

    # rubocop:disable Metrics/MethodLength
    def initialize(filepath)
      @inputs = File.read(filepath).split("\n")
      @outputs = []
      @inputs.each_with_index do |line, index|
        output = { id: index,
                   level: 0,
                   state: :none,
                   type: :none,
                   source: line,
                   msg: '' }
        @outputs << output
      end
      @ok = false
    end
    # rubocop:enable Metrics/MethodLength

    def ok?
      @ok
    end

    def show
      @outputs.each do |i|
        puts "#{i[:id]}: #{i[:state]} [#{i[:type]}] #{i[:msg]}"
      end
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def show_errors
      errors = 0
      @outputs.each do |i|
        next if i[:state] == :ok

        errors += 1
        if errors < 11
          data = { id: i[:id], msg: i[:msg], source: i[:source][0, 40] }
          puts format('%<id>02d: %<msg>s. => %<source>s', data)
        end
        puts '...' if errors == 11
      end
      if errors.positive?
        puts Rainbow("[ERROR] #{errors} errors " \
                     "from #{@inputs.size} lines!").red.bright
      end
      puts Rainbow('Syntax OK!').green if errors.zero?
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def check
      @ok = true
      @inputs.each_with_index do |line, index|
        check_empty_lines(line, index)
        check_map(line, index)
        check_concept(line, index)
        check_names(line, index)
        check_tags(line, index)
        check_def(line, index)
        check_table(line, index)
        check_row(line, index)
        check_col(line, index)
        check_template(line, index)
        check_code(line, index)
        check_type(line, index)
        check_path(line, index)
        check_features(line, index)
        check_unknown(line, index)
        @ok = false unless @outputs[index][:state] == :ok
        @ok = false if @outputs[index][:type] == :unkown
      end
      @ok
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    private

    def check_empty_lines(line, index)
      return unless line.strip.size.zero? || line.start_with?('#')

      @outputs[index][:type] = :empty
      @outputs[index][:level] = -1
      @outputs[index][:state] = :ok
    end

    # rubocop:disable Metrics/MethodLength
    def check_map(line, index)
      if index.zero?
        @outputs[index][:type] = :map
        if line.start_with?('%map{')
          @outputs[index][:state] = :ok
        else
          @outputs[index][:state] = :err
          @outputs[index][:msg] = 'Start with %map{'
        end
      elsif index.positive? && line.include?('%map{')
        @outputs[index][:state] = :err
        @outputs[index][:type] = :map
        @outputs[index][:msg] = 'Write %map on line 0'
      end
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def check_concept(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%concept'

      @outputs[index][:type] = :concept
      @outputs[index][:level] = 1
      @outputs[index][:state] = :ok
      if find_parent(index) != :map
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(map) not found!'
      elsif line != '  %concept'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 2 spaces before %concept'
      end
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def check_names(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%names'

      @outputs[index][:type] = :names
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :concept
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(concept) not found!'
      elsif !line.start_with? '    %names'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %names'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def check_tags(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%tags'

      @outputs[index][:type] = :tags
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :concept
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(concept) not found!'
      elsif !line.start_with? '    %tags'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %tags'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def check_def(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%def'

      @outputs[index][:type] = :def
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :concept
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(concept) not found!'
      elsif !line.start_with? '    %def'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %def'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def check_table(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%table'

      @outputs[index][:type] = :table
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :concept
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(concept) not found!'
      elsif !line.start_with? '    %table'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %table'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/PerceivedComplexity
    def check_row(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%row'

      @outputs[index][:type] = :row
      @outputs[index][:state] = :ok

      if count_spaces(line) == 6
        @outputs[index][:level] = 3
        parent = find_parent(index)
        unless %i[table features].include? parent
          @outputs[index][:state] = :err
          @outputs[index][:msg] = 'Parent(table/features) not found!'
        end
      elsif count_spaces(line) == 8
        @outputs[index][:level] = 4
        if find_parent(index) != :template
          @outputs[index][:state] = :err
          @outputs[index][:msg] = 'Parent(template) not found!'
        end
      else
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 6 or 8 spaces before %row'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/PerceivedComplexity
    def check_col(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%col'

      @outputs[index][:type] = :col
      @outputs[index][:state] = :ok
      if count_spaces(line) == 8
        @outputs[index][:level] = 4
        if find_parent(index) != :row
          @outputs[index][:state] = :err
          @outputs[index][:msg] = 'Parent(row) not found!'
        end
      elsif count_spaces(line) == 10
        @outputs[index][:level] = 5
        if find_parent(index) != :row
          @outputs[index][:state] = :err
          @outputs[index][:msg] = 'Parent(row) not found!'
        end
      else
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 8 or 10 spaces before %col'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def check_template(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%template'

      @outputs[index][:type] = :template
      @outputs[index][:level] = 3
      @outputs[index][:state] = :ok
      if find_parent(index) != :table
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(concept) not found!'
      elsif !line.start_with? '      %template'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 6 spaces before %template'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def check_code(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%code'

      @outputs[index][:type] = :code
      @outputs[index][:level] = 1
      @outputs[index][:state] = :ok
      if find_parent(index) != :map
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(map) not found!'
      elsif line != '  %code'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 2 spaces before %code'
      end
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def check_type(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%type'

      @outputs[index][:type] = :type
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :code
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(code) not found!'
      elsif !line.start_with? '    %type'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %type'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def check_path(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%path'

      @outputs[index][:type] = :path
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :code
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(code) not found!'
      elsif !line.start_with? '    %path'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %type'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def check_features(line, index)
      return unless @outputs[index][:state] == :none
      return unless line.include? '%features'

      @outputs[index][:type] = :features
      @outputs[index][:level] = 2
      @outputs[index][:state] = :ok
      if find_parent(index) != :code
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(code) not found!'
      elsif !line.start_with? '    %features'
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Write 4 spaces before %features'
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def check_unknown(line, index)
      return unless @outputs[index][:state] == :none

      @outputs[index][:type] = :unknown
      @outputs[index][:level] = count_spaces(line) / 2
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Unknown tag with parent(#{find_parent(index)})!"
    end

    def find_parent(index)
      current_level = @outputs[index][:level]
      return :noparent if current_level.zero?

      i = index - 1
      while i >= 0
        return @outputs[i][:type] if @outputs[i][:level] == current_level - 1

        i -= 1
      end
      :noparent
    end

    def count_spaces(line)
      a = line.split('%')
      a[0].count(' ')
    end
  end
  # rubocop:enable Metrics/ClassLength
end
