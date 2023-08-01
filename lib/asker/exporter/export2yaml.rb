require "yaml"
require_relative "../formatter/question_hash_formatter"

class Export2YAML
  ##
  # Export array of ConceptAI objects from Project to YAML output file
  # @param concepts_ai (Array)
  # @param project (Project)
  def call(data, project)
    questions = []
    questions += get_questions_from_codes(data)
    questions += get_questions_from_concepts(data)
    questions += get_questions_from_problems(data)

    output = {
      lang: project.get(:lang_code),
      projectname: project.get(:projectname),
      questions: questions
    }

    yamlfile = File.open(project.get(:yamlpath), "w")
    yamlfile.write(output.to_yaml)
    yamlfile.close
  end

  private

  def get_questions_from_codes(data)
    questions = []
    data[:codes].each do |code|
      next unless code.process
      code.questions.each do |question|
        questions << QuestionHashFormatter.to_hash(question)
      end
    end
    questions
  end

  def get_questions_from_concepts(data)
    questions = []
    data[:concepts_ai].each do |concept_ai|
      questions += get_questions_from_concept concept_ai
    end
    questions
  end

  def get_questions_from_concept(concept_ai)
    questions = []
    return questions unless concept_ai.concept.process?

    Application.instance.config["questions"]["stages"].each do |stage|
      concept_ai.questions[stage].each do |question|
        question.lang = concept_ai.concept.lang
        questions << QuestionHashFormatter.to_hash(question)
      end
    end
    questions
  end

  def get_questions_from_problems(data)
    questions = []
    data[:problems].each do |problem|
      next unless problem.process
      problem.questions.each do |question|
        questions << QuestionHashFormatter.to_hash(question)
      end
    end
    questions
  end
end
