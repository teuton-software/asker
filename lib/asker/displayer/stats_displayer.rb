# frozen_string_literal: true

require_relative "../application"
require_relative "concept_ai_displayer"
require_relative "code_displayer"
require_relative "problem_displayer"

module StatsDisplayer
  # Display Stats on screen.
  # * Display all "Concept AI"
  # * Display all "Code"
  # @param data (Hash) With concept_ai list and code list
  def self.show(data)
    return unless Application.instance.config['global']['show_mode']

    # show_final_results
    ConceptAIDisplayer.show(data[:concepts_ai])
    CodeDisplayer.show(data[:codes_ai])
    ProblemDisplayer.show(data[:problems])
  end
end
