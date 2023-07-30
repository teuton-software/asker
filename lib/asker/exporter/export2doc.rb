require_relative "doc/format_code2doc"
require_relative "doc/format_concept2doc"
require_relative "doc/format_problem2doc"
require_relative "../version"

class Export2Doc
  def call(data, project)
    file_open(project)
    export_codes(data[:codes])
    export_concepts(data[:concepts])
    export_problems(data[:problems])
    @file.close
  end

  private

  def file_open(project)
    @file = File.new(project.get(:lessonpath), "w")
    @file.write("Asker    : version #{Asker::VERSION}\n")
    @file.write("Filename : #{project.get(:lessonname)}\n")
    @file.write("Datetime : #{Time.new}\n\n")
  end

  def export_codes(codes)
    codes.each do |code|
      @file.write(FormatCode2Doc.new.call(code)) if code.process
    end
  end

  def export_concepts(concepts)
    concepts.each do |concept|
      @file.write(FormatConcept2Doc.new.call(concept)) if concept.process
    end
  end

  def export_problems(problems)
    problems.each do |problem|
      @file.write(FormatProblem2Doc.new(problem).call) if problem.process
    end
  end
end
