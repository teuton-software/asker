#!/usr/bin/ruby
# encoding: utf-8

module CreateActions

  def create_output_files
    project=Project.instance

    project.verbose "\n[INFO] Creating output files..."

    file = project.outputfile
    @concepts.each_value do |c|
      c.write_questions_to(file) if c.process?
    end

    file = project.param[:lessonfile]
    @concepts.each_value do |c|
      c.write_lesson_to(file) if c.process?
    end
  end

end
