
require_relative '../loader/image_url_loader'
require_relative '../project'

class World
  attr_reader :concepts, :filenames, :contexts, :image_urls

  def initialize(concepts, show_progress=true)
    @concepts = []
    @filenames = []
    @contexts = []
    @image_urls = {}
    concepts.each do |concept|
      if concept.process then
        @concepts << concept
        @filenames << concept.filename
        @contexts << concept.context
      end
    end
    @filenames.uniq!
    @contexts.uniq!

    threads = []
    @concepts.each do |c|
      print(".") if show_progress
      filter = [ c.name ] + c.context
      threads << Thread.new { @image_urls[c.name] = ImageUrlLoader::load(filter) }
    end
    @contexts.each do |filter|
      print(".") if show_progress
      threads << Thread.new { @image_urls[ filter.join(".").to_s ] = ImageUrlLoader::load(filter) }
    end
    threads.each { |t| t.join } #wait for all threads to finish
    print("\n") if show_progress
  end

end
