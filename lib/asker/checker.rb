
module Checker
  def self.check(filepath)
    puts "[TODO ] Checking #{filepath}"
    unless File.exist? filepath
      puts "[ERROR] #{filepath} not found!"
      return
    end
    lines = File.read(filepath).split("\n")
    puts "        Lines = #{lines.size}"
    check_lines(lines)
  end

  def self.check_lines(lines)
    lines.each_with_index do |line, index|
      check_map(line, index)
      check_concept(line, index)
      check_names(line, index)
      check_tags(line, index)
      check_def(line, index)
      check_table(line, index)
    end
  end

  def self.check_map(line, index)
    if index == 0
      puts "#{index} : Start with '%map{'" unless line.start_with?('%map{')
    end
  end

  def self.check_concept(line, index)
    if line.include? '%concept'
      puts "#{index} : Only 2 spaces before tag %concept" unless line == '  %concept'
    end
  end

  def self.check_names(line, index)
    if line.include? '%names'
      puts "#{index} : Only 4 spaces before tag %name" unless line.start_with? '    %names '
    end
  end

  def self.check_tags(line, index)
    if line.include? '%tags'
      puts "#{index} : Only 4 spaces before tag %tags" unless line.start_with? '    %tags '
    end
  end

  def self.check_def(line, index)
    if line.include? '%def'
      puts "#{index} : Only 4 spaces before tag %def" unless line.start_with? '    %def '
    end
  end

  def self.check_table(line, index)
    if line.include? '%table'
      puts "#{index} : Only 4 spaces before tag %table" unless line.start_with? '    %table'
    end
  end

  def self.check_template(line, index)
    if line.include? '%template'
      puts "#{index} : Only 4 spaces before tag %template" unless line.start_with? '    %template'
    end
  end
end
