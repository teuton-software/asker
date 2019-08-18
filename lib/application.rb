# frozen_string_literal: true

require 'singleton'
require_relative 'config'

# Global parameters
class Application
  include Singleton

  attr_reader :config

  def initialize
    @config = Config.new('config.ini')
    exclude = @config['questions']['exclude']
    @config['questions']['exclude'] = [] if exclude.nil?
  end

  def name
    'asker'
  end

  def version
    '2.0.0'
  end
end
