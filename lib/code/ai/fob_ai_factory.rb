
require_relative 'python_code_ai'
require_relative 'ruby_code_ai'
require_relative 'sql_code_ai'

module FOBAIFactory
  def self.get(data_fob)
    type = data_fob.type
    case type
    when :python
      return PythonCodeAI.new(data_fob)
    when :ruby
      return RubyCodeAI.new(data_fob)
    when :sqlcode
      return SQLCodeAI.new(data_fob)
    when :vagrantfile
      return RubyCodeAI.new(data_fob)
    else
      puts "[ERROR] <#{type}> is not valid type"
    end
    nil
  end
end
