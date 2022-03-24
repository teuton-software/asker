#!/usr/bin/ruby

require 'test/unit'
require_relative '../../lib/asker/loader/image_url_loader'

class ImageUrlLoaderTest < Test::Unit::TestCase

  def setup
    @filters  = [ 'obiwan', 'yoda', ['character', 'starwars'] ]
  end

  def test_load
    @filters.each do |filter|
      urls = ImageUrlLoader::load(filter)
      assert_equal Array, urls.class
      i = 0
      i = 20 if Application.instance.config['global']['internet'] == 'yes'
      assert_equal i, urls.size
    end
  end
end
