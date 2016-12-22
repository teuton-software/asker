
require_relative 'ai/ruby_code_ai'

module ObjectAIFactory
  def self.get(data_object)
    type = data_object.type
    case type
    when :rubycode
      return RubyCodeAI.new(data_object)
    end
    nil
  end
end
