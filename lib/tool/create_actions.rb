#!/usr/bin/ruby
# encoding: utf-8

module CreateActions

  def create_output_files
    app=Application.instance

    verbose "\n[INFO] Creating output files..."

    lFile=File.new(@outputname,'w')
    lFile.write("// File: #{@outputname}\n")
    lFile.write("// Time: "+Time.new.to_s+"\n")
    lFile.write("// Create automatically by David Vargas\n")
    lFile.write("\n")
    lFile.write("$CATEGORY: $course$/#{app.category.to_s}\n") if app.category!=:none
    @concepts.each_value do |c|
      c.write_questions_to(lFile) if c.process?
    end
    lFile.close

    if app.param[:lesson_file]!=:none then
      lFile=File.new(app.outputdir+'/'+app.lesson_file,'w')
      @concepts.each_value do |c|
        c.write_lesson_to(lFile) if c.process?
      end
      lFile.close
    end
  end
  
end
