require_relative "asker/check_input"
require_relative "asker/skeleton"
require_relative "asker/start"

class Asker
  def self.init
    Skeleton.new.create_configuration
  end

  def self.create_input(dirpath)
    Skeleton.new.create_input(dirpath)
  end

  def self.check(filepath)
    CheckInput.new.check(filepath)
  end

  def self.start(filepath)
    Start.new.call(filepath)
  end
end
