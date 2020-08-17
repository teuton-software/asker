# encoding: utf-8

require 'yaml'
require_relative '../formatter/question_hash_formatter'

# Use to export data from ConceptIA to YAML format
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
    params = { lang: project.get(:lang) ,
               projectname: project.get(:projectname) }
    output = { params: params, questions: questions }
    project.get(:yamlfile).write(output.to_yaml)
  end

  private_class_method def self.get_questions_from(concept_ai)
    data = []
    return data unless concept_ai.process?

    Application.instance.config['questions']['stages'].each do |stage|
      concept_ai.questions[stage].each do |question|
        question.lang = concept_ai.lang
        data << QuestionHashFormatter.to_hash(question)
      end
    end
    data
  end
end
