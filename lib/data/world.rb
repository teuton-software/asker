
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
        @concepts << concept.name
        @filenames << concept.filename
        @contexts += concept.context
      end
    end
    @filenames.uniq!
    @contexts.uniq!

    list = @concepts + @contexts
    threads = []
    list.each do |name|
      print(".") if show_progress
      threads << Thread.new { @image_urls[name] = ImageUrlLoader::load(name) }
    end
    threads.each { |t| t.join } #wait for all threads to finish
    print("\n") if show_progress
  end

end
