require "haml"
require_relative "../logger"

module HamlLoader
  def self.load(filename)
    template = File.read(filename)
    begin
      # INFO <haml 5.1> 20221223
      haml_engine = Haml::Engine.new(template)
      # INFO <haml 6.1> 20221226
      # return Haml::Template.new { template }.render
    rescue => e
      Logger.warn "[ERROR] HamlLoader: Can't load <#{filename}> file!"
      Logger.warn "  => #{e}"
      exit 1
    end
    haml_engine.render
  end
end
