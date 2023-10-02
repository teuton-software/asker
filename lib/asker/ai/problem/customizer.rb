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
    value.to_s.to_i(2).to_s
  end

  def bin2hex(value)
    dec = bin2dec(value)
    dec2hex(dec)
  end

  def bin2oct(value)
    dec = bin2dec(value)
    dec2oct(dec)
  end

  def dec2bin(value)
    value.to_i.to_s(2)
  end

  def dec2hex(value)
    value.to_i.to_s(16)
  end

  def dec2oct(value)
    value.to_i.to_s(8).to_s
  end

  def hex2bin(value)
    dec = hex2dec(value)
    dec2bin(dec)
  end

  def hex2dec(value)
    value.to_s.to_i(16).to_s
  end

  def hex2oct(value)
    dec = hex2dec(value)
    dec2oct(dec)
  end

  def oct2bin(value)
    dec = oct2dec(value)
    dec2bin(dec)
  end

  def oct2dec(value)
    value.to_s.to_i(8).to_s
  end

  def oct2hex(value)
    dec = oct2dec(value)
    dec2hex(dec)
  end
end
