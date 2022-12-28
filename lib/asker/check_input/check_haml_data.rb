require "colorize"
require_relative "check_table"

class CheckHamlData
  include CheckTable
  attr_reader :inputs, :outputs

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

  def ok?
   @ok
  end

  def show
    @outputs.each do |i|
      puts "#{i[:id]}: #{i[:state]} [#{i[:type]}] #{i[:msg]}"
    end
  end

  def show_errors
    errors = 0
    puts "\n"
    @outputs.each do |i|
      next if i[:state] == :ok

      errors += 1
      if errors < 11
        data = { id: i[:id], msg: i[:msg], source: i[:source][0, 40] }
        order = i[:id] + 1
        data = { order: order, msg: i[:msg], source: i[:source][0, 40] }
        print format(' %<order>03d : %<msg>32s. => '.white, data)
        puts format('%<source>s'.light_yellow, data)
      end
      puts '...' if errors == 11
    end

    if errors.positive?
      puts "\n[ ASKER ] Please! Revise #{errors.to_s.light_red} error/s\n"
    end
    puts 'Syntax OK!'.green if errors.zero?
  end

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

  private

  def check_empty_lines(line, index)
    return unless line.strip.size.zero? || line.start_with?('#')

    @outputs[index][:type] = :empty
    @outputs[index][:level] = -1
    @outputs[index][:state] = :ok
  end

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

  def check_concept(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%concept'

    @outputs[index][:type] = :concept
    @outputs[index][:level] = 1
    @outputs[index][:state] = :ok
    if find_parent(index) != :map
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(map) not found!'
    elsif !line.match(/^\s\s%concept\s*$/)
      binding.break
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 2 spaces before %concept, and no text after'
    end
  end

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
    elsif !line.match(/^\s\s\s\s%names\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %names'
    end
  end

  def check_tags(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%tags'

    @outputs[index][:type] = :tags
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :concept
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(concept) not found!'
    elsif !line.match(/^\s\s\s\s%tags\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %tags'
    end
  end

  def check_def(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%def'

    @outputs[index][:type] = :def
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :concept
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(concept) not found!'
    elsif !line.match(/^\s\s\s\s%def[\s{]/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %def'
    end
  end

  def check_code(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%code'

    @outputs[index][:type] = :code
    @outputs[index][:level] = 1
    @outputs[index][:state] = :ok
    if find_parent(index) != :map
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(map) not found!'
    elsif !line.match(/^\s\s%code\s*$/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 2 spaces before %code, and no text after'
    end
  end

  def check_type(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%type'

    @outputs[index][:type] = :type
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :code
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(code) not found!'
    elsif !line.match(/^\s\s\s\s%type\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %type'
    end
  end

  def check_path(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%path'

    @outputs[index][:type] = :path
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :code
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(code) not found!'
    elsif !line.match(/^\s\s\s\s%path\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %type'
    end
  end

  def check_features(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%features'

    @outputs[index][:type] = :features
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :code
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(code) not found!'
    elsif !line.match(/^\s\s\s\s%features\s*$/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %features, and no text after'
    end
  end

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
