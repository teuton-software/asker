
require_relative '../project'

class StringColorFilter
  def self.filter(p_text)
    l_text = p_text.to_s.clone
    unless Project.instance.get(:color_output)
      (0..50).each { |i| l_text.gsub!("\e[#{i}m", '') }
    end
    l_text
  end
end
