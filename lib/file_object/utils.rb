
module Utils
  def self.load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end

  def self.clone_array(array)
    out = []
    array.each { |item| out << item.dup }
    out
  end
end
