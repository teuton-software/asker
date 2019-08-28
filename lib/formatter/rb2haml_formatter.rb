# UNDER DEVELOPMENT!!

module Rb2HamlExporter
  def self.export(filename)
    check_file filename
    rbcontent = File.read(filename)
    puts rbcontent
  end

  def self.check_file(filename)
    unless File.extname(filename).casecmp('.rb').zero?
      msg = "[ERROR] Rb2HamlExporter: File name error #{filename}"
      raise msg
    end
    unless File.exist? filename
      msg = "[ERROR] Rb2HamlExporter: File #{filename} not found!"
      raise msg
    end
  end

  class Map
  end

end

Rb2HamlExporter.export('docs/examples/home/rb/furniture.rb')
