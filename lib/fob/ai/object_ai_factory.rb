
require_relative 'ruby_code_ai'
require_relative 'sql_code_ai'

module ObjectAIFactory
  def self.get(data_fob)
    type = data_fob.type
    case type
    when :rubycode
      return RubyCodeAI.new(data_fob)
    when :sqlcode
      return SQLCodeAI.new(data_fob)
    when :vagrantfile
      return RubyCodeAI.new(data_fob)
    end
    nil
  end
end
