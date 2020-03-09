
require 'rainbow'
require_relative 'javascript_code_ai'
require_relative 'python_code_ai'
require_relative 'ruby_code_ai'
require_relative 'sql_code_ai'

##
# CodeAI factory
module CodeAIFactory
  ##
  # Return CodeAI associated to Code.type
  # @param code (Code)
  # @return CodeAI
  def self.get(code)
    type = code.type
    case type
    when :javascript
      return JavascriptCodeAI.new(code)
    when :python
      return PythonCodeAI.new(code)
    when :ruby
      return RubyCodeAI.new(code)
    when :sql
      return SQLCodeAI.new(code)
    when :vagrantfile
      return RubyCodeAI.new(code)
    else
      puts Rainbow("[ERROR] <#{type}> is not valid type").red.bright
    end
    nil
  end
end
