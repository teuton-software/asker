# UNDER DEVELOPMENT!!

require_relative "../logger"

module Rb2HamlExporter
  def self.export(filename)
    check_file filename
    rbcontent = File.read(filename)
    puts rbcontent
  end

  def self.check_file(filename)
    unless File.extname(filename).casecmp('.rb').zero?
      Logger.error "Rb2HamlExporter: File name error #{filename}"
      exit 1
    end
    unless File.exist? filename
      Logger.error "Rb2HamlExporter: File #{filename} not found!"
      exit 1
    end
  end

  class Map
  end

end

Rb2HamlExporter.export('docs/examples/home/rb/furniture.rb')
