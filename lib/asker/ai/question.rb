# frozen_string_literal: true

require 'set'

# Define Question class
class Question
  attr_accessor :name     # Question name used as identification
  attr_accessor :comment  # Comments asociated
  attr_accessor :text     # The real text of the question
  attr_accessor :good     # The correct answer
  attr_accessor :bads     # Bads answers used by choice type question
  attr_accessor :matching # Matching answers used by match type question
  attr_accessor :shorts   # Short answers used by short type question
  attr_accessor :feedback # Question feedbak
  attr_reader   :type     # Question type: :choice, :match, :boolean, :short
  attr_accessor :tags
  attr_accessor :lang     # Info used when export (YAML)
  attr_accessor :encode   # image base64 content used when export Moodle xml

  # Initialize object
  # @param type (Symbol) Question type: choice, match, boolean, short
  def initialize(type = :choice)
    reset(type)
  end

  # Reset attributes
  # @param type (Symbol) Question type: choice, match, boolean, short
  # rubocop:disable Metrics/MethodLength
  def reset(type = :choice)
    @name = ''
    @comment = ''
    @text = ''
    @type = type
    @good = ''
    @bads = []
    @matching = []
    @shorts = []
    @feedback = nil
    shuffle_on
    @tags = Set.new
    @lang = nil
    @encode = :none
  end
  # rubocop:enable Metrics/MethodLength

  # Set choice type
  def set_choice
    @type = :choice
  end

  # Set match type
  def set_match
    @type = :match
  end

  # Set boolean type
  def set_boolean
    @type = :boolean
  end

  # Set short type
  def set_short
    @type = :short
  end

  # Set shuffle off
  def shuffle_off
    @shuffle = false
  end

  # Set shuffle on
  def shuffle_on
    @shuffle = true
  end

  # Return shuffle value
  def shuffle?
    @shuffle
  end
end
