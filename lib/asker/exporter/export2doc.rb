# frozen_string_literal: true

require_relative "../formatter/concept_doc_formatter"
require_relative "../version"

class Export2Doc
  def call(data, project)
    file_open(project)
    export_concepts(data[:concepts])
    @file.close
  end

  private

  def file_open(project)
    @file = File.new(project.get(:lessonpath), "w")
    @file.write("Asker    : version #{Asker::VERSION}\n")
    @file.write("Filename : #{project.get(:lessonname)}\n")
    @file.write("Datetime : #{Time.new}\n\n")
  end

  def export_concepts(concepts)
    concepts.each do |concept|
      @file.write(ConceptDocFormatter.to_s(concept)) if concept.process
    end
  end

  def export_problems(problems)
  end
end
