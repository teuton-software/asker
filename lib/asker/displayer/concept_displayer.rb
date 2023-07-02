require_relative "../application"
require_relative "../formatter/concept_string_formatter"
require_relative "../logger"

class ConceptDisplayer
  ##
  # Show concepts on screen
  # @param concepts (Array) List of concept data
  def call(concepts)
    return if concepts.nil? || concepts.size.zero?

    show_mode = Application.instance.config["global"]["show_mode"]
    return unless show_mode

    msg = "\n[INFO] Showing concept data (#{Rainbow(show_mode).bright})"
    Logger.verboseln msg
    case show_mode
    when "resume"
      names = concepts.map { |c| c.name }
      s = " * Concepts (#{names.count}): #{names.join(",")}"
      Logger.verboseln s
    when "default"
      # Only show Concepts with process attr true
      concepts.each do |c|
        Logger.verboseln ConceptStringFormatter.to_s(c) if c.process?
      end
    end
  end
end
