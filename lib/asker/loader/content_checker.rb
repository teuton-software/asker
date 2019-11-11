
# UNDER DEVELOPMENT!
# Check input content file
module ContentChecker
  def self.load(filename)
    type = :none
    type = :haml if File.extname(filename).casecmp('.haml').zero?
    type = :xml if File.extname(filename).casecmp('.xml').zero?

    file_content = File.read(filename)
  end

  def self.check_haml_content(content)
    
  end
end
