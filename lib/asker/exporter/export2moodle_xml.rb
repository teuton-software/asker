require_relative "../application"
require_relative "../version"
require_relative "../formatter/question2moodle_xml"

class Export2MoodleXML
  def call(data, project)
    file = File.open(project.get(:moodlepath), "w")
    add_header(file, project)

    export_concepts(concepts: data[:concepts_ai], file: file)
    export_codes(codes: data[:codes_ai], file: file)
    export_problems(problems: data[:problems], file: file)

    close(file)
  end

  private

  def add_header(file, project)
    file.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
    file.write("<quiz>\n")
    file.write("<!--\n#{"=" * 50}\n")
    file.write(" #{Asker::NAME}    : version #{Asker::VERSION}\n")
    file.write(" Filename : #{project.get(:moodlename)}\n")
    file.write(" Datetime : #{Time.new}\n")
    file.write("#{"=" * 50}\n-->\n\n")
    file
  end

  def close(file)
    file.write("</quiz>\n")
    file.close
  end

  def export_concepts(concepts:, file:)
    concepts.each do |concept_ai|
      next unless concept_ai.concept.process?

      Application.instance.config["questions"]["stages"].each do |stage|
        concept_ai.questions[stage].each do |question|
          file.write(Question2MoodleXML.new.format(question))
        end
      end
    end
  end

  def export_codes(codes:, file:)
    codes.each do |code|
      next unless code.process?
      code.questions.each do |question|
        file.write Question2MoodleXML.new.format(question)
      end
    end
  end

  def export_problems(problems:, file:)
    problems.each do |problem|
      next unless problem.process?
      problem.questions.each do |question|
        file.write Question2MoodleXML.new.format(question)
      end
    end
  end
end
