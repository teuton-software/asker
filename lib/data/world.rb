
require_relative '../loader/image_url_loader'
require_relative '../project'

class World
  attr_reader :concepts, :filenames, :contexts, :image_urls

  def initialize(concepts, show_progress=true)
    find_neighbors_for_every_concept(concepts)

    @concepts   = {}
    @filenames  = []
    @contexts   = []
    @image_urls = {}

    concepts.each do |c|
      if c.process
        @concepts[c.name] = c
        @filenames << c.filename
        @contexts  << c.context
      end
    end
    @filenames.uniq!
    @contexts.uniq!

    threads = []
    concepts.each do |c|
      print('.') if show_progress
      # puts "[DEBUG] #{c.name}\n"
      # filter = [ c.name.clone ] + c.context.clone
      filter = c.name.clone
      threads << Thread.new { @image_urls[c.name] = ImageUrlLoader::load(filter) }
    end
    @contexts.each do |filter|
      print('.') if show_progress
      threads << Thread.new { @image_urls[ filter.join('.').to_s ] = ImageUrlLoader::load(filter) }
    end
    threads.each { |t| t.join } # wait for all threads to finish
    print("\n") if show_progress
  end

  def find_neighbors_for_every_concept(concepts)
    concepts.each do |i|
      concepts.each do |j|
        if (i.id!=j.id) then
          i.try_adding_neighbor(j)
          i.try_adding_references(j)
        end
      end
    end
  end

end
