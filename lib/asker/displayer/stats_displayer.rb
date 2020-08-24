# frozen_string_literal: true

require_relative '../application'
require_relative 'concept_ai_displayer'
require_relative 'code_displayer'

# Display Stats on screen.
# * Display all "Concept AI"
# * Display all "Code"
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
  end
end
