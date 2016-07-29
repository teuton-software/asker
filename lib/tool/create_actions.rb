#!/usr/bin/ruby
# encoding: utf-8

module CreateActions

  def create_output_files
    project=Project.instance

    project.verbose "\n[INFO] Creating output files..."

    lFile = project.outputfile
    
    @concepts.each_value do |c|
      c.write_questions_to(lFile) if c.process?
    end
    lFile.close

    if project.param[:lessonfile]!=:none then
      #Create lesson file
      lFile=File.new(project.lessonpath,'w')
      @concepts.each_value do |c|
        c.write_lesson_to(lFile) if c.process?
      end
      lFile.close
    end
  end

end
