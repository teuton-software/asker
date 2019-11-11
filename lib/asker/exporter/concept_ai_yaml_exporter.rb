# encoding: utf-8

require 'yaml'
require_relative '../project'
require_relative '../formatter/question_hash_formatter'

# Use to export data from ConceptIA to YAML format
module ConceptAIYAMLExporter
  def self.export_all(concepts_ai)
    questions = []
    concepts_ai.each do |concept_ai|
      questions += get_questions_from concept_ai
    end
    project = Project.instance
    params = { lang: project.get(:lang) ,
               projectname: project.get(:projectname) }
    output = { params: params, questions: questions }
    project.yamlfile.write(output.to_yaml)
  end

  def self.get_questions_from(concept_ai)
    data = []
    return data unless concept_ai.process?
    stages = Project.instance.stages
    stages.each_key do |stage|
      concept_ai.questions[stage].each do |question|
        question.lang = concept_ai.lang
        data << QuestionHashFormatter.to_hash(question)
      end
    end
    data
  end
end
