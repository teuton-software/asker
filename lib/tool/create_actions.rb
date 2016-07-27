#!/usr/bin/ruby
# encoding: utf-8

module CreateActions

  def create_output_files
    project=Project.instance

    project.verbose "\n[INFO] Creating output files..."

    #Create output file
    lFile=File.new(project.outputpath,'w')
    lFile.write("// File   : #{project.outputname}\n")
    lFile.write("// Time   : "+Time.new.to_s+"\n")
    lFile.write("// Author : David Vargas\n")
    lFile.write("\n")
    lFile.write("$CATEGORY: $course$/#{project.category.to_s}\n") if project.category!=:none
    @concepts.each_value do |c|
      c.write_questions_to(lFile) if c.process?
    end
    lFile.close

    if project.param[:lessonfile]!=:none then
      #Create lesson file
      lFile=File.new(projecto.lessonpath,'w')
      @concepts.each_value do |c|
        c.write_lesson_to(lFile) if c.process?
      end
      lFile.close
    end
  end

end
