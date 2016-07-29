
module CreateActions

  def create_output_files
    Project.instance.verbose "\n[INFO] Creating output files..."
    @concepts.each_value { |c| c.write_questions_to_file }
    @concepts.each_value { |c| c.write_lesson_to_file }
  end

end
