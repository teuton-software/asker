# frozen_string_literal: true

require 'singleton'
require_relative 'config'

# Global parameters
class Application
  include Singleton

  attr_reader :config

  def initialize
    load_config
  end

  def name
    'asker'
  end

  def version
    '2.0.0'
  end

  def load_config
    @config = {}
    unless File.exist? 'config.ini'
      @config = {}
      @config['global'] = {}
      @config['global']['load_data_from_internet'] = true
      @config['questions'] = {} 
      @config['questions']['exclude'] = []
      return
    end
    @config = Config.new('config.ini')
    exclude = @config['questions']['exclude']
    if exclude.nil?
      @config['questions']['exclude'] = []
    else
      @config['questions']['exclude'] = exclude.split(',')
    end
  end
end
