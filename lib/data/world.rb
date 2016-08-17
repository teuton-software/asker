
require_relative '../loader/image_url_loader'
require_relative '../project'

class World
  attr_reader :concepts, :filenames, :contexts, :image_urls

  def initialize(concepts)
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

    @concepts.each do |concept|
      print(".")
      @image_urls[concept] = ImageUrlLoader::load(concept)
    end
    @contexts.each do |context|
      print(".")
      @image_urls[context] = ImageUrlLoader::load(context)
    end
    print("\n")
  end

end
