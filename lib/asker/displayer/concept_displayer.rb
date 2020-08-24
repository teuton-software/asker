# frozen_string_literal: true

require_relative '../application'
require_relative '../formatter/concept_string_formatter'
require_relative '../logger'

# Show Concept Data on screen
module ConceptDisplayer
  ##
  # Show concepts on screen
  # @param concepts (Array) List of concept data
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.show(concepts)
    show_mode = Application.instance.config['global']['show_mode']
    return unless show_mode

    msg = "\n[INFO] Showing concept data (#{Rainbow(show_mode).bright})"
    Logger.verboseln msg
    case show_mode
    when 'resume'
      s = "* Concepts (#{concepts.count}): "
      concepts.each { |c| s += c.name + ', ' }
      Logger.verboseln s
    when 'default'
      # Only show Concepts with process attr true
      concepts.each do |c|
        Logger.verboseln ConceptStringFormatter.to_s(c) if c.process?
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
