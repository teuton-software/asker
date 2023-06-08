# frozen_string_literal: true

require "set"

# Define Question class
class Question
  attr_accessor :name     # Question name used as identification
  attr_accessor :comment  # Comments asociated
  attr_accessor :tags
  attr_accessor :lang     # Info used when export (YAML)
  attr_accessor :encode   # image base64 content used when export Moodle xml

  attr_accessor :text     # The real text of the question
  attr_accessor :feedback # Question feedbak
  attr_reader :type       # Question type: ;boolean, :choice, :match, :short

  attr_accessor :good     # The correct answer (types: boolean, choice)
  attr_accessor :bads     # Bads answers (type: choice)
  attr_accessor :matching # Matching answers (type: match)
  attr_accessor :ordering # Steps answer (type: ordering)
  attr_accessor :shorts   # Short answers (type: short)

  # @param type (Symbol) Question type: choice, match, boolean, short
  def initialize(type = :choice)
    reset(type)
  end

  # Reset attributes
  # @param type (Symbol) Question type: choice, match, boolean, short
  def reset(type = :choice)
    @name = ""
    @comment = ""
    @tags = Set.new
    @lang = nil
    @encode = :none

    @text = ""
    @feedback = nil
    @type = type

    @good = ""
    @bads = []
    @matching = []
    @ordering = []
    @shorts = []
    shuffle_on
  end

  def set_boolean
    @type = :boolean
  end

  def set_choice
    @type = :choice
  end

  def set_match
    @type = :match
  end

  def set_ordering
    @type = :ordering
    shuffle_off
  end

  def set_short
    @type = :short
  end

  def shuffle_off
    @shuffle = false
  end

  def shuffle_on
    @shuffle = true
  end

  def shuffle?
    @shuffle
  end
end
