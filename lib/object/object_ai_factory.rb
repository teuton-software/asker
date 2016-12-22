
require_relative 'ai/ruby_code_ai'

module ObjectAIFactory
  def self.get(filename,type)
    case type
    when :rubycode
      return RubyCodeAI.new(filename)
    end
    nil
  end
end
