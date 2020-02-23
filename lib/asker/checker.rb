
require 'rainbow'

module Checker
  def self.check(filepath)
    puts "Checking #{Rainbow(filepath).bright}"
    unless File.exist? filepath
      puts Rainbow("File not found!").red.bright
      return
    end
    unless File.extname(filepath) == '.haml'
      puts Rainbow("Only check HAML files!").yellow.bright
      return
    end
    check_filepath(filepath)
  end

  def self.check_filepath(filepath)
    data = Data.new(filepath)
    data.check
    data.show_errors
  end

  class Data
    attr_reader :inputs
    attr_reader :outputs
    def initialize(filepath)
      @inputs = File.read(filepath).split("\n")
      @outputs = []
      @inputs.each_with_index do |line, index|
        output = { id: index, state: :none, type: :none, source: line, msg: '' }
        @outputs << output
      end
    end

    def show
      @outputs.each do |i|
        puts "#{i[:id]}: #{i[:state]} [#{i[:type]}] #{i[:msg]}"
      end
    end

    def show_errors
      errors = 0
      @outputs.each do |i|
        unless i[:state] == :ok
          errors += 1
          if errors < 6
            puts "#{i[:id]}: #{i[:state]} [#{i[:type]}] <#{i[:source][0,40]}>"
            puts "    #{i[:msg]}" if i[:msg].size > 0
          end
          puts "..." if errors == 6
        end
      end
      puts Rainbow("[ERROR] #{errors} errors from #{@inputs.size} lines!").red.bright if errors > 0
      puts Rainbow("Syntax OK!").green if errors == 0
    end

    def check
      check_empty_lines
      check_map
      check_concept
      check_names
      check_tags
      check_def
      check_table
      check_row
      check_col
      check_template
    end

    def check_empty_lines
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.strip.size.zero? or line.start_with? '#'
          @outputs[index][:type] = :empty
          @outputs[index][:state] = :ok
        end
      end
    end

    def check_map
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if index == 0
          if line.start_with?('%map{')
            @outputs[index][:state] = :ok
            @outputs[index][:type] = :map
          else
            @outputs[index][:state] = :err
            @outputs[index][:type] = :map
            @outputs[index][:msg] = "Start with '%map{'"
          end
        elsif index > 0 and line.include?('%map{')
          @outputs[index][:state] = :err
          @outputs[index][:type] = :map
          @outputs[index][:msg] = "Write '%map' on line 0"
        end
      end
    end

    def check_concept
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%concept'
          @outputs[index][:type] = :concept
          if line == '  %concept'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 2 spaces before %concept"
          end
        end
      end
    end

    def check_names
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%names'
          @outputs[index][:type] = :names
          if line.start_with? '    %names'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 4 spaces before %names"
          end
        end
      end
    end

    def check_tags
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%tags'
          @outputs[index][:type] = :tags
          if line.start_with? '    %tags'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 4 spaces before %tags"
          end
        end
      end
    end

    def check_def
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%def'
          @outputs[index][:type] = :def
          if line.start_with? '    %def'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 4 spaces before %def"
          end
        end
      end
    end

    def check_table
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%table'
          @outputs[index][:type] = :def
          if line.start_with? '    %table'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 4 spaces before %table"
          end
        end
      end
    end

    def check_row
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%row'
          @outputs[index][:type] = :row
          if line.start_with? '      %row'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 6 spaces before %row"
          end
        end
      end
    end

    def check_col
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%col'
          @outputs[index][:type] = :row
          if line.start_with? '        %col'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 8 spaces before %col"
          end
        end
      end
    end

    def check_template
      @inputs.each_with_index do |line, index|
        next if @outputs[index][:state] == :err
        if line.include? '%template'
          @outputs[index][:type] = :def
          if line.start_with? '      %template'
            @outputs[index][:state] = :ok
          else
            @outputs[index][:state] = :err
            @outputs[index][:msg] = "Write 6 spaces before %template"
          end
        end
      end
    end
  end
end
