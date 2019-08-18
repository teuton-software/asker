# frozen_string_literal: true

require 'singleton'

# Global parameters
class Application
  include Singleton

  def name
    'asker'
  end

  def version
    '2.0.0'
  end
end
