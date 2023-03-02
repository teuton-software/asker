require "haml"

module HamlLoader
  def self.load(filename)
    template = File.read(filename)
    begin
      # INFO <haml 5.1> 20221223
      haml_engine = Haml::Engine.new(template)
      # INFO <haml 6.1> 20221226
      # return Haml::Template.new { template }.render
    rescue => e
      puts "[ERROR] HamlLoader: Can't load <#{filename}> file!"
      puts "  => #{e}"
      exit 0
    end
    haml_engine.render
  end
end
