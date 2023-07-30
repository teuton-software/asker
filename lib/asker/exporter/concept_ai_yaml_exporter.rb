require "yaml"
require_relative "../formatter/question_hash_formatter"

module ConceptAIYAMLExporter
  ##
  # Export array of ConceptAI objects from Project to YAML output file
  # @param concepts_ai (Array)
  # @param project (Project)
  def self.export_all(concepts_ai, project)
    questions = []
    concepts_ai.each do |concept_ai|
      questions += get_questions_from concept_ai
    end
    params = {lang: project.get(:lang),
              projectname: project.get(:projectname)}
    output = {params: params, questions: questions}

    yamlfile = File.open(project.get(:yamlpath), "w")
    yamlfile.write(output.to_yaml)
    yamlfile.close
  end

  private_class_method def self.get_questions_from(concept_ai)
    data = []
    return data unless concept_ai.concept.process?

    Application.instance.config["questions"]["stages"].each do |stage|
      concept_ai.questions[stage].each do |question|
        question.lang = concept_ai.concept.lang
        data << QuestionHashFormatter.to_hash(question)
      end
    end
    data
  end
end
