require_relative 'concept_ai_displayer'
require_relative 'code_displayer'

# Display Stats on screen.
module StatsDisplayer
  def self.show(data, show_mode)
    return if show_mode == :none

    # show_final_results
    ConceptAIDisplayer.show(data[:concepts_ai])
    CodeDisplayer.show(data[:codes])
  end
end
