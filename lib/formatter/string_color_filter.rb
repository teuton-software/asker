
require_relative '../project'

# Filter color output from text if needed
class StringColorFilter
  def self.filter(p_text)
    return p_text if Project.instance.get(:color_output)
    l_text = p_text.to_s.clone
    (0..50).each { |i| l_text.gsub!("\e[#{i}m", '') }
    l_text
  end
end
