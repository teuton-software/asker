# encoding: utf-8
require 'singleton'

class Application
  include Singleton
  attr_reader :name, :version

  def initialize
    @name="darts-of-teacher"
    @version="0.4.1"
  end

end	

