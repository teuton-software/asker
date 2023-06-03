require_relative "../application"
require_relative '../version'
require_relative "../formatter/question_moodle_formatter"

module DataMoodleExporter
  def self.call(data, project)
    file = File.open(project.get(:moodlepath), 'w')
    file.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
    file.write("<quiz>\n")
    file.write("<!--\n#{('=' * 50)}\n")
    file.write(" Created by : #{Asker::NAME}")
    file.write(" (version #{Asker::VERSION})\n")
    file.write(" File       : #{project.get(:moodlename)}\n")
    file.write(" Time       : #{Time.new}\n")
    file.write("#{('=' * 50)}\n-->\n\n")

    export_concepts(concepts: data[:concepts_ai], file: file)
    export_codes(codes: data[:codes_ai], file: file)
    export_problems(problems: data[:problems], file: file)

    file.write("</quiz>\n")
    file.close
  end

  def self.export_concepts(concepts:, file:)
    concepts.each do |concept_ai|
      next unless concept_ai.concept.process?

      Application.instance.config['questions']['stages'].each do |stage|
        concept_ai.questions[stage].each do |question|
          file.write(QuestionMoodleFormatter.to_s(question))
        end
      end
    end
  end

  def self.export_codes(codes:, file:)
    codes.each do |code|
      next unless code.process?
      code.questions.each do |question|
        file.write QuestionMoodleFormatter.to_s(question)
      end
    end
  end

  def self.export_problems(problems: ,file:)
    problems.each do |problem|
      next unless problem.process?
      problem.questions.each do |question|
        file.write QuestionMoodleFormatter.to_s(question)
      end
    end
  end
end
