require_relative "../../logger"

class Customizer
  def initialize(problem)
    @problem = problem
  end

  def call(text:, custom:, type: nil)
    output = text.clone
    custom.each_pair { |oldvalue, newvalue| output.gsub!(oldvalue, newvalue) }

    if type.nil?
      return output
    elsif type == "formula"
      begin
        return eval(output).to_s
      rescue SyntaxError => e
        Logger.error "Problem.name = #{@problem.name}"
        Logger.error "Customizer: Wrong formula '#{text}' or wrong values '#{output}'"
        Logger.error e.to_s
        exit 1
      end
    else
      Logger.error "Customizer: Wrong answer type (#{type})"
      exit 1
    end
  end

  def min(*args)
    args.min
  end

  def max(*args)
    args.max
  end

  def bin2dec(value)
    value.to_s.to_i(2)
  end

  def dec2bin(value)
    value.to_i.to_s(2)
  end

  def dec2hex(value)
    value.to_i.to_s(16)
  end
end
